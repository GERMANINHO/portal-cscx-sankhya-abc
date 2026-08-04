# Portal CS/CX — Sankhya ABC Paulista

Portal web unificado com autenticação Supabase, Central de Clientes, documentos privados, fluxos internos e gestão de acessos.

## Etapa 04

- Login e perfis conectados ao Supabase.
- RLS e auditoria ativos.
- Central de Clientes conectada.
- 33 documentos registrados no Storage privado.
- Página de Documentos com pesquisa, filtro, abertura e download protegido.
- Fluxos abertos internamente no Portal.
- READMEs atuais renderizados como páginas internas.
- Rotas por `#`, compatíveis com GitHub Pages.

## Publicação

Substitua no repositório os arquivos e pastas correspondentes por este pacote e ative o GitHub Pages na branch `main`, pasta `/ (root)`.

## Segurança

O frontend contém apenas a URL e a Publishable Key do Supabase. Nunca publique Secret Key, `service_role`, senha do banco, JWT secret ou dados reais exportados.
