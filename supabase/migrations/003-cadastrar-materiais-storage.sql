-- ============================================================================
-- PORTAL CS/CX — SANKHYA ABC PAULISTA
-- Migration 003: cadastro dos materiais já enviados ao Supabase Storage
--
-- Execute uma única vez em:
-- Supabase > SQL Editor > New query > colar tudo > Run
--
-- IMPORTANTE:
-- Os caminhos abaixo correspondem à organização mostrada no bucket:
-- documentos-internos/<modulo>/<arquivo>
-- ============================================================================

begin;

insert into public.documentos (
  titulo,
  descricao,
  modulo,
  bucket,
  caminho_arquivo,
  nome_original,
  mime_type,
  tamanho_bytes,
  versao,
  visibilidade,
  ativo
)
values
  ('AE Excel Classificação Próximos Passos', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-excel-classificacao-proximos-passos.png', 'ae-excel-classificacao-proximos-passos.png', 'image/png', 188301, '1.0', 'interno', true),
  ('AE Excel Cronograma Rony Visão Geral', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-excel-cronograma-rony-visao-geral.png', 'ae-excel-cronograma-rony-visao-geral.png', 'image/png', 183355, '1.0', 'interno', true),
  ('AE Excel Motivo', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-excel-motivo.png', 'ae-excel-motivo.png', 'image/png', 213458, '1.0', 'interno', true),
  ('AE Excel Passagem Status Endereço', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-excel-passagem-status-endereco.png', 'ae-excel-passagem-status-endereco.png', 'image/png', 233087, '1.0', 'interno', true),
  ('AE Guia Visual AE Novo', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-guia-visual-ae-novo.png', 'ae-guia-visual-ae-novo.png', 'image/png', 1468702, '1.0', 'interno', true),
  ('AE Guia Visual Cronograma Rony', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-guia-visual-cronograma-rony.png', 'ae-guia-visual-cronograma-rony.png', 'image/png', 1514904, '1.0', 'interno', true),
  ('AE Sankhya Guia CS', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-guia-cs.png', 'ae-sankhya-guia-cs.png', 'image/png', 106867, '1.0', 'interno', true),
  ('AE Sankhya Histórico AE', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-historico-ae.png', 'ae-sankhya-historico-ae.png', 'image/png', 92140, '1.0', 'interno', true),
  ('AE Sankhya Indicadores Terceiros', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-indicadores-terceiros.png', 'ae-sankhya-indicadores-terceiros.png', 'image/png', 123687, '1.0', 'interno', true),
  ('AE Sankhya Informações Cliente', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-informacoes-cliente.png', 'ae-sankhya-informacoes-cliente.png', 'image/png', 126615, '1.0', 'interno', true),
  ('AE Sankhya Plano Ação Anexos', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-plano-acao-anexos.png', 'ae-sankhya-plano-acao-anexos.png', 'image/png', 59699, '1.0', 'interno', true),
  ('AE Sankhya Plano Ação Detalhe', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-plano-acao-detalhe.png', 'ae-sankhya-plano-acao-detalhe.png', 'image/png', 107515, '1.0', 'interno', true),
  ('AE Sankhya Plano Ação Lista', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-plano-acao-lista.png', 'ae-sankhya-plano-acao-lista.png', 'image/png', 57050, '1.0', 'interno', true),
  ('AE Sankhya Visão Uso', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-sankhya-visao-uso.png', 'ae-sankhya-visao-uso.png', 'image/png', 127123, '1.0', 'interno', true),
  ('AE Segmentação Definição', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-segmentacao-definicao.png', 'ae-segmentacao-definicao.png', 'image/png', 69077, '1.0', 'interno', true),
  ('AE Segmentação Foco Estratégico', 'Material migrado do fluxo Acompanhamento Evolutivo.', 'ae', 'documentos-internos', 'ae/ae-segmentacao-foco-estrategico.png', 'ae-segmentacao-foco-estrategico.png', 'image/png', 57433, '1.0', 'interno', true),
  ('Manual Clube de Gestão Cliente', 'Material migrado do fluxo Clube de Gestão.', 'clube-gestao', 'documentos-internos', 'clube-gestao/manual-clube-de-gestao-cliente.docx', 'manual-clube-de-gestao-cliente.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 561366, '1.0', 'interno', true),
  ('Manual Clube de Gestão Interno', 'Material migrado do fluxo Clube de Gestão.', 'clube-gestao', 'documentos-internos', 'clube-gestao/manual-clube-de-gestao-interno.docx', 'manual-clube-de-gestao-interno.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 575610, '1.0', 'interno', true),
  ('Template Apresentação Clube de Gestão Cliente', 'Material migrado do fluxo Clube de Gestão.', 'clube-gestao', 'documentos-internos', 'clube-gestao/template-apresentacao-clube-de-gestao-cliente.pptx', 'template-apresentacao-clube-de-gestao-cliente.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 1481763, '1.0', 'interno', true),
  ('Template Apresentação Clube de Gestão Interno', 'Material migrado do fluxo Clube de Gestão.', 'clube-gestao', 'documentos-internos', 'clube-gestao/template-apresentacao-clube-de-gestao-interno.pptx', 'template-apresentacao-clube-de-gestao-interno.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 1627625, '1.0', 'interno', true),
  ('Configuração Gerente Online GOL Ex Villa', 'Material migrado do fluxo Gerente Online — GOL.', 'gol', 'documentos-internos', 'gol/configuracao-gerente-online-gol-ex-villa.pdf', 'configuracao-gerente-online-gol-ex-villa.pdf', 'application/pdf', 2479246, '1.0', 'interno', true),
  ('Apresentação Benefícios', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/apresentacao-beneficios.pdf', 'apresentacao-beneficios.pdf', 'application/pdf', 2202182, '1.0', 'interno', true),
  ('Apresentação Mindsight', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/apresentacao-mindsight.pdf', 'apresentacao-mindsight.pdf', 'application/pdf', 5120951, '1.0', 'interno', true),
  ('Apresentação Pessoas Mais', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/apresentacao-pessoas-mais.pdf', 'apresentacao-pessoas-mais.pdf', 'application/pdf', 6647488, '1.0', 'interno', true),
  ('Apresentação Pontotel', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/apresentacao-pontotel.pdf', 'apresentacao-pontotel.pdf', 'application/pdf', 7320146, '1.0', 'interno', true),
  ('Apresentação Vixting', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/apresentacao-vixting.pdf', 'apresentacao-vixting.pdf', 'application/pdf', 6058203, '1.0', 'interno', true),
  ('Cases Unidade ABC Paulista 2026', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/cases-unidade-abc-paulista-2026.pptx', 'cases-unidade-abc-paulista-2026.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 7797283, '1.0', 'interno', true),
  ('Imagem Sankhya Adquiridas', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/imagem-sankhya-adquiridas.png', 'imagem-sankhya-adquiridas.png', 'image/png', 95678, '1.0', 'interno', true),
  ('Sankhya Apresentação RH 2026 Completa', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/sankhya-apresentacao-rh-2026-completa.pptx', 'sankhya-apresentacao-rh-2026-completa.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 20272639, '1.0', 'interno', true),
  ('Sankhya Sign', 'Material migrado do fluxo Hub Geral.', 'hub-geral', 'documentos-internos', 'hub-geral/sankhya-sign.pdf', 'sankhya-sign.pdf', 'application/pdf', 2263600, '1.0', 'interno', true),
  ('NPS Blitz', 'Material migrado do fluxo Blitz NPS.', 'nps', 'documentos-internos', 'nps/nps-blitz.jpg', 'nps-blitz.jpg', 'image/jpeg', 259614, '1.0', 'interno', true),
  ('Tabela para Envio de E-mail aos Clientes', 'Material migrado do fluxo Blitz NPS.', 'nps', 'documentos-internos', 'nps/tabela-para-envio-de-email-aos-clientes.xlsx', 'tabela-para-envio-de-email-aos-clientes.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 13789, '1.0', 'interno', true),
  ('Fluxo OS RevOps Sankhya ABC Paulista', 'Material migrado do fluxo OS RevOps.', 'os-revops', 'documentos-internos', 'os-revops/fluxo-os-revops-sankhya-abc-paulista.pdf', 'fluxo-os-revops-sankhya-abc-paulista.pdf', 'application/pdf', 1023177, '1.0', 'interno', true)
on conflict (bucket, caminho_arquivo)
do update set
  titulo = excluded.titulo,
  descricao = excluded.descricao,
  modulo = excluded.modulo,
  nome_original = excluded.nome_original,
  mime_type = excluded.mime_type,
  tamanho_bytes = excluded.tamanho_bytes,
  versao = excluded.versao,
  visibilidade = excluded.visibilidade,
  ativo = excluded.ativo,
  updated_at = now();

commit;

-- Conferência por módulo.
select
  modulo,
  count(*) as quantidade
from public.documentos
where bucket = 'documentos-internos'
  and ativo = true
group by modulo
order by modulo;

-- Resultado esperado:
-- ae              | 16
-- clube-gestao    | 4
-- gol             | 1
-- hub-geral       | 9
-- nps             | 2
-- os-revops       | 1
--
-- Total esperado: 33 documentos
-- ============================================================================
