# Padrões e Convenções do Projeto

Este documento define os padrões de organização, nomenclatura e boas práticas do MVP de moedas digitais.

---

## Organização do Projeto

- O código segue a estrutura padrão de um aplicativo Rails em modo API.
- A lógica de negócio fica em **models** (classes Ruby puras).
- A camada de exposição HTTP fica em **controllers**.
- Dados mockados são mantidos em estruturas em memória (arrays/hashes) em um ponto centralizado, acessível pelos controllers.

---

## Convenções de Nomenclatura

- **Models:** singular, PascalCase (ex.: `Cryptocurrency`, `Operation`).
- **Controllers:** plural, sufixo `Controller` (ex.: `CryptocurrenciesController`, `OperationsController`).
- **Arquivos:** snake_case (ex.: `cryptocurrencies_controller.rb`, `operation.rb`).
- **Rotas e recursos:** plural, em minúsculas (ex.: `/cryptocurrencies`, `/operations`).
- **Atributos JSON:** snake_case (ex.: `operation_type`, `cryptocurrency_id`).

---

## Estrutura de Pastas Rails (relevante ao MVP)

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── cryptocurrencies_controller.rb
│   └── operations_controller.rb
├── models/
│   ├── cryptocurrency.rb
│   └── operation.rb
└── views/                    # opcional: formulários HTML simples para testes
config/
├── routes.rb
└── ...
```

- **Controllers:** apenas roteamento de requisições e renderização de JSON; sem regras de negócio complexas.
- **Models:** validações, geração de ID, cálculos (ex.: custo da operação); instâncias armazenadas em arrays/hashes em memória.

---

## Padrões REST

- **GET** `/cryptocurrencies` — listar moedas.
- **GET** `/cryptocurrencies/:id` — mostrar uma moeda.
- **POST** `/cryptocurrencies` — criar moeda (corpo JSON).
- **PUT/PATCH** `/cryptocurrencies/:id` — atualizar moeda.
- **DELETE** `/cryptocurrencies/:id` — remover moeda (apenas do repositório em memória).

- **GET** `/operations` — listar operações.
- **GET** `/operations/:id` — mostrar uma operação.
- **POST** `/operations` — criar operação (corpo JSON).

Use códigos HTTP adequados: `200`, `201`, `400`, `404`, `422`.

---

## Controllers sem Banco de Dados

- Controllers **não** acessam banco nem ORM; apenas chamam models e repositórios em memória.
- Responsabilidades do controller:
  - Receber parâmetros (params).
  - Chamar o model ou o repositório para criar/buscar/atualizar/deletar.
  - Retornar `render json: ...` com status HTTP apropriado.
- Tratamento de erros: em caso de validação falha ou recurso não encontrado, retornar JSON de erro e status 4xx.

---

## IDs em Memória

- IDs são gerados **sequencialmente** em memória (contador global ou baseado no tamanho do array).
- Cada novo recurso criado (Cryptocurrency ou Operation) recebe um ID único no escopo da execução do servidor.
- Não usar UUID ou bibliotecas externas para ID; manter implementação simples.

---

## Armazenamento em Memória

- Usar **arrays** ou **hashes** para armazenar **instâncias das classes de modelo** (objetos `Cryptocurrency` e `Operation`).
- Evitar armazenar apenas hashes brutos; preferir objetos com comportamento (métodos) nos models.
- O “repositório” pode ser um módulo ou classe que mantém os arrays/hashes e expõe métodos como `all`, `find(id)`, `create(attrs)`, `update(id, attrs)`, `delete(id)`.

---

## Boas Práticas Resumidas

1. **Controller fino:** apenas roteamento e `render json`; sem cálculos nem validações complexas.
2. **Model com lógica:** validações, `cost`, `operation_date`, geração de ID.
3. **Dados em memória:** arrays/hashes de instâncias de models; IDs sequenciais.
4. **API JSON:** respostas consistentes em JSON; uso correto de status HTTP.
5. **Testes:** formulários HTML simples (em `app/views` ou pasta dedicada) para testar POST via browser quando aplicável.
