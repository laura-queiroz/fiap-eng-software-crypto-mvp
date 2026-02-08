# Prompt de Geração de Contexto — Mini Sistema de Moedas Digitais

Você é um agente de engenharia de software atuando em um projeto acadêmico de MBA em Engenharia de Software. Seu objetivo é **gerar o contexto completo do projeto**, criando a pasta `.ai/` e os arquivos de documentação que servirão de base para a implementação de um MVP.

## Contexto do Projeto
O projeto consiste em um **mini sistema de moedas digitais**, focado em operações básicas (CRUD) sobre criptomoedas como Bitcoin e Solana.

⚠️ **Restrições importantes do ambiente:**
- Ambiente Linux corporativo
- Sem permissão de sudo
- Não é possível compilar gems nativas
- Não utilizar banco de dados real
- Utilizar dados mockados em memória

O foco do projeto é **arquitetura, fluxos, API e organização**, não persistência.

---

## Estrutura que DEVE ser criada

.ai/
├── standards.md
├── architecture.md
├── tech-stack.md
└── business-rules.md


---

## Conteúdo esperado em cada arquivo

### standards.md
- Padrões de organização do projeto
- Convenções de nomenclatura
- Estrutura de pastas Rails
- Padrões REST
- Boas práticas para controllers e models sem banco
- IDs gerados sequencialmente em memória
- Arrays ou hashes devem armazenar instâncias das classes de modelo
- Evitar lógica complexa no controller; apenas roteamento e render JSON

### architecture.md
- Visão geral da arquitetura
- Arquitetura em camadas:
  - Frontend (cliente HTTP ou pequenas views HTML)
  - Backend (Rails API)
  - Camada de dados mockados (in-memory)
- Controllers simulam CRUD com arrays globais
- Cada POST cria objetos com IDs automáticos
- GET retorna dados mockados como JSON
- Diagrama textual ou Mermaid da arquitetura
- Justificativa para não uso de banco de dados

### tech-stack.md
- Linguagens utilizadas
- Framework principal (Ruby on Rails – API mode)
- Ferramentas auxiliares
- Justificativa das escolhas técnicas
- Observação sobre restrições do ambiente

### business-rules.md
- Descrição das entidades:
  - Cryptocurrency
    - Campos obrigatórios: name, symbol, price
    - ID gerado automaticamente
  - Operation
    - Campos obrigatórios: cryptocurrency_id, operation_type, amount
    - cost calculado como amount * cryptocurrency_price
    - operation_date = Time.now
- Regras de negócio principais:
  - Criação e listagem de moedas
  - Registro de operações
  - Uso de preço da moeda no momento da operação
  - Limitações do MVP
  - Dados resetam ao reiniciar o servidor (esperado no MVP)

---

## Diretrizes
- Linguagem prática e objetiva
- Estilo acadêmico leve
- Não mencionar banco de dados real
- Não mencionar ActiveRecord
- Tudo deve ser coerente com um MVP executável localmente
- Incluir instruções para testes de POST via browser com formulários HTML simples