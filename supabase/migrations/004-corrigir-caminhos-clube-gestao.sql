-- ============================================================================
-- PORTAL CS/CX — SANKHYA ABC PAULISTA
-- Migration 004: corrigir caminhos dos documentos do Clube de Gestão
--
-- Motivo:
-- Storage real: clube-de-gestao/<arquivo>
-- Banco atual:  clube-gestao/<arquivo>
-- ============================================================================

begin;

update public.documentos
set
  caminho_arquivo = regexp_replace(
    caminho_arquivo,
    '^clube-gestao/',
    'clube-de-gestao/'
  ),
  updated_at = now()
where modulo = 'clube-gestao'
  and caminho_arquivo like 'clube-gestao/%';

commit;

-- Conferência: os quatro registros devem retornar existe_no_storage = true.
select
  d.titulo,
  d.modulo,
  d.caminho_arquivo,
  (o.id is not null) as existe_no_storage
from public.documentos d
left join storage.objects o
  on o.bucket_id = d.bucket
 and o.name = d.caminho_arquivo
where d.modulo = 'clube-gestao'
order by d.titulo;

-- Resultado esperado:
-- 4 linhas
-- existe_no_storage = true em todas
-- ============================================================================
