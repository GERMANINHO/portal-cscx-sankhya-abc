# Portal CS/CX — Sankhya ABC Paulista

Portal web unificado para centralizar clientes, pendências, indicadores, fluxos, documentos e gestão de acessos do time de CS/CX da Sankhya ABC Paulista.

## Arquitetura inicial

- Front-end estático em HTML, CSS e JavaScript.
- Autenticação, banco e políticas de acesso no Supabase.
- Documentos internos e evidências em buckets privados do Supabase Storage.
- Publicação pelo GitHub Pages.

## Segurança

Este repositório é público e deve conter somente código e materiais públicos da interface.

Nunca versionar:

- senhas;
- chaves secretas ou `service_role`;
- dados reais de clientes;
- backups;
- PPTX, PDF, DOCX e XLSX internos;
- evidências de atendimento.

A chave `publishable` do Supabase pode existir no front-end; o acesso aos dados é controlado por autenticação e Row Level Security.

## Estrutura

```text
/
├── index.html
├── js/
│   └── config.js
├── supabase/
│   └── migrations/
└── docs/
```

## Execução local

```bash
python -m http.server 5500
```

Acesse `http://localhost:5500`.

## Estado atual

- Login Supabase ativo.
- Perfil administrador aprovado.
- Banco inicial criado.
- Central de Clientes e catálogo de fluxos conectados.
- Próxima fase: migrar os fluxos antigos para páginas internas e cadastrar documentos no Storage privado.
