# Stack Tecnológica — Mini Sistema de Moedas Digitais

Definição das linguagens, frameworks e ferramentas utilizados no MVP e justificativas das escolhas.

---

## Linguagens

- **Ruby** — linguagem principal do backend (versão compatível com o Rails adotado, ex.: 3.x).

---

## Framework Principal

- **Ruby on Rails** em **modo API** (`--api`).
  - Geração do projeto: `rails new nome_do_projeto --api`.
  - Foco em endpoints JSON, sem asset pipeline nem views complexas por padrão.
  - Rotas, controllers e convenções REST bem definidas, adequadas a um MVP acadêmico.

---

## Ferramentas Auxiliares

- **Rack** — camada de interface entre servidor e aplicação (já incluído no Rails).
- **Servidor de desenvolvimento:** `rails server` (ou Puma, padrão no Rails).
- **Cliente HTTP:** curl, Postman ou scripts para testes da API.
- **Formulários HTML simples** (opcionais): views básicas em ERB para testar POST via browser, sem dependências de frontend moderno.

Nenhuma gem de banco de dados (SQLite, PostgreSQL, etc.) nem ORM de persistência é utilizada.

---

## Justificativa das Escolhas

| Escolha | Motivo |
|--------|--------|
| Rails API | Estrutura clara, REST por convenção, rápido para prototipar e ensinar arquitetura em camadas. |
| Ruby | Ecossistema maduro, sintaxe legível e alinhada ao contexto acadêmico de engenharia de software. |
| Sem banco real | Restrições do ambiente (sem sudo, sem compilar gems nativas) e foco em API e regras de negócio, não em persistência. |
| Dados em memória | Elimina dependências externas; o projeto roda apenas com Ruby e Rails instalados. |

---

## Restrições do Ambiente

- **Linux corporativo:** sem permissão de `sudo`.
- **Gems nativas:** não é possível compilar gems que dependam de bibliotecas nativas (ex.: algumas gems de BD ou de criptografia nativa); o stack deve evitar essas dependências.
- **Banco de dados:** não utilizar banco de dados real; todos os dados são mockados em memória.
- **Porta e rede:** usar porta padrão (ex.: 3000) ou a que for permitida no ambiente; sem requisitos de rede especiais além do localhost para desenvolvimento.

Essas restrições orientam a decisão de manter o MVP sem persistência e com stack mínimo (Ruby + Rails API + estruturas em memória).
