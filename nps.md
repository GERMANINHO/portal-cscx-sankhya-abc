Segue o **README.md completo atualizado e corrigido** para copiar e colar:

````markdown
# Fluxo NPS — CS/CX — Sankhya ABC Paulista

**Versão:** 3.0  
**Objetivo:** centralizar a rotina mensal de NPS da unidade Sankhya ABC Paulista, com consulta da base de clientes, criação de rascunho da Blitz NPS no Gmail via Google Apps Script, acompanhamento no INDECX, controle de quarentena, tratativa de playbooks e apoio ao preenchimento de GPD quando necessário.

> Este projeto utiliza **GitHub Pages + Google Apps Script + Google Sheets + Gmail**.  
> O site no GitHub Pages não envia e-mails automaticamente. Ele apenas aciona um Web App do Google Apps Script, que cria um **rascunho no Gmail**. O envio final deve ser feito manualmente pelo CS após revisão.

---

## Visão geral do fluxo

```text
GitHub Pages / index.html
        ↓
Botão "Criar rascunho de teste" ou "Envio Blitz Email"
        ↓
Web App do Google Apps Script
        ↓
Leitura da planilha Google de contatos NPS
        ↓
Filtro RESPONDE NPS = Sim
        ↓
Criação de rascunho no Gmail
        ↓
Abertura do Gmail em Rascunhos
        ↓
Revisão e envio manual pelo CS
````

---

## O que este projeto entrega

* Interface operacional em HTML publicada via **GitHub Pages**.
* Acesso rápido ao **INDECX**.
* Orientação da tela **CS - NPS** no Sankhya.
* Mapeamento do quadrante **CS - Pesquisas NPS**.
* Orientação sobre o canal oficial de WhatsApp da pesquisa NPS.
* Controle de quarentena e re-elegibilidade.
* Criação de rascunho de teste no Gmail.
* Criação de rascunho real da Blitz NPS no Gmail.
* Leitura automática da planilha Google de contatos via Apps Script.
* Filtro automático por **RESPONDE NPS = Sim**.
* Remoção de e-mails duplicados.
* Validação básica de e-mails.
* Criação de rascunho com clientes em **CCO**.
* Imagem da Blitz embutida no corpo do e-mail.
* Registro de status na planilha.
* Roteiro de playbooks para neutros e detratores.
* Modelo de preenchimento para **Apuração do Resultado / GPD**.

---

## Arquitetura do projeto

### 1. GitHub Pages

O GitHub Pages hospeda apenas o arquivo `index.html`.

Ele é responsável por:

* exibir a central operacional do fluxo NPS;
* armazenar localmente a URL do Apps Script e o token digitado;
* acionar o Web App do Apps Script via `POST`;
* abrir o Gmail em **Rascunhos** na conta correta;
* orientar o usuário sobre a rotina operacional.

O GitHub Pages **não acessa diretamente**:

* Google Drive;
* Google Sheets;
* Gmail;
* INDECX;
* banco de dados;
* APIs privadas.

---

### 2. Google Apps Script

O Google Apps Script é o motor do processo.

Ele é responsável por:

* receber a chamada do HTML;
* validar o token secreto;
* abrir a planilha Google pelo `SPREADSHEET_ID`;
* localizar a aba configurada;
* filtrar contatos com `RESPONDE NPS = Sim`;
* validar e remover e-mails duplicados;
* buscar a imagem da Blitz no Google Drive;
* criar rascunho no Gmail via `GmailApp.createDraft`;
* registrar status na planilha.

---

### 3. Google Sheets

A planilha Google é a base oficial de contatos NPS.

Planilha atual:

```text
https://docs.google.com/spreadsheets/d/1RLtsri8B4sTRC4fmhvj_k5MhlgQhOJXDs4TqGmZvKwM/edit?gid=168915867
```

A aba usada pelo Apps Script é:

```text
Página2
```

O ID configurado no Apps Script é:

```text
1RLtsri8B4sTRC4fmhvj_k5MhlgQhOJXDs4TqGmZvKwM
```

---

### 4. Gmail

O Gmail é usado somente para criação de rascunhos.

O envio final é manual.

Conta usada no fluxo:

```text
gustavo.germano@sankhya.com.br
```

A página abre o Gmail em Rascunhos usando:

```text
https://mail.google.com/mail/?authuser=gustavo.germano%40sankhya.com.br#drafts
```

---

## Arquivos do repositório

Estrutura recomendada:

```text
/
├── index.html
├── Código.gs
└── README.md
```

### `index.html`

Arquivo publicado no GitHub Pages.

Responsável pela interface do fluxo, botões, checklist, orientações e acionamento do Apps Script.

### `Código.gs`

Cópia versionada do código do Google Apps Script.

Atenção: o código real precisa estar colado no editor do Google Apps Script para funcionar. O arquivo no GitHub serve como backup/documentação.

### `README.md`

Documentação operacional e técnica do fluxo.

---

## Web App do Apps Script

URL atual do Web App:

```text
https://script.google.com/macros/s/AKfycbykLsa2EEnoGTNjMv270JxQYDUeN4asWogj8Uc3lb52sB0gLDpN3CjrvuV-0zpNLUC0ow/exec
```

Configuração correta da implantação:

```text
Executar como: Eu — gustavo.germano@sankhya.com.br
Quem pode acessar: Qualquer pessoa
```

> Observação: apesar de o acesso estar público, a execução é protegida por token. Sem o token correto, o Apps Script bloqueia a ação.

---

## Token secreto

O HTML pede um **Token secreto**.

Esse token deve ser o mesmo configurado no Apps Script.

Recomendação de segurança:

* não expor o token real no README;
* não expor o token real no GitHub;
* preferencialmente configurar o token em:

```text
Apps Script > Configurações do projeto > Propriedades do script
```

Com a propriedade:

```text
WEBAPP_TOKEN
```

Se o token real já foi exposto em print, conversa ou commit, recomenda-se trocar/rotacionar.

---

## Escopos necessários no Apps Script

O Apps Script precisa de permissões para:

* ler planilha Google;
* ler imagem no Google Drive;
* criar rascunho no Gmail.

Escopos utilizados:

```text
https://www.googleapis.com/auth/spreadsheets
https://www.googleapis.com/auth/drive.readonly
https://mail.google.com/
```

Caso o Apps Script apresente erro de permissão do Gmail, executar manualmente a função:

```text
enviarTesteBlitzNPS
```

Depois autorizar com a conta:

```text
gustavo.germano@sankhya.com.br
```

---

## Planilha de contatos NPS

### Colunas esperadas

A planilha deve conter, no mínimo:

| Coluna                                  | Obrigatória | Uso                          |
| --------------------------------------- | ----------: | ---------------------------- |
| CLIENTE                                 |         Sim | Nome da empresa/cliente      |
| NOME CONTATO / NOME / CONTATO           | Recomendado | Nome do contato              |
| EMAIL / E-MAIL                          |         Sim | E-mail usado no CCO da Blitz |
| TELEFONE / TEL / CELULAR / WHATSAPP     |         Não | Informação complementar      |
| RESPONDE NPS / RESPONDE NPS? / RESPONDE |         Sim | Filtro principal             |

---

## Regra de filtro

O Apps Script considera apenas linhas onde:

```text
RESPONDE NPS = Sim
```

Também são aceitos como verdadeiro:

```text
S
YES
TRUE
```

Os contatos que não tiverem `RESPONDE NPS = Sim` são ignorados.

---

## Regra de e-mails

O Apps Script:

* extrai o primeiro e-mail encontrado na célula;
* valida formato básico do e-mail;
* remove duplicados;
* coloca os contatos em **CCO**;
* mantém o campo **Para** com o e-mail do CS:

```text
gustavo.germano@sankhya.com.br
```

---

## Colunas de controle criadas automaticamente

O Apps Script cria automaticamente as colunas abaixo, caso ainda não existam:

```text
BLITZ PROCESSADA EM
STATUS ENVIO BLITZ
ERRO ENVIO BLITZ
```

### Uso das colunas

| Coluna              | Uso                              |
| ------------------- | -------------------------------- |
| BLITZ PROCESSADA EM | Data e hora da última execução   |
| STATUS ENVIO BLITZ  | Status da linha no processamento |
| ERRO ENVIO BLITZ    | Mensagem de erro ou observação   |

---

## Regra de reenvio

O Apps Script está configurado para permitir reprocessamento:

```javascript
REENVIAR_JA_PROCESSADOS: true
```

Com isso, se a Blitz for executada novamente:

* o script cria um novo rascunho;
* os dados de status anteriores são sobrescritos;
* a data/hora é atualizada;
* o envio final continua manual.

Isso evita a necessidade de apagar manualmente as colunas de controle antes de uma nova Blitz.

> Atenção: clicar duas vezes pode criar dois rascunhos iguais no Gmail. Isso não envia e-mail automaticamente. O risco operacional é somente revisar e enviar o rascunho errado manualmente.

---

## Botões principais do HTML

### Criar rascunho de teste

Ação enviada ao Apps Script:

```text
teste_rascunho
```

Uso:

* valida token;
* valida acesso ao Gmail;
* valida acesso à imagem da Blitz;
* cria um rascunho apenas para o e-mail de teste.

Destinatário do teste:

```text
gustavo.germano@sankhya.com.br
```

---

### Envio Blitz Email

Ação enviada ao Apps Script:

```text
criar_rascunho
```

Uso:

* lê a planilha;
* filtra `RESPONDE NPS = Sim`;
* remove duplicados;
* cria rascunho com clientes em CCO;
* registra status na planilha;
* abre o Gmail em Rascunhos.

---

### Abrir rascunhos Gmail

Abre diretamente:

```text
Gmail > Rascunhos
```

Na conta:

```text
gustavo.germano@sankhya.com.br
```

---

## Processo operacional mensal

1. Acessar **CS - NPS**.
2. Abrir o quadrante **CS - Pesquisas NPS**.
3. Conferir clientes pesquisados com mais de 6 meses.
4. Atualizar/conferir a planilha de contatos NPS.
5. Validar a coluna **RESPONDE NPS**.
6. Remover ou controlar clientes em quarentena.
7. Abrir o Fluxo NPS no GitHub Pages.
8. Conferir URL do Apps Script.
9. Informar o token secreto.
10. Clicar em **Criar rascunho de teste**.
11. Validar se o rascunho de teste apareceu no Gmail.
12. Clicar em **Envio Blitz Email**.
13. Aguardar criação do rascunho real.
14. Abrir o Gmail em **Rascunhos**.
15. Revisar:

    * destinatários em CCO;
    * assunto;
    * imagem;
    * texto;
    * assinatura;
    * ausência de menção a teste/piloto.
16. Enviar manualmente pelo Gmail.
17. Acompanhar retornos no INDECX.
18. Registrar tratativas em playbook quando necessário.
19. Preencher GPD quando solicitado.

---

## Canal oficial de WhatsApp NPS

Canal oficial:

```text
Sankhya - Experiência do Cliente
(11) 5028-9273
```

Orientação:

* o cliente deve reconhecer esse número como canal oficial da Sankhya;
* não informar ao cliente que se trata de teste ou piloto;
* a informação de piloto é apenas interna.

---

## Piloto interno

Durante o período de piloto interno, as respostas via WhatsApp são usadas para análise operacional, identificação de dores e tratativas.

As respostas via WhatsApp não devem ser comunicadas ao cliente como piloto.

---

## Quarentena e re-elegibilidade

Clientes que responderem à pesquisa via WhatsApp devem ser retirados do mailing atual e só voltam a ser elegíveis após o período de quarentena.

| Mês da resposta | Não pesquisar     | Re-elegível em |
| --------------- | ----------------- | -------------- |
| Maio            | Junho e Julho     | Agosto         |
| Junho           | Julho e Agosto    | Setembro       |
| Julho           | Agosto e Setembro | Outubro        |

---

## INDECX

Link principal:

```text
https://v3.app-indecx.com/live-dash/687b07ebc9bc6a00278be59e
```

Filtro obrigatório para acompanhamento do novo canal:

```text
Pesquisa NPS Whatsapp
```

Uso:

1. Acessar a Plataforma INDECX.
2. Aplicar o filtro **Pesquisa NPS Whatsapp**.
3. Verificar notas, comentários e respostas.
4. Identificar clientes neutros, detratores ou com dores relevantes.
5. Abrir tratativa/playbook quando necessário.
6. Controlar quarentena quando aplicável.

---

## Telas Sankhya relacionadas

### CS - NPS

```text
Caminho: Dashboards » Customer Success » CS - NPS
ID: br.com.sankhya.menu.adicional.nuDsb.1431.1
Quadrante: CS - Pesquisas NPS
```

Sub-relatórios principais:

| Sub-relatório                            | Uso                                      |
| ---------------------------------------- | ---------------------------------------- |
| Público-Alvo                             | Base total considerada para pesquisa NPS |
| Clientes Pesquisados nos Últimos 6 Meses | Clientes recentemente pesquisados        |
| Clientes Pesquisados com mais de 6 Meses | Lista principal para mailing             |
| Cliente Alvo - Nunca Pesquisados         | Consulta opcional                        |
| Clientes Alvo - Sem Contato              | Consulta opcional                        |

---

### CS - Gestão de Sucesso do Cliente

```text
Caminho: Analytics AI » Sucesso do Cliente » CS - Resultados » CS - Gestão de Sucesso do Cliente
ID: br.com.sankhya.analytics2.new.sc.t_20293.10.130
```

Uso:

* registrar playbooks;
* acompanhar atividades;
* editar atividades;
* anexar evidências;
* registrar anotações.

---

### Apuração do Resultado / GPD

```text
Caminho: Gestão Estratégica » Apuração do Resultado
ID: br.com.sankhya.apuracao.resultado
```

Uso:

* preencher quando solicitado pela Ana CSM;
* registrar plano de ação;
* formalizar ações relacionadas ao indicador NPS.

---

## Playbooks NPS

Clientes neutros ou detratores precisam ter tratativa registrada.

Atividades principais:

| Tipo da atividade                        | Objetivo                                                       |
| ---------------------------------------- | -------------------------------------------------------------- |
| Loop de NPS - Entendimento do Cenário    | Registrar contexto, reclamação, impacto e causa inicial        |
| Loop de NPS - Plano de Ação              | Registrar plano, responsável, prazo e aceite do cliente        |
| Loop de NPS - Plano de Ação Colaborativo | Registrar envolvimento de outras áreas                         |
| Loop de NPS - Follow-up                  | Registrar retorno ao cliente, percepção de melhora e conclusão |

Prazo recomendado:

```text
Concluir até o final do mês seguinte.
```

---

## GPD — Modelo de preenchimento

Campos recomendados:

```text
Quem:
Cliente, carteira, contato, CS responsável e áreas envolvidas.

O que:
Indicador, nota, reclamação, risco ou cenário tratado.

Onde:
NPS, INDECX, WhatsApp, playbook, cliente, processo ou área.

Porque:
Impacto no NPS, relacionamento, recorrência, satisfação ou risco de churn.

Como:
Plano de ação, responsáveis, prazos e próximos passos.

Quanto custa:
Sem custo, depende de serviços, orçamento ou horas envolvidas.

Retorno esperado:
Reversão de insatisfação, conclusão do plano, melhoria de percepção ou redução de risco.

Observação:
Contexto, dependências, anexos, evidências, pendências ou acompanhamento da Ana CSM.
```

---

## Testes recomendados

### Teste 1 — Web App online

Abrir a URL `/exec` do Apps Script no navegador.

Resultado esperado:

```json
{
  "ok": true,
  "mensagem": "Web App Blitz NPS online."
}
```

---

### Teste 2 — Rascunho de teste

No HTML, clicar em:

```text
Criar rascunho de teste
```

Resultado esperado:

* criação de rascunho de teste no Gmail;
* abertura do Gmail em Rascunhos;
* ausência de erro de permissão.

---

### Teste 3 — Rascunho real

No HTML, clicar em:

```text
Envio Blitz Email
```

Resultado esperado:

```text
Rascunhos criados: 1
Contatos processados: 41
Ignorados: 0
Duplicados: 0
E-mails inválidos: 0
Erros: 0
```

---

## Erros comuns

### Função de script não encontrada: doPost

Causa:

```text
O HTML chamou o Web App via POST, mas o Apps Script não tinha a função doPost publicada.
```

Correção:

* garantir que existe `function doPost(e)`;
* salvar;
* publicar nova versão da implantação.

---

### Serviço Planilhas apresentou falha ao acessar o documento

Possíveis causas:

* arquivo ainda era Excel `.xlsx`;
* planilha não era Google Sheets nativo;
* Apps Script sem acesso à planilha;
* ID incorreto.

Correção:

```text
Arquivo > Salvar como Planilhas Google
```

Depois usar o novo ID no `SPREADSHEET_ID`.

---

### The script does not have permission to perform that action

Causa:

```text
Apps Script sem permissão para criar rascunho no Gmail.
```

Correção:

* executar `enviarTesteBlitzNPS` manualmente;
* autorizar com `gustavo.germano@sankhya.com.br`;
* publicar nova versão.

---

### Nenhum novo contato para criar rascunho

Causa provável:

```text
Contatos já processados e REENVIAR_JA_PROCESSADOS estava false.
```

Na versão atual, o correto é usar:

```javascript
REENVIAR_JA_PROCESSADOS: true
```

Assim, novas execuções geram novo rascunho e sobrescrevem os status.

---

### Gmail abriu na conta errada

Causa:

```text
URL usando /u/0/, que abre a primeira conta Google logada no navegador.
```

Correção:

Usar URL com `authuser`:

```text
https://mail.google.com/mail/?authuser=gustavo.germano%40sankhya.com.br#drafts
```

---

## Limitações

* O HTML não envia e-mails.
* O Apps Script não envia e-mails.
* O processo cria rascunho e exige envio manual.
* O Gmail pode bloquear abertura automática se o navegador bloquear pop-ups.
* O envio final depende de revisão humana.
* Se clicar mais de uma vez em **Envio Blitz Email**, mais de um rascunho poderá ser criado.
* O GitHub Pages não tem acesso direto ao Google Drive ou Gmail.

---

## Checklist final antes do envio manual

* [ ] Planilha atualizada.
* [ ] Coluna `RESPONDE NPS` revisada.
* [ ] Clientes em quarentena removidos ou controlados.
* [ ] Rascunho criado no Gmail.
* [ ] Clientes estão em CCO.
* [ ] Campo Para está com `gustavo.germano@sankhya.com.br`.
* [ ] Imagem da Blitz carregou.
* [ ] Texto não menciona teste/piloto.
* [ ] Assunto revisado.
* [ ] Assinatura revisada.
* [ ] Envio manual feito pelo Gmail.
* [ ] INDECX acompanhado após retorno.
* [ ] Playbooks abertos quando necessário.
* [ ] GPD preenchido quando solicitado.

---

## Resumo operacional

```text
O GitHub Pages é a interface.
O Apps Script é o motor.
A planilha Google é a base.
O Gmail recebe apenas rascunhos.
O CS revisa e envia manualmente.
```

```
```
