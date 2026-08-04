# Fluxo Certificação — CS/CX — Sankhya ABC Paulista (fluxo-certificacao)

**Versão:** 1.1  
**Atualizado em:** 10/02/2026  
**Objetivo:** padronizar a solicitação, validação e agendamento de certificações (**Usuário-chave**, **Gerenciais** e **Usuário Técnico/TI**), garantindo aderência ao contrato e o requisito obrigatório de **base de testes replicada do Produção**.

> Este repositório disponibiliza o fluxo em **HTML/CSS/JS puro** (estático), ideal para publicação via **GitHub Pages**.

---

## ✅ Fatos rápidos (leia antes de abrir qualquer solicitação)

- **Novo projeto:** solicitação via **Experience** (vinculação do projeto/gestões ocorre por lá).
- **Projeto de base / troca de usuário-chave / Usuário Técnico (TI):** solicitação via **Sanqueon** → **Solicitação de Matrículas Universidade**.
- **SLA Universidade (tratativa/validação da solicitação):** **até 5 dias úteis**.
- **Requisito mais crítico para agendar:** **base de testes replicada do Produção** (sem isso **não agenda**).
- **Agendamento:** Universidade agenda **direto com o cliente**; se não houver retorno, a **unidade faz a ponte**.
- **Elegibilidade:** só vale para clientes que possuem **Plataforma da Universidade no contrato** (contratos muito antigos podem não ter).

---

## 1) Pré-check (antes de abrir solicitação)

### 1.1 Conferir contrato
- O cliente possui **Plataforma da Universidade**?
- Quais **processos/gestões/módulos** estão incluídos?

### 1.2 Definir o tipo de certificação
- **Usuário-chave** (por processo/área)
- **Gerenciais**
- **Usuário Técnico / Certificação de TI** (equivale ao usuário técnico)

### 1.3 Garantir contato do líder do projeto
- **Nome**, **e-mail** e principalmente **telefone** do líder (isso destrava o agendamento).

### 1.4 Alinhar base de testes (obrigatório)
- Reforçar com o cliente desde o início: precisa ser **replicada do Produção**.

---

## 2) Decisão: por onde abrir a solicitação

| Cenário | Onde abrir | Observações |
|---|---|---|
| **Novo projeto** | **Experience** | Vinculação ocorre por lá. **Gerenciais** normalmente já entram via Experience. |
| **Projeto de base / troca de usuário-chave** | **Sanqueon → Solicitação de Matrículas Universidade** | Universidade valida/trata em até **5 dias úteis**. |
| **Usuário Técnico / Certificação de TI** | **Sanqueon → Solicitação de Matrículas Universidade** | Em geral **1 técnico por empresa** (salvo compra adicional). Certifica o que está no contrato. |

---

## 3) Sanqueon — como preencher “Solicitação de Matrículas Universidade”

> Baseado no manual interno **“Solicitação de Matrículas Universidade (V03)”**.

### Passo a passo
1. Acessar a tela **Solicitação de Matrículas Universidade** e clicar em **Novo Registro**.
2. Preencher **Dados do Parceiro** e **Salvar**.
3. Após salvar, **anexar** o documento **“1.3 - Definição da Equipe do Projeto (Versão 01)”** (quando aplicável).

### Aba **Contatos** (usuários a habilitar)
- **Cód. Contato** (precisa estar **Ativo** em Parceiros)
- **Perfil Contato**
  - **Dono do Processo** (acompanhado pela unidade) ou
  - **Usuário Adicional** (habilitado pela Universidade)
- **Tipo Usuário Adicional:** **Chave** ou **Líder**
- **Qtd. Área Gestão** (conforme contrato)

#### Regra operacional (boa prática)
- **2 habilitações por área de gestão**
  - Ex.: **1 Dono do Processo + 1 Usuário Adicional**
  - ou **1 Chave por área + 1 Líder** para todas as áreas do contrato

### Aba **Áreas de Gestão** (registrar a área por usuário)
- **Tipo de Habilitação:**
  - **Análise de aprendizagem** (usuários do projeto)
  - **Quiz** (cliente de base que já tem conhecimento)
  - **Unidade** (para Dono do Processo)
  - **Sequência de Habilitações** (quando for Líder)

### Resultado esperado
- Após validação, os usuários recebem (via B.I.) link/instruções para criar ID e acessar.

### Atenções (evitam retrabalho)
- A tela é de **inclusão**: **não dá para editar após salvar**. Validar tudo antes.
- Não é possível registrar o **mesmo contato 2 vezes**; se a mesma pessoa precisar “papéis” diferentes, abrir **duas solicitações**.
- Sempre conferir contrato para não incluir **gestões** que o cliente **não possui**.

---

## 4) Agendamento e execução (Universidade)

### Checklist para agendar
- ✅ Confirmar **base de testes replicada do Produção**
- ✅ Ter em mãos:
  - **Cliente**
  - **Tipo** (chave/gerencial/técnico)
  - **Link e credenciais** da base
  - **Contato do líder** (nome + telefone)

### Regra de operação
- Universidade valida e agenda com o cliente.
- Sem retorno do cliente: Universidade retorna para a **unidade** pedindo **ponte**.

---

## 📌 Templates (copiar e colar)

### Para o cliente (base de testes)
Olá! Para iniciarmos a certificação, precisamos de uma **base de testes replicada do seu ambiente de produção**.  
Quando estiver pronta, me envie **link de acesso** e **senha** (ou usuário/senha) e o **telefone/e-mail do líder do projeto** para agendamento.

### Para a Universidade (agendamento)
Olá, time Universidade. Solicito agendamento de certificação para o cliente **[NOME]**.  
Solicitação já tratada/aprovada. Seguem acesso da base de testes replicada: **[LINK] | [USUÁRIO] | [SENHA]**.  
Contato do líder do projeto: **[NOME/TELEFONE]**. Tipo: **[Chave/Gerencial/Técnico]**. Obrigado.

---

## 🧭 Fluxo em diagrama (Mermaid)

```mermaid
flowchart TD
  A((Início)) --> B[Pré-check: contrato • tipo • contatos • base de testes]
  B --> C{Qual cenário?}

  C -->|Novo projeto| D[Solicitar via Experience]
  C -->|Base / Troca de usuário-chave / Usuário Técnico| E[Solicitar via Sanqueon<br/>Solicitação de Matrículas Universidade]

  D --> F[Universidade vincula/trata]
  E --> G[Universidade valida a solicitação<br/>SLA até 5 dias úteis]

  F --> H{Base de testes replicada do Produção?}
  G --> H

  H -->|Não| I[Orientar cliente a preparar base replicada]
  I --> H

  H -->|Sim| J[Enviar link + credenciais + contato do líder<br/>para a Universidade]
  J --> K[Universidade agenda direto com o cliente]
  K --> L{Cliente responde?}

  L -->|Sim| M[Agenda confirmada e execução]
  L -->|Não| N[Universidade pede ponte à unidade]
  N --> M

  M --> O((Fim))
