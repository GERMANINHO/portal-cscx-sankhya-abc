# Fluxo MRR x Churn — CS/CX — Sankhya ABC Paulista (fluxo-mrr-x-churn-cscx-sankhya-abc-paulista)

**Versão:** 1.0  
**Atualizado em:** 10/02/2026  
**Objetivo:** padronizar a apuração mensal (carteira, variação, ganhos e perdas) do **MRR x Churn** usando o dashboard **CS - MRR** (Sankhya) + planilha de consolidação.

> Este repositório disponibiliza o fluxo em **HTML/CSS/JS puro** (estático), ideal para publicação via **GitHub Pages**.

---

## ✅ Quando usar
- Fechamento/validação mensal do **MRR** e entendimento de variação de carteira.
- Conferência do comparativo (2 meses) e detalhamento (1 mês) para alimentar planilha.
- Auditoria rápida de consistência: **Ganhos – Perdas** vs **variação do mês**.

---

## ⚡ Fatos rápidos (regras do processo)
- **Sempre começar com 2 meses** no filtro para obter o comparativo (base + variação).
- **Depois mudar para 1 mês** para detalhar e extrair as tabelas de **perdas** e **ganhos**.
- **Janeiro (regra prática):** analisar **Novembro + Dezembro** (últimos 2 meses).
- **Unidade padrão:** **83 — BP ABC PAULISTA** (ajuste se necessário).
- Conferência essencial: **(Mês atual - mês anterior)** precisa bater com o topo **Agregado/Perdido**.

---

## 🔗 Planilha de apoio
- **Abrir planilha — MRR x Churn:** (link dentro do fluxo / botão no site)

> Observação: o Hub deve apontar para o **GitHub Pages deste fluxo**; a planilha fica como link interno no fluxo.

---

## 🧭 Passo a passo (resumo do fluxo)
> O `index.html` do repositório traz o fluxo completo em 6 passos, com exemplos e check de conferência.

### 1) Ajustar filtro (2 meses)
- Defina **data inicial / final** do período de 2 meses (ex.: 01/11 a 31/12)
- Defina **Unidade 83**
- Clique em **Atualizar**

### 2) Lançar saldos no Excel/Planilha (base)
Com o filtro de 2 meses:
- Valor da carteira do mês 1
- Valor da carteira do mês 2
- Agregado/Perdido
- Crescimento

### 3) Conferir valores no gráfico (auditoria rápida)
- Compare o valor exibido no gráfico para cada mês com os valores lançados na planilha.
- Confirme também se **Agregado/Perdido** bate com **(mês2 - mês1)**.

### 4) Ajustar filtro (1 mês) para detalhamento
- Filtre apenas o mês que você vai detalhar (ex.: 01/12 a 31/12)
- Clique em **Atualizar**

### 5) Extrair Perdas do mês
- Vá em **CS - Perdas MRR**
- Abra a **Tabela de perdas reais**
- Copie/extraia para o Excel/Planilha

### 6) Extrair Ganhos do mês
- Vá em **CS - Ganhos MRR**
- Abra a **Tabela ganhos reais**
- Copie/extraia para o Excel/Planilha

---

## ✅ Validações e checks (não pular)
- **Check 1:** (Mês atual - mês anterior) = **Agregado/Perdido** (topo do dashboard).
- **Check 2:** valor do gráfico (coluna do mês) = valor base lançado na planilha.
- **Check 3 (fechamento):** após colar tabelas, compare **Ganhos** e **Perdas** do mês com a variação do comparativo.

---

## 📂 Estrutura do repositório
- `index.html`  
  Página do Fluxo MRR x Churn (passo a passo + exemplos + botão da planilha).
- (opcional) `assets/`  
  Imagens/prints utilizados no fluxo, se você decidir anexar.

---

## ▶️ Como rodar localmente

### Opção A) Abrir direto no navegador
Abra o `index.html` com duplo clique.

### Opção B) Subir servidor local (recomendado)
```bash
python -m http.server 5500
