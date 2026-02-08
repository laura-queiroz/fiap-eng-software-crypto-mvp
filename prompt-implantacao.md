# Prompt de Implementação — MVP Rails (Dados Mockados)

Você é um agente de implementação responsável por **criar um MVP funcional** com base na documentação existente na pasta `.ai/`.

## Objetivo
Implementar um **Rails API MVP**, executável localmente, utilizando **dados mockados em memória**, sem banco de dados e sem gems nativas.

---

## Requisitos Técnicos Obrigatórios
- Ruby
- Ruby on Rails (API mode)
- Sem ActiveRecord
- Sem SQLite, PostgreSQL ou qualquer banco
- Sem gems que exigem compilação nativa
- Controllers REST
- Dados simulados em memória

---

## Estrutura esperada do projeto
app/
controllers/
cryptocurrencies_controller.rb
operations_controller.rb
models/
cryptocurrency.rb
operation.rb
config/
routes.rb
app/views/
cryptocurrencies/
new.html.erb
operations/
new.html.erb
---

## Entidades

### Cryptocurrency
Campos:
- id (gerado manualmente)
- name
- symbol
- price
- image  

Dados devem ser mockados em memória usando arrays ou hashes

### Operation
Campos:
- id (gerado manualmente)
- cryptocurrency_id
- operation_type (buy/sell)
- amount
- cryptocurrency_price
- cost
- operation_date  

Dados devem ser mockados em memória usando arrays ou hashes

---

## Endpoints esperados

### Cryptocurrencies
- GET /cryptocurrencies
- GET /cryptocurrencies/:id
- POST /cryptocurrencies
- Formulário HTML para criação via browser em `app/views/cryptocurrencies/new.html.erb`

### Operations
- GET /operations
- POST /operations
- Formulário HTML para criação via browser em `app/views/operations/new.html.erb`

---

## Diretrizes de Implementação
- Controllers devem retornar JSON
- Models devem ser classes Ruby simples
- Dados devem ser armazenados em arrays ou estruturas estáticas
- Simular IDs manualmente
- Não usar migrations
- Não usar ActiveRecord
- Criar pequenas views HTML para permitir POST via browser
- Código simples, legível e executável localmente
- Dados resetam ao reiniciar o servidor (esperado no MVP)

---

## Execução
- Subir com `rails server`
- Responder às rotas via browser ou curl
- Servir apenas como MVP arquitetural
- Priorizar arquitetura, fluxos e organização do código
