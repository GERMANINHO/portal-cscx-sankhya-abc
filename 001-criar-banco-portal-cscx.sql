-- PORTAL CS/CX — SANKHYA ABC PAULISTA
-- Etapa 2: estrutura inicial do Supabase
-- Execute uma única vez em: Supabase > SQL Editor > New query > Run

begin;

create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create table if not exists public.perfis (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null default 'Usuário',
  email text not null,
  cargo text,
  perfil text not null default 'consulta'
    check (perfil in ('consulta', 'cscx', 'gestao', 'administrador')),
  status text not null default 'pendente'
    check (status in ('pendente', 'aprovado', 'rejeitado', 'bloqueado')),
  aprovado_em timestamptz,
  aprovado_por uuid references auth.users(id) on delete set null,
  ultimo_acesso_em timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists perfis_email_unique
  on public.perfis (lower(email));

create table if not exists public.solicitacoes_acesso (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references auth.users(id) on delete cascade,
  nome text not null,
  email text not null,
  perfil_solicitado text not null default 'cscx'
    check (perfil_solicitado in ('consulta', 'cscx', 'gestao', 'administrador')),
  justificativa text,
  status text not null default 'pendente'
    check (status in ('pendente', 'aprovada', 'rejeitada', 'cancelada')),
  analisada_em timestamptz,
  analisada_por uuid references auth.users(id) on delete set null,
  observacao_analise text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

drop trigger if exists trg_perfis_updated_at on public.perfis;
create trigger trg_perfis_updated_at
before update on public.perfis
for each row execute function public.set_updated_at();

drop trigger if exists trg_solicitacoes_updated_at on public.solicitacoes_acesso;
create trigger trg_solicitacoes_updated_at
before update on public.solicitacoes_acesso
for each row execute function public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_nome text;
  v_perfil text;
  v_justificativa text;
begin
  v_nome := coalesce(
    nullif(new.raw_user_meta_data ->> 'nome', ''),
    nullif(new.raw_user_meta_data ->> 'full_name', ''),
    split_part(coalesce(new.email, 'Usuário'), '@', 1)
  );

  v_perfil := coalesce(
    nullif(new.raw_user_meta_data ->> 'perfil_solicitado', ''),
    'cscx'
  );

  if v_perfil not in ('consulta', 'cscx', 'gestao', 'administrador') then
    v_perfil := 'cscx';
  end if;

  v_justificativa := nullif(new.raw_user_meta_data ->> 'justificativa', '');

  insert into public.perfis (id, nome, email, perfil, status)
  values (new.id, v_nome, coalesce(new.email, ''), 'consulta', 'pendente')
  on conflict (id) do nothing;

  insert into public.solicitacoes_acesso (
    user_id, nome, email, perfil_solicitado, justificativa, status
  )
  values (
    new.id, v_nome, coalesce(new.email, ''), v_perfil, v_justificativa, 'pendente'
  )
  on conflict (user_id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

create or replace function public.usuario_aprovado()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.perfis p
    where p.id = auth.uid() and p.status = 'aprovado'
  );
$$;

create or replace function public.perfil_atual()
returns text
language sql
stable
security definer
set search_path = ''
as $$
  select p.perfil
  from public.perfis p
  where p.id = auth.uid() and p.status = 'aprovado'
  limit 1;
$$;

create or replace function public.tem_perfil(perfis_permitidos text[])
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.perfis p
    where p.id = auth.uid()
      and p.status = 'aprovado'
      and p.perfil = any(perfis_permitidos)
  );
$$;

create or replace function public.pode_editar_operacao()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select public.tem_perfil(array['cscx', 'gestao', 'administrador']);
$$;

create or replace function public.eh_administrador()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select public.tem_perfil(array['administrador']);
$$;

create sequence if not exists public.clientes_codigo_seq start 1;

create table if not exists public.clientes (
  id uuid primary key default gen_random_uuid(),
  codigo_cliente text not null unique
    default ('CLI-' || lpad(nextval('public.clientes_codigo_seq')::text, 5, '0')),
  razao_social text not null,
  nome_fantasia text,
  segmento text,
  atividade_principal text,
  contrato text,
  jornada text,
  estrategia_objetivo text,
  fase text,
  mrr numeric(14,2) not null default 0 check (mrr >= 0),
  arr numeric(14,2) generated always as (mrr * 12) stored,
  data_registro date,
  responsavel_cs text,
  email_principal text,
  telefone_principal text,
  site text,
  linkedin text,
  observacoes text,
  ativo boolean not null default true,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.contatos (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  nome text not null,
  cargo text,
  email text,
  telefone text,
  decisor boolean not null default false,
  contato_principal boolean not null default false,
  ativo boolean not null default true,
  observacoes text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.cnpjs (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  cnpj text not null,
  razao_social text,
  tipo_unidade text check (tipo_unidade in ('matriz', 'filial', 'outra')),
  licenciada boolean not null default false,
  rollout boolean not null default false,
  observacoes text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (cliente_id, cnpj)
);

create table if not exists public.pendencias (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  titulo text not null,
  descricao text,
  categoria text,
  prioridade text not null default 'media'
    check (prioridade in ('baixa', 'media', 'alta', 'critica')),
  status text not null default 'aberta'
    check (status in ('aberta', 'em_andamento', 'aguardando_cliente', 'aguardando_interno', 'concluida', 'cancelada')),
  responsavel text,
  origem text,
  data_abertura date not null default current_date,
  prazo date,
  data_conclusao date,
  proximo_passo text,
  link_evidencia text,
  observacoes text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.historico_fup (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  pendencia_id uuid references public.pendencias(id) on delete set null,
  tipo_contato text,
  descricao text not null,
  data_contato timestamptz not null default now(),
  resultado text,
  proximo_fup date,
  responsavel text,
  link_evidencia text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.nps (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  data_resposta date,
  respondente text,
  nota integer check (nota between 0 and 10),
  justificativa text,
  diagnostico text,
  motivo_nota text,
  responsavel_plano text,
  proximo_passo text,
  prazo date,
  registro_plataforma text,
  atualizacao_painel text,
  status_tratativa text default 'nao_iniciada'
    check (status_tratativa in ('nao_iniciada', 'em_tratativa', 'concluida', 'nao_aplicavel')),
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.oportunidades (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  atividade text not null,
  responsavel text,
  data_inicio date,
  data_termino date,
  status text not null default 'aberta'
    check (status in ('aberta', 'em_andamento', 'ganha', 'perdida', 'cancelada')),
  valor_estimado numeric(14,2),
  observacao text,
  codigo_oportunidade text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.visitas (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  data_visita timestamptz,
  tipo text,
  objetivo text,
  participantes text,
  responsavel text,
  status text not null default 'agendada'
    check (status in ('agendada', 'realizada', 'reagendada', 'cancelada')),
  resumo text,
  proximos_passos text,
  link_evidencia text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.acompanhamentos_evolutivos (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  categoria text,
  data_agendamento timestamptz,
  data_realizacao timestamptz,
  codigo_plano_acao text,
  objetivo text,
  diagnostico text,
  plano_acao text,
  responsavel text,
  status text not null default 'planejado'
    check (status in ('planejado', 'agendado', 'em_execucao', 'apresentado', 'concluido', 'cancelado')),
  proximo_followup date,
  link_excel_plano text,
  link_evidencia text,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.comite_mudanca (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid not null references public.clientes(id) on delete cascade,
  data_entrada_risco date,
  risco_problema text not null,
  identificado_por text,
  data_comite date,
  participantes text,
  codigo_oportunidade text,
  status text not null default 'aberto'
    check (status in ('aberto', 'em_analise', 'plano_definido', 'resolvido', 'cancelado')),
  plano_acao text,
  responsavel text,
  prazo date,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.fluxos (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  nome text not null,
  categoria text not null default 'CS/CX',
  descricao text,
  url text not null,
  icone text,
  ordem integer not null default 0,
  ativo boolean not null default true,
  abrir_nova_aba boolean not null default false,
  created_by uuid references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_record_metadata()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.created_at := coalesce(new.created_at, now());
    new.created_by := coalesce(new.created_by, auth.uid());
  end if;
  new.updated_at := now();
  new.updated_by := auth.uid();
  return new;
end;
$$;

do $$
declare tabela text;
begin
  foreach tabela in array array[
    'clientes','contatos','cnpjs','pendencias','historico_fup','nps',
    'oportunidades','visitas','acompanhamentos_evolutivos','comite_mudanca','fluxos'
  ]
  loop
    execute format('drop trigger if exists trg_%I_metadata on public.%I', tabela, tabela);
    execute format(
      'create trigger trg_%I_metadata before insert or update on public.%I for each row execute function public.set_record_metadata()',
      tabela, tabela
    );
  end loop;
end $$;

create index if not exists contatos_cliente_idx on public.contatos(cliente_id);
create index if not exists cnpjs_cliente_idx on public.cnpjs(cliente_id);
create index if not exists pendencias_cliente_idx on public.pendencias(cliente_id);
create index if not exists pendencias_status_idx on public.pendencias(status);
create index if not exists pendencias_prazo_idx on public.pendencias(prazo);
create index if not exists fup_cliente_idx on public.historico_fup(cliente_id);
create index if not exists fup_pendencia_idx on public.historico_fup(pendencia_id);
create index if not exists nps_cliente_idx on public.nps(cliente_id);
create index if not exists oportunidades_cliente_idx on public.oportunidades(cliente_id);
create index if not exists visitas_cliente_idx on public.visitas(cliente_id);
create index if not exists ae_cliente_idx on public.acompanhamentos_evolutivos(cliente_id);
create index if not exists comite_cliente_idx on public.comite_mudanca(cliente_id);
create index if not exists fluxos_ordem_idx on public.fluxos(ordem);

create table if not exists public.historico_alteracoes (
  id bigint generated by default as identity primary key,
  tabela text not null,
  registro_id uuid,
  operacao text not null check (operacao in ('INSERT', 'UPDATE', 'DELETE')),
  usuario_id uuid references auth.users(id) on delete set null,
  dados_anteriores jsonb,
  dados_novos jsonb,
  criado_em timestamptz not null default now()
);

create or replace function public.registrar_auditoria()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare v_id uuid;
begin
  if tg_op = 'DELETE' then v_id := old.id; else v_id := new.id; end if;
  insert into public.historico_alteracoes (
    tabela, registro_id, operacao, usuario_id, dados_anteriores, dados_novos
  ) values (
    tg_table_name, v_id, tg_op, auth.uid(),
    case when tg_op in ('UPDATE','DELETE') then to_jsonb(old) else null end,
    case when tg_op in ('INSERT','UPDATE') then to_jsonb(new) else null end
  );
  if tg_op = 'DELETE' then return old; end if;
  return new;
end;
$$;

do $$
declare tabela text;
begin
  foreach tabela in array array[
    'perfis','solicitacoes_acesso','clientes','contatos','cnpjs','pendencias',
    'historico_fup','nps','oportunidades','visitas','acompanhamentos_evolutivos',
    'comite_mudanca','fluxos'
  ]
  loop
    execute format('drop trigger if exists trg_%I_auditoria on public.%I', tabela, tabela);
    execute format(
      'create trigger trg_%I_auditoria after insert or update or delete on public.%I for each row execute function public.registrar_auditoria()',
      tabela, tabela
    );
  end loop;
end $$;

alter table public.perfis enable row level security;
alter table public.solicitacoes_acesso enable row level security;
alter table public.clientes enable row level security;
alter table public.contatos enable row level security;
alter table public.cnpjs enable row level security;
alter table public.pendencias enable row level security;
alter table public.historico_fup enable row level security;
alter table public.nps enable row level security;
alter table public.oportunidades enable row level security;
alter table public.visitas enable row level security;
alter table public.acompanhamentos_evolutivos enable row level security;
alter table public.comite_mudanca enable row level security;
alter table public.fluxos enable row level security;
alter table public.historico_alteracoes enable row level security;

drop policy if exists "perfil_ler_proprio_ou_admin" on public.perfis;
create policy "perfil_ler_proprio_ou_admin"
on public.perfis for select to authenticated
using (id = auth.uid() or public.tem_perfil(array['gestao', 'administrador']));

drop policy if exists "perfil_admin_atualizar" on public.perfis;
create policy "perfil_admin_atualizar"
on public.perfis for update to authenticated
using (public.eh_administrador()) with check (public.eh_administrador());

drop policy if exists "solicitacao_ler_propria_ou_admin" on public.solicitacoes_acesso;
create policy "solicitacao_ler_propria_ou_admin"
on public.solicitacoes_acesso for select to authenticated
using (user_id = auth.uid() or public.tem_perfil(array['gestao', 'administrador']));

drop policy if exists "solicitacao_admin_atualizar" on public.solicitacoes_acesso;
create policy "solicitacao_admin_atualizar"
on public.solicitacoes_acesso for update to authenticated
using (public.eh_administrador()) with check (public.eh_administrador());

do $$
declare tabela text;
begin
  foreach tabela in array array[
    'clientes','contatos','cnpjs','pendencias','historico_fup','nps',
    'oportunidades','visitas','acompanhamentos_evolutivos','comite_mudanca','fluxos'
  ]
  loop
    execute format('drop policy if exists "operacao_ler" on public.%I', tabela);
    execute format('create policy "operacao_ler" on public.%I for select to authenticated using (public.usuario_aprovado())', tabela);
    execute format('drop policy if exists "operacao_inserir" on public.%I', tabela);
    execute format('create policy "operacao_inserir" on public.%I for insert to authenticated with check (public.pode_editar_operacao())', tabela);
    execute format('drop policy if exists "operacao_atualizar" on public.%I', tabela);
    execute format('create policy "operacao_atualizar" on public.%I for update to authenticated using (public.pode_editar_operacao()) with check (public.pode_editar_operacao())', tabela);
    execute format('drop policy if exists "operacao_excluir" on public.%I', tabela);
    execute format('create policy "operacao_excluir" on public.%I for delete to authenticated using (public.eh_administrador())', tabela);
  end loop;
end $$;

drop policy if exists "auditoria_gestao_ler" on public.historico_alteracoes;
create policy "auditoria_gestao_ler"
on public.historico_alteracoes for select to authenticated
using (public.tem_perfil(array['gestao', 'administrador']));

grant usage on schema public to authenticated;
grant select, update on public.perfis to authenticated;
grant select, update on public.solicitacoes_acesso to authenticated;
grant select, insert, update, delete on
  public.clientes,
  public.contatos,
  public.cnpjs,
  public.pendencias,
  public.historico_fup,
  public.nps,
  public.oportunidades,
  public.visitas,
  public.acompanhamentos_evolutivos,
  public.comite_mudanca,
  public.fluxos
to authenticated;
grant select on public.historico_alteracoes to authenticated;
grant usage, select on sequence public.clientes_codigo_seq to authenticated;
grant usage, select on all sequences in schema public to authenticated;
grant execute on function public.usuario_aprovado() to authenticated;
grant execute on function public.perfil_atual() to authenticated;
grant execute on function public.tem_perfil(text[]) to authenticated;
grant execute on function public.pode_editar_operacao() to authenticated;
grant execute on function public.eh_administrador() to authenticated;

insert into public.fluxos (slug, nome, categoria, descricao, url, ordem, ativo)
values
  ('ae', 'Fluxo AE', 'CS/CX', 'Acompanhamento Evolutivo.', 'https://germaninho.github.io/fluxo-ae-cscx-sankhya-abc-paulista/', 10, true),
  ('nps', 'Fluxo Blitz NPS', 'CS/CX', 'Rotina e acompanhamento de NPS.', 'https://germaninho.github.io/fluxo-nps-blitz-cscx-sankhya-abc-paulista/', 20, true),
  ('clube-gestao', 'Fluxo Clube de Gestão', 'CS/CX', 'Cadastro e aprovação de clientes no Clube de Gestão.', 'https://germaninho.github.io/fluxo-case-cscx-sankhya-abc-paulista/', 30, true),
  ('certificacao', 'Fluxo Certificação', 'CS/CX', 'Solicitação e acompanhamento de certificações.', 'https://germaninho.github.io/fluxo-certificacao/', 40, true),
  ('usuarios-temporarios', 'Fluxo de Usuários Temporários', 'Operação', 'Liberação temporária de usuários adicionais.', 'https://germaninho.github.io/fluxo-usuarios-temporarios-sankhya-abc-paulista/', 50, true),
  ('pendencias', 'Fluxo de Pendências', 'CS/CX', 'Triagem, registro e acompanhamento de pendências.', 'https://germaninho.github.io/fluxo-pendencias-cscx-sankhya-abc-paulista/', 60, true),
  ('mrr-churn', 'Fluxo MRR x Churn', 'Indicadores', 'Apuração mensal do MRR e churn.', 'https://germaninho.github.io/fluxo-mrr-x-churn-cscx-sankhya-abc-paulista/', 70, true),
  ('os-revops', 'Fluxo OS RevOps', 'Operação', 'Abertura e acompanhamento de OS RevOps.', 'https://germaninho.github.io/fluxo-os-revops-sankhya-abc-paulista/', 80, true),
  ('gol', 'Gerente Online — GOL', 'Operação', 'Manual de configuração do Gerente Online.', 'https://germaninho.github.io/fluxo-gerente-online-gol-sankhya-abc-paulista/', 90, true)
on conflict (slug) do update
set nome = excluded.nome,
    categoria = excluded.categoria,
    descricao = excluded.descricao,
    url = excluded.url,
    ordem = excluded.ordem,
    ativo = excluded.ativo,
    updated_at = now();

commit;

-- Resultado esperado: Success. No rows returned
-- Próximo passo: configurar Authentication e criar o primeiro usuário.
