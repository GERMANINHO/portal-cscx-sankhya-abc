# Fluxo OS RevOps — CS/CX / Financeiro Sankhya ABC Paulista

Repositório que centraliza o **manual em PDF** do fluxo de **abertura e tratativa de OS (RevOps / Financeiro)** da **Sankhya ABC Paulista**, com uma página HTML simples que funciona como **visualizador online** desse PDF.

O projeto é 100% **estático** (HTML + PDF) e pensado para ser publicado via **GitHub Pages**, facilitando o acesso do time ao fluxo oficial.

---

## 🔎 Visão geral

- **O que é este repositório?**  
  - Um **manual em PDF** com o fluxo de:
    - Abertura de OS;
    - Tratativa/encaminhamento;
    - Responsáveis por etapa (RevOps / Financeiro / CS/CX);
    - Regras de uso dos canais, prazos e handoffs.
  - Um **`index.html`** que:
    - Exibe o PDF embutido no navegador;
    - Mostra um cabeçalho com o título do fluxo;
    - Oferece um botão **“Baixar PDF”**.

- **Público-alvo:**  
  - RevOps / Financeiro;
  - CS/CX;
  - Gestão da unidade (para consulta rápida do fluxo oficial).

- **Tecnologia:**  
  - **HTML5** — página única (`index.html`);
  - **CSS inline** — layout simples e responsivo (header fixo + área de visualização);
  - **PDF** — `fluxo-os-revops-sankhya-abc-paulista.pdf` (conteúdo do manual).

---

## 📦 O que este projeto entrega

- **Visualizador web do manual:**
  - Cabeçalho com:
    - Título: **“Fluxo OS RevOps — Manual em PDF”**;
    - Link/botão **“Baixar PDF”** (`target="_blank"`).
  - Área principal com o PDF embutido via:

    ```html
    <object data="fluxo-os-revops-sankhya-abc-paulista.pdf"
            type="application/pdf">
      ...
    </object>
    ```

  - **Fallback amigável**:
    - Se o navegador não conseguir exibir o PDF embutido, aparece uma mensagem:
      - “Não foi possível exibir o PDF embutido…”
      - Com um link para **abrir ou baixar** o arquivo em nova aba.

- **Layout responsivo:**
  - Header fixo no topo;
  - Área de visualização ocupando o restante da tela;
  - PDF sempre ajustado à largura/altura disponíveis.

---

## 🗂 Estrutura do repositório

```text
/ (raiz do repositório)
├── index.html                                   # página única (viewer do PDF)
└── fluxo-os-revops-sankhya-abc-paulista.pdf    # manual do fluxo de OS (RevOps / Financeiro)
