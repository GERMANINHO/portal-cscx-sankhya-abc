# Fluxo — Solicitação de Liberação Temporária de Usuários Adicionais  
**CS/CX — Sankhya ABC Paulista** (fluxo-usuarios-temporarios-sankhya-abc-paulista)

**Versão:** 1.1  
**Atualizado em:** 10/02/2026  
**Objetivo:** padronizar a **solicitação por e-mail** para **liberação temporária de usuários adicionais** (apoio a consultor), reduzindo retrabalho e garantindo rastreabilidade (evidências + encerramento).

> Projeto **100% front-end** (HTML + SVG + CSS + JS puro). Ideal para publicar via **GitHub Pages**.

---

## 🌐 O que este projeto entrega

- Fluxograma **interativo** (SVG) com **5 passos** clicáveis (abre modais com instruções).
- **Modelo de e-mail** pronto para copiar e preencher (campos com ➡️).
- Botão para:
  - **Copiar modelo** para a área de transferência;
  - **Abrir o Gmail** com destinatário + assunto + corpo preenchidos (**não envia sozinho**).
- Checklists de revisão, evidências e encerramento (boas práticas do time).

---

## ✅ Canal e padrão do e-mail

- **Destinatário:** `centraldeprojetos@sankhya.com.br`  
- **Assunto padrão:** `LIBERAÇÃO DE USUÁRIOS: Apoio a Consultor`  
- **Corpo:** template com campos para preencher (dados do parceiro, contrato, usuários, prazo, justificativa e FAP).

> Importante: a página **não envia** o e-mail automaticamente — ela apenas prepara o conteúdo e abre o Gmail para você **revisar** e **enviar**.

---

## 🧭 Fluxo operacional (passo a passo)

### Passo 1 — Endereçar e-mail à Central
- Confirmar o canal correto (**Central de Projetos**).
- Usar o **assunto padrão** do fluxo.

### Passo 2 — Preencher o modelo do e-mail
- Abrir o modal do Passo 2 e:
  - clicar em **Copiar modelo** (para colar e editar), ou
  - clicar em **Abrir Gmail com o modelo** (compose pronto).

**Campos que não podem faltar (template):**
- Data da solicitação
- Parceiro / contato
- Modalidade do contrato (Evo / Evo por usuário / Padrão…)
- Quantos usuários em contrato + quantos liberar
- Se já foi bonificado anteriormente
- Nomes dos usuários Sankhya (como aparecem no sistema)
- Prazo desejado (com data final)
- Justificativa
- **Número FAP**
- Se é projeto inicial / segunda fase / demanda avulsa  
  - Se for projeto: etapa, GP, produção, go-live e conclusão

### Passo 3 — Revisar e enviar
Checklist rápido antes de enviar:
- Modalidade preenchida
- Quantidades claras (em contrato vs liberar)
- Nomes corretos dos usuários
- Prazo com data final explícita
- Justificativa objetiva
- FAP preenchido
- Se projeto: preencher bloco completo do projeto

### Passo 4 — Registrar evidências
Registrar no ticket/atendimento:
- Data/hora do envio
- Prazo solicitado
- Quantidade e nomes dos usuários
- Número FAP

Evidências:
- Print/PDF do e-mail enviado (ou manter a thread)
- Resposta/OK da Central (na mesma conversa)

### Passo 5 — Acompanhar e encerrar
- Se pedirem complementos: responder na **mesma thread** e atualizar o ticket.
- Se aprovado/liberado: registrar o “OK” e a **data final** acordada.
- Encerramento:
  1) confirmar com o cliente que foi aplicado e está funcional  
  2) garantir que a data final ficou registrada  
  3) agendar lembrete interno para retirada/desativação no fim do prazo  

> Boa prática: se o cliente precisar manter usuários adicionais, tratar como **regularização** (aquisição formal / alteração contratual).

---

## 🧱 Estrutura do projeto

```text
/ (raiz)
├── index.html   # página única com fluxograma + modais + botão Gmail + copiar template
└── README.md
