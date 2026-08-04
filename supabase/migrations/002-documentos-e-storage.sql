-- ============================================================================
-- PORTAL CS/CX — SANKHYA ABC PAULISTA
-- Migration 002: documentos e segurança do Supabase Storage
--
-- Executar em:
-- Supabase > SQL Editor > New query > colar tudo > Run
-- ============================================================================

begin;

-- ============================================================================
-- 1. TABELA DE DOCUMENTOS
-- ============================================================================

create table if not exists public.documentos (
  id uuid primary key default gen_random_uuid(),

  cliente_id uuid references public.clientes(id) on delete set null,

  titulo text not null,
  descricao text,
  modulo text not null,

  bucket text not null default 'documentos-internos',
  caminho_arquivo text not null,
  nome_original text not null,
  mime_type text,
  tamanho_bytes bigint check (tamanho_bytes is null or tamanho_bytes >= 0),

  versao text not null default '1.0',

  visibilidade text not null default 'interno'
    check (visibilidade in ('interno', 'gestao', 'administrador')),

  ativo boolean not null default true,

  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  unique (bucket, caminho_arquivo)
);

create index if not exists documentos_cliente_idx
  on public.documentos(cliente_id);

create index if not exists documentos_modulo_idx
  on public.documentos(modulo);

create index if not exists documentos_ativo_idx
  on public.documentos(ativo);

-- Metadados automáticos: usuário e data da alteração.
drop trigger if exists trg_documentos_metadata on public.documentos;
create trigger trg_documentos_metadata
before insert or update on public.documentos
for each row execute function public.set_record_metadata();

-- Auditoria automática.
drop trigger if exists trg_documentos_auditoria on public.documentos;
create trigger trg_documentos_auditoria
after insert or update or delete on public.documentos
for each row execute function public.registrar_auditoria();

-- ============================================================================
-- 2. RLS DA TABELA DOCUMENTOS
-- ============================================================================

alter table public.documentos enable row level security;

drop policy if exists "documentos_ler" on public.documentos;
create policy "documentos_ler"
on public.documentos
for select
to authenticated
using (
  public.usuario_aprovado()
  and ativo = true
  and (
    visibilidade = 'interno'
    or (
      visibilidade = 'gestao'
      and public.tem_perfil(array['gestao', 'administrador'])
    )
    or (
      visibilidade = 'administrador'
      and public.eh_administrador()
    )
  )
);

drop policy if exists "documentos_inserir" on public.documentos;
create policy "documentos_inserir"
on public.documentos
for insert
to authenticated
with check (
  public.pode_editar_operacao()
  and bucket = 'documentos-internos'
);

drop policy if exists "documentos_atualizar" on public.documentos;
create policy "documentos_atualizar"
on public.documentos
for update
to authenticated
using (public.pode_editar_operacao())
with check (
  public.pode_editar_operacao()
  and bucket = 'documentos-internos'
);

drop policy if exists "documentos_excluir" on public.documentos;
create policy "documentos_excluir"
on public.documentos
for delete
to authenticated
using (public.eh_administrador());

grant select, insert, update, delete
on public.documentos
to authenticated;

-- ============================================================================
-- 3. POLÍTICAS DO BUCKET PRIVADO documentos-internos
-- ============================================================================

-- Leitura e download:
-- qualquer usuário aprovado pode acessar os arquivos internos.
drop policy if exists "documentos_internos_ler" on storage.objects;
create policy "documentos_internos_ler"
on storage.objects
for select
to authenticated
using (
  bucket_id = 'documentos-internos'
  and public.usuario_aprovado()
);

-- Upload:
-- CS/CX, Gestão e Administrador.
drop policy if exists "documentos_internos_inserir" on storage.objects;
create policy "documentos_internos_inserir"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'documentos-internos'
  and public.pode_editar_operacao()
);

-- Substituição e renomeação:
-- CS/CX, Gestão e Administrador.
drop policy if exists "documentos_internos_atualizar" on storage.objects;
create policy "documentos_internos_atualizar"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'documentos-internos'
  and public.pode_editar_operacao()
)
with check (
  bucket_id = 'documentos-internos'
  and public.pode_editar_operacao()
);

-- Exclusão física:
-- somente Administrador.
drop policy if exists "documentos_internos_excluir" on storage.objects;
create policy "documentos_internos_excluir"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'documentos-internos'
  and public.eh_administrador()
);

commit;

-- ============================================================================
-- CONFERÊNCIA
-- ============================================================================

select
  'documentos' as item,
  count(*)::text as resultado
from public.documentos

union all

select
  'politicas_storage',
  count(*)::text
from pg_policies
where schemaname = 'storage'
  and tablename = 'objects'
  and policyname like 'documentos_internos_%';

-- Resultado esperado:
-- documentos          | 0
-- politicas_storage   | 4
-- ============================================================================
