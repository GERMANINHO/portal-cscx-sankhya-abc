# Fluxo AE — CS/CX — Sankhya ABC Paulista (fluxo-ae-cscx-sankhya-abc-paulista)

**Versão:** 1.1  
**Atualizado em:** 10/02/2026  
**Objetivo:** padronizar a execução do **Acompanhamento Evolutivo (AE)** no modelo atual (SenseData + Sankhya OM), usando um **fluxograma interativo** (HTML + SVG + CSS + JS puro) com **modais (pop-ups)** e **links de apoio**.

> Este fluxo reflete o modelo em que **Diagnóstico + Montagem do Plano** são realizados no **Sankhya OM (AE Novo)** e a etapa correspondente no **SenseData** é registrada como controle do playbook.

---

## 🌐 O que este projeto entrega

- Página única `index.html` com **diagrama interativo** (SVG).
- **Nós clicáveis** (Passo 1 a 5) que abrem **modais** com instruções, checklists e boas práticas.
- Acesso rápido ao **SenseData (Portfolio)** via botão.
- Projeto **100% estático**, ideal para **GitHub Pages** (sem build).

---

## ✅ Fluxo operacional (modelo atual)

### Passo 1 — Sankhya Matriz: CS - Acompanhamento Visita
- **Objetivo:** selecionar cliente e estratégia (com GR) antes de abrir playbook.
- **Caminho:** `Dashboards » Customer Success » CS - Acompanhamento Visita`
- **ID:** `br.com.sankhya.menu.adicional.nuDsb.1003.1`
- **Saída obrigatória:** cliente escolhido + motivo (vira **Categoria** no SenseData) + decisor/contato para agendamento.

### Passo 2 — SenseData: Agendamento + Preparação + Abertura (Plano de Trabalho)
- **Objetivo:** adicionar o playbook do AE, registrar agendamento e preparar a interação.
- **Campos essenciais:** contato, data/hora, previsão e **Categoria**.
- **Boa prática:** formalizar por e-mail/invite; na 1ª aplicação do modelo, **GR** na abertura.

### Passo 3 — Sankhya OM: CS - Acompanhamento Evolutivo (Novo)
- **Objetivo:** executar **Diagnóstico + Plano de Ação** no OM e gerar os entregáveis.
- **Caminho:** `Analytics AI » SankhyaMitraBI 04-04-2024 » CX » CS - Acompanhamento Evolutivo (Novo)`
- **ID:** `br.com.sankhya.analytics2.new.sc.t_4312.5.2265`
- **Saídas obrigatórias:** **CÓD. do Plano de Ação**, itens priorizados + próximos passos, **Excel do Plano** (quando aplicável).

### Passo 4 — SenseData: Diagnóstico e Montagem do Plano (atividade unificada)
- **Objetivo:** registrar/concluir a atividade no SenseData **após** executar o Passo 3 no OM.
- **Regra:** SenseData = controle de etapa; evidências/anexos ficam no **OM**.
- **Anexos obrigatórios (no OM):** Excel do Plano + **PDF do e-mail** (e demais evidências).

### Passo 5 — SenseData: Apresentação do Plano + Formalização + Follow-up
- **Objetivo:** apresentar plano, garantir decisores, formalizar e manter rotina de follow-up.
- **Campos essenciais no SenseData:** Categoria, Responsável, **Cód. do Plano de Ação (manual)**, anotações.
- **Formalização (obrigatória):** e-mail com resumo do acordado + anexos; anexar evidências no OM.

---

## 🔗 Links úteis
- **SenseData (Portfolio):** https://sankhya.sensedata.io/portfolio

---

## 🧾 Evidências e anexos (padrão)
**Sempre manter no OM (AE Novo):**
- Excel do Plano (quando aplicável)
- PDF do e-mail enviado ao cliente (evidência)
- Materiais extras (apresentações, prints, etc.) quando necessários

---

## ⌨️ Uso do fluxo (atalhos)
- Clique nos nós do diagrama para abrir o modal de cada passo.
- Acessibilidade: use **TAB** para focar nos nós e **Enter/Espaço** para abrir.
- Fechar modal: **ESC** ou clique fora.

---

## 🗂 Estrutura do projeto

```text
/ (raiz)
├── index.html
└── README.md
