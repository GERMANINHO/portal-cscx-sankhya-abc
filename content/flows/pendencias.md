# Fluxo de Pendências — CS/CX — Sankhya ABC Paulista  
(fluxo-pendencias-cscx-sankhya-abc-paulista)

**Versão:** 1.1  
**Atualizado em:** 10/02/2026  
**Objetivo:** padronizar a **triagem, organização, agenda e acompanhamento** das pendências do time de CS/CX da **Sankhya ABC Paulista**, usando um **fluxograma interativo** (HTML + SVG + CSS + JS puro) com **modais** e **links diretos** para as ferramentas do dia a dia.

> Projeto **100% front-end** (estático), pronto para **GitHub Pages**. Sem backend e sem armazenamento de dados.

---

## 🌐 O que este projeto entrega

- `index.html` único (autocontido) com **fluxograma em SVG**.
- **Nós clicáveis** que abrem **modais (pop-ups)** com instruções e atalhos:
  - **Registrar demandas** (abre a Carteira/aba correta)
  - **Agendar/alinhar com Rogério Furian** (atalhos de agenda)
  - **Fluxo FUP** (como usar o Excel atual + link da planilha)
- **Links diretos** para:
  - Carteira ABC Paulista (Google Sheets)
  - Agenda do Rogério (Google Calendar)
  - Sua agenda (Google Calendar)
  - Planilha do FUP (Google Sheets)
- **Acessibilidade**:
  - Navegação por teclado (TAB)
  - **Enter/Espaço** abre modal
  - **ESC** fecha modal
  - Ao fechar, o foco retorna ao nó original

---

## 🧭 Fluxo operacional (como usar)

O fluxograma foi pensado para ser executado nessa ordem (com ramificação para FUP):

### Linha 1 — Triagem e organização
1) **Registrar demandas** *(modal)*  
   - Abre a **Carteira ABC Paulista** e orienta registrar/atualizar pendências na aba da empresa.

2) **Consultar/atualizar carteira ABC Paulista no Google Sheets** *(link direto)*  
   - Acesso rápido para consulta e atualização contínua da carteira.

3) **Agendar/alinhar atividades com Rogério Furian** *(modal)*  
   - Atalhos para:
     - **Adicionar agenda do Rogério**
     - **Abrir sua agenda do Google**
   - Boa prática: incluir responsáveis, prazos e links de apoio no compromisso.

### Linha 2 — Acompanhamento e execução contínua
4) **Registrar status e próximos marcos**  
   - Consolidar o que foi feito, o que falta e qual o próximo passo (marco).

5) **Monitorar continuamente pelo time de Customer Success**  
   - Rotina de follow-up e revisão periódica até conclusão.

### Ramificação — Fluxo FUP (separado, mas integrado ao acompanhamento)
**FLUXO FUP** *(modal)* — “como usar no Excel atual”  
- Orienta como controlar cadência e comunicação **sem criar novas abas/colunas**, usando:
  - **Resumo pendencias** (placar por empresa / status macro / reprogramação)
  - **Atividades Operac. › PENDÊNCIA** (compromisso técnico: responsável direto + data limite)
  - **Meses (Jan…Dez)** (timeline dos toques: prioridade, descrição e status do toque)
- Inclui:
  - vocabulário de status (macro x toque)
  - cadência sugerida (P1/P2/P3)
  - botão para **Abrir planilha do FUP**

### Fim
- Nó “Fim” marca a conclusão do fluxo (visual/operacional).

---

## 🔗 Links (atalhos do fluxo)

- **Carteira ABC Paulista — Triagem (aba/guia de pendências):**  
  https://docs.google.com/spreadsheets/d/1Q5yMDzWXTsXY8uEi80FEA_UssI9wyC9q/edit?gid=292230500#gid=292230500

- **Carteira ABC Paulista — Consulta/atualização:**  
  https://docs.google.com/spreadsheets/d/1Q5yMDzWXTsXY8uEi80FEA_UssI9wyC9q/edit?gid=259369935#gid=259369935

- **Adicionar agenda do Rogério Furian:**  
  https://calendar.google.com/calendar/u/0?cid=cm9nZXJpby5zb3JjaUBzYW5raHlhLmNvbS5icg

- **Abrir minha agenda (Google Calendar):**  
  https://calendar.google.com/calendar/u/2/r

- **Planilha do FUP:**  
  https://docs.google.com/spreadsheets/d/1sryDU-V5PvDq-zAbavGddmEMh0n-LbS8/edit?gid=1806435204#gid=1806435204

> Observação: alguns links podem exigir login/permissões corporativas (Google Workspace / Sankhya).

---

## 🧱 Estrutura do projeto

```text
/ (raiz do repositório)
├── index.html   # arquivo único: SVG do fluxo + estilos + scripts + modais
└── README.md
