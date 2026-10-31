# Segurança da Cadeia de Suprimentos — .NET 8

Projeto final do módulo **CY-SE-013 — Segurança da Cadeia de Suprimentos de Software**.

## Sobre o projeto

Este projeto tem como objetivo demonstrar, de forma prática, como a aplicação de controles de segurança pode identificar, bloquear e evidenciar vulnerabilidades ao longo da cadeia de suprimentos de software.

Para isso, será utilizada uma API desenvolvida em **.NET 8 Minimal API**, simulando um catálogo de produtos.

A proposta é comparar dois cenários:

- **Antes:** aplicação sem controles específicos de segurança da cadeia de suprimentos.
- **Depois:** aplicação submetida a políticas de segurança, análise de vulnerabilidades, inventário de dependências e verificação de integridade.

## Tecnologias

| Tecnologia | Finalidade                          |
| ---------- | ----------------------------------- |
| .NET 8     | Desenvolvimento da API              |
| Swagger    | Documentação e testes dos endpoints |
| Docker     | Conteinerização da aplicação        |
| OPA / Rego | Validação de políticas de segurança |
| Syft       | Geração do SBOM                     |
| Trivy      | Identificação de vulnerabilidades   |
| Cosign     | Assinatura e verificação de imagens |

## Funcionalidades da API

A aplicação disponibiliza os seguintes endpoints:

| Método | Endpoint         | Descrição                              |
| ------ | ---------------- | -------------------------------------- |
| GET    | `/health`        | Verifica a disponibilidade da API      |
| GET    | `/produtos`      | Lista os produtos cadastrados          |
| GET    | `/produtos/{id}` | Consulta um produto pelo identificador |

Os dados são armazenados em memória, dispensando a utilização de banco de dados.

### Executando a aplicação

```bash
dotnet run --project src/ProdutosApi
```

Para acessar o Swagger, utilize:

```text
http://localhost:<porta>/swagger
```

O Swagger está habilitado no ambiente de desenvolvimento.

## Acompanhamento do desenvolvimento

### Etapa 1 — Estrutura inicial

- [x] Criar projeto .NET 8 Minimal API
- [x] Configurar `.gitignore`
- [x] Implementar endpoints da API
- [x] Configurar Swagger
- [x] Validar os endpoints pelo Swagger
- [x] Confirmar execução local sem erros

### Etapa 2 — Conteinerização

- [x] Criar Dockerfile inicial
- [x] Construir imagem Docker
- [x] Executar a aplicação em container
- [x] Demonstrar execução como usuário root
- [x] Registrar evidências do cenário inseguro

### Etapa 3 — Políticas de segurança (OPA/Rego)

- [ ] Criar política Rego
- [ ] Definir regra para impedir execução como root
- [ ] Testar política com OPA ou Conftest
- [ ] Demonstrar bloqueio da configuração insegura
- [ ] Corrigir Dockerfile
- [ ] Validar aprovação da configuração corrigida

### Etapa 4 — Inventário e vulnerabilidades

- [ ] Gerar SBOM com Syft
- [ ] Salvar SBOM em formato JSON
- [ ] Executar análise com Trivy
- [ ] Identificar pelo menos uma vulnerabilidade real
- [ ] Registrar CVE, severidade e componente afetado
- [ ] Salvar evidência da análise

### Etapa 5 — Integridade da cadeia de suprimentos

- [ ] Definir cenário de adulteração de imagem
- [ ] Publicar imagem em registry de testes
- [ ] Assinar imagem com Cosign em modo keyless
- [ ] Verificar assinatura e identidade do assinante
- [ ] Demonstrar falha de verificação para imagem não autorizada ou adulterada
- [ ] Registrar evidências

### Etapa 6 — Compliance e documentação

- [ ] Elaborar mapa de ameaças
- [ ] Relacionar ameaças aos controles implementados
- [ ] Documentar as evidências disponíveis em caso de ataque
- [ ] Relacionar o projeto a um caso real de ataque à cadeia de suprimentos
- [ ] Preparar apresentação de cinco minutos

## Critérios de avaliação

- [ ] Escrever e testar uma política Rego
- [ ] Gerar o SBOM da imagem
- [ ] Identificar e registrar uma vulnerabilidade real
- [ ] Assinar e verificar a imagem com Cosign
- [ ] Relacionar o exercício a um ataque real à cadeia de suprimentos

## Evidências

As evidências serão armazenadas no diretório `evidencias/`, incluindo:

- Resultados da validação de políticas
- SBOM gerado
- Resultado da análise de vulnerabilidades
- Comprovantes de assinatura e verificação
- Registros dos cenários antes e depois

## Resultado esperado

Ao final do projeto, será possível demonstrar que uma aplicação funcional não é necessariamente uma aplicação segura.

A implementação de controles de segurança permitirá identificar configurações inadequadas, conhecer os componentes presentes na imagem, detectar vulnerabilidades conhecidas e verificar a autenticidade e integridade dos artefatos distribuídos.

---

**Status:** Em desenvolvimento.

**Módulo:** CY-SE-013 — Segurança da Cadeia de Suprimentos de Software.
