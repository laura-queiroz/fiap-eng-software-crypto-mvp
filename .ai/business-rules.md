# Regras de Negócio — Mini Sistema de Moedas Digitais

Descrição das entidades, atributos e regras principais do MVP.

---

## Entidades

### Cryptocurrency (Criptomoeda)

Representa uma moeda digital (ex.: Bitcoin, Solana).

| Campo    | Tipo     | Obrigatório | Observação                    |
|----------|----------|-------------|-------------------------------|
| id       | inteiro  | —           | Gerado automaticamente        |
| name     | string   | sim         | Nome da moeda                 |
| symbol   | string   | sim         | Símbolo (ex.: BTC, SOL)       |
| price    | numérico | sim         | Preço unitário atual          |

- **ID:** gerado de forma sequencial em memória ao criar a moeda (ex.: 1, 2, 3…).
- Validações esperadas: presença de `name`, `symbol` e `price`; `price` numérico e, se aplicável, maior que zero.

---

### Operation (Operação)

Representa uma operação de compra ou venda sobre uma criptomoeda.

| Campo             | Tipo     | Obrigatório | Observação                          |
|-------------------|----------|-------------|-------------------------------------|
| id                | inteiro  | —           | Gerado automaticamente              |
| cryptocurrency_id | inteiro  | sim         | Referência à moeda                  |
| operation_type    | string   | sim         | Ex.: "buy", "sell"                  |
| amount            | numérico | sim         | Quantidade de unidades              |
| cost              | numérico | —           | Calculado: amount × preço da moeda  |
| operation_date    | datetime | —           | Preenchido com Time.now na criação  |

- **ID:** gerado sequencialmente em memória ao criar a operação.
- **cost:** não é enviado pelo cliente; é calculado no momento da criação como `amount * preço_da_moeda`. O preço usado é o da moeda **no momento da operação** (valor atual em memória).
- **operation_date:** definido automaticamente como `Time.now` ao criar a operação.
- Validações esperadas: presença de `cryptocurrency_id`, `operation_type` e `amount`; `cryptocurrency_id` deve existir no repositório de moedas; `amount` numérico e, se aplicável, maior que zero.

---

## Regras de Negócio Principais

1. **Criação e listagem de moedas**
   - É possível criar criptomoedas (POST) com `name`, `symbol` e `price`.
   - É possível listar todas (GET) e obter uma por ID (GET).

2. **Registro de operações**
   - Operações são criadas (POST) com `cryptocurrency_id`, `operation_type` e `amount`.
   - O sistema calcula `cost` e `operation_date`; o cliente não envia esses campos.

3. **Preço no momento da operação**
   - O valor usado no cálculo de `cost` é sempre o **preço atual** da moeda no repositório em memória no instante em que a operação é criada.
   - Alterações futuras no preço da moeda não alteram o `cost` de operações já criadas.

4. **Limitações do MVP**
   - Não há autenticação/autorização.
   - Não há histórico de cotações; cada moeda tem um único `price` atual.
   - Dados não persistem após o reinício do servidor (comportamento esperado).

5. **Reset ao reiniciar**
   - Arrays/hashes em memória são recriados vazios ao subir o servidor. Não há persistência entre execuções.

---

## Testes via Browser (POST)

Para testar a criação de recursos via browser sem cliente HTTP externo:

1. **Formulário para criar Cryptocurrency**
   - Campos: name, symbol, price.
   - Method POST, action apontando para `/cryptocurrencies` (ou helper equivalente).
   - Content-Type: `application/x-www-form-urlencoded` ou formulário que o Rails consiga mapear para `params`.

2. **Formulário para criar Operation**
   - Campos: cryptocurrency_id, operation_type, amount.
   - Method POST, action apontando para `/operations`.

O backend deve aceitar parâmetros vindos desses formulários e responder com JSON (ou redirect + flash em uma versão mínima de feedback). Para uma API pura, o ideal é que o controller aceite tanto JSON quanto parâmetros de formulário e responda em JSON.

Instruções práticas para o desenvolvedor:
- Criar uma moeda pelo formulário (ex.: Bitcoin, BTC, 50000).
- Criar uma operação informando o `cryptocurrency_id` retornado (ex.: 1), `operation_type` "buy" e `amount` 0.5.
- Verificar na resposta ou em GET `/operations/1` que `cost` e `operation_date` foram preenchidos automaticamente.
