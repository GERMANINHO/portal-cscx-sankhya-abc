# Fluxo Case — CS/CX Sankhya ABC Paulista

Fluxograma interativo (HTML + SVG + CSS + JS puro) que **organiza** o processo de seleção, construção e registro de **CASES de clientes** da **Sankhya ABC Paulista**.

O projeto é **autocontido** (um único `index.html`) e pode ser publicado diretamente via **GitHub Pages**, servindo como guia operacional do time de CS/CX para gerar provas sociais consistentes, alinhadas com a **Central de Sucesso do Cliente** e com o **Marketing**.

---

## 🔎 Visão geral

- **Objetivo principal**  
  Transformar bons resultados de clientes em **prova social estruturada** (CASE), passando por:
  1. Seleção do cliente certo;
  2. Análise de uso e resultados;
  3. Escolha do tipo de CASE;
  4. Construção da narrativa;
  5. Registro formal no **SenseData**;
  6. Aprovação, publicação e incentivos (Winner Circle, etc.).

- **Tecnologia**  
  - **HTML5 + SVG**: desenho do fluxograma (Início, etapas, setas, Fim);
  - **CSS3**: layout, tipografia, tema claro e **animação “pulse”** nas caixas;
  - **JavaScript vanilla**: abertura/fechamento de modais, foco, teclado.

- **Design do fluxo**  
  - Nó **Início** → seis nós principais → nó **Fim**;
  - Caixas **verdes** para etapas:
    - Selecionar cliente candidato ao CASE  
    - Analisar uso e resultados  
    - Definir tipo de CASE  
    - Construir narrativa do depoimento  
    - Registrar CASE e enviar para triagem  
    - Aprovação, publicação no OM e incentivos
  - Setas conectando as etapas de forma intuitiva.

- **Acessibilidade**  
  - Cada caixa é focável via teclado (`tabindex="0"`);
  - **Enter/Espaço** abrem o modal; **Esc** fecha;
  - Ao fechar, o foco volta para a caixa que abriu o modal;
  - Modais usam `role="dialog"` e rótulos ARIA (`aria-labelledby`, `aria-modal`).

---

## 🧭 Como usar (fluxo operacional)

O fluxograma representa o caminho **fim a fim** de um CASE, da escolha do cliente até a publicação e incentivos.

Cada caixa abre um **modal** com orientações detalhadas.

---

### 0. Início

- Ponto de partida do fluxograma.
- Indica que você está iniciando o processo de **construção de um CASE** para um cliente da carteira.

---

### 1. Selecionar cliente candidato ao CASE

**Nó:** `Selecionar cliente candidato ao CASE`  
**Modal:** `Selecionar cliente candidato ao CASE`

- **Objetivo:**  
  Garantir que o cliente é elegível e tem alto potencial de prova social.

- **Principais critérios (checklist):**
  - Cliente **não foi chamado para CASE** no ano vigente;
  - Não possui **CASE publicado nos últimos 12 meses**;
  - AE recente com **plano de evolução concluído** e documentação anexada;
  - Cliente **adimplente** (sem mensalidades em atraso);
  - Sem **reclamações recentes** (últimos meses) pendentes de tratamento.

- **Fontes de informação sugeridas no modal:**
  - **Analytics AI / SankhyaMitraBI**  
    - Ex.: painel **CS - Acompanhamento Evolutivo (Novo)** para validar AE e plano de evolução;
  - **SenseData / Health Score**  
    - Saúde do cliente, histórico de contatos, sinalizações;
  - **Financeiro / Cobrança**  
    - Situação de pagamento e eventuais pendências.

> Só avance no fluxo se o cliente estiver **totalmente elegível**.

---

### 2. Analisar uso e resultados

**Nó:** `Analisar uso e resultados`  
**Modal:** `Analisar uso e resultados`

- **Objetivo:**  
  Comprovar que o cliente **evoluiu** com a solução Sankhya.

- **1. Uso da solução**
  - Acessar o dashboard **“CS - Dados de Uso NEW”**  
    (ex.: `Dashboards > Customer Success > CS - Dados de Uso NEW`, ID citado no modal);
  - Avaliar:
    - Total de acessos, quantidade de usuários e **média de acessos**;
    - **Adoção WEB x MGE**;
    - **Adoção por módulo**.

- **2. Resultados de negócio**
  - Quando o uso ainda é baixo, o CASE pode focar em resultados como:
    - **Vendas / MRR**: aumento de faturamento, upsell, novos contratos;
    - **Serviços**: projetos concluídos, ganhos de produtividade, acuracidade, qualidade etc.;
    - Outras evidências concretas de valor.

> A narrativa do CASE depois vai **se apoiar nesses dados** de uso e resultados.

---

### 3. Definir tipo de CASE

**Nó:** `Definir tipo de CASE`  
**Modal:** `Definir tipo de CASE`

- **Objetivo:**  
  Escolher o formato mais adequado de prova social para aquele cliente.

- **Depoimentos (conceito geral):**
  - Declarações que descrevem satisfação, evolução e valor gerado com a solução Sankhya;
  - Podem ser apresentados em **vídeo** ou **texto** (e-mail/carta).

- ⚠️ **Importante:**  
  Depoimentos por **WhatsApp** não são mais aceitos como CASE.

- **Tipos de CASE descritos no modal:**
  1. **Case por e-mail**
     - Texto estruturado pelo cliente (ou com ajuda do CS);
     - Preferencialmente enviado por **e-mail corporativo** ou em **papel timbrado**;
     - Deve conter contexto, ganhos, evolução e percepção da equipe.
  2. **Sala do Cliente (vídeo remoto)**
     - Gravação remota conduzida por **Marketing** + Sucesso do Cliente;
     - Seleção e convite do cliente feitos pela unidade;
     - Sem custo para a unidade, mas depende da agenda e estratégia do Marketing;
     - Exige cuidado com **consentimento de uso de imagem**.
  3. **Vídeo Case profissional**
     - Gravação presencial com equipe profissional;
     - Estratégia, logística e custos definidos pela **Matriz / Marketing**;
     - Se a unidade quiser iniciativa própria, deve alinhar com a Matriz e custear.

---

### 4. Construir narrativa do depoimento

**Nó:** `Construir narrativa do depoimento`  
**Modal:** `Construir narrativa do depoimento`

- **Objetivo:**  
  Garantir que todo CASE **tangibilize o valor gerado** pela Sankhya, e não seja só um elogio solto.

- **Elementos obrigatórios do CASE:**
  - **Dor inicial do cliente**  
    Qual problema ou desafio motivou a busca por solução?
  - **Solução proposta**  
    Como a Sankhya (produto + serviços) endereçou essa dor?
  - **Valor percebido**  
    Ganhos concretos (governança, produtividade, acuracidade, faturamento, etc.).
  - **Satisfação com a experiência**  
    Percepção sobre implantação, suporte, parceria com BP/unidade.
  - **Evolução do cliente**  
    Aumento de uso de módulos, crescimento de vendas, melhoria de Health Score etc.

- **Coerência com dados:**
  - Narrativa deve bater com:
    - Painel **CS - Dados de Uso NEW**;
    - Indicadores de **negócio** (MRR, vendas, serviços);
    - Registros de ações no **SenseData**.

> O foco é mostrar a **transformação** do cliente, conectando história + dados.

---

### 5. Registrar CASE no SenseData

**Nó:** `Registrar CASE e enviar para triagem`  
**Modal:** `Registrar CASE no SenseData`

- **Objetivo:**  
  Formalizar o CASE para análise da **Central de Sucesso do Cliente**.

- **Premissas de elegibilidade (reforço):**
  - Cliente sem reclamações nos últimos meses, com históricos antigos resolvidos;
  - Sem mensalidades em atraso;
  - AE com **apresentação do plano de evolução** concluída e anexada (últimos 12 meses);
  - No máximo **um novo CASE por cliente a cada 12 meses**.

- **Registro no SenseData:**
  - O modal orienta:
    - Quais campos preencher;
    - Como linkar com o playbook de AE;
    - Como evidenciar dados e anexos de suporte.

- **Prazos:**
  - Para contar no mês, o registro deve ser feito até as **17h do dia 26**;
  - Após essa data, o CASE entra na contagem do mês seguinte;
  - Ex.: CASEs enviados em janeiro contam para a **meta de fevereiro**.

- **Ação rápida no modal:**
  - Botão **“Abrir SenseData”** (`id="link-sensedata"`)  
    Abre `https://sankhya.sensedata.io/portfolio` em nova aba e fecha o modal.

---

### 6. Aprovação, publicação e incentivos

**Nó:** `Aprovação, publicação no OM e incentivos`  
**Modal:** `Aprovação, publicação e incentivos`

- **Aprovação e cadastro no Sankhya OM:**
  - Após aprovação pela **Central de Sucesso do Cliente**, a Matriz:
    - Valida conteúdo, forma e evidências;
    - Cadastra o CASE na tela **CASE** do Sankhya OM;
    - Alinha com Marketing os desdobramentos (e-mail, Sala do Cliente, Vídeo Case etc.).

- **Campanha de incentivo (Winner Circle):**
  - O modal detalha como os CASEs alimentam a **campanha de incentivo**:
    - Pontos aceleradores conforme percentual de carteira com CASE;
    - Ranking de CS/GR mais engajados;
    - Vouchers/premiações financeiras;
    - Benefícios para clientes finalistas (ex.: participação em eventos como Sankhya Connection);
    - Critérios de desempate na meta geral de Sucesso do Cliente.

> Em resumo: o CASE bem construído gera **reconhecimento para o cliente**, para o CS/GR e para a unidade.

---

### Fim

- Marca a **conclusão** do fluxo:
  - Cliente com CASE publicado;
  - Resultados documentados;
  - Incentivos contabilizados na estratégia de Sucesso do Cliente.

---

## 🗂 Estrutura do projeto

```text
/ (raiz do repositório)
└── index.html   # SVG do fluxo + estilos + scripts + modais (arquivo único)
