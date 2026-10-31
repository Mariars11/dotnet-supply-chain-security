# Segurança da Cadeia de Suprimentos — .NET 8

Projeto final do módulo **CY-SE-013 — Segurança da Cadeia de Suprimentos de Software**.

## Sobre o projeto

Este projeto demonstra, de forma prática, como controles de segurança podem identificar configurações inseguras, analisar vulnerabilidades e verificar a integridade de artefatos na cadeia de suprimentos de software.

A aplicação utilizada é uma **API .NET 8 Minimal API**, que simula um catálogo de produtos.

O projeto compara dois cenários:

- **Antes:** aplicação conteinerizada com configurações inseguras e sem verificação de assinatura.
- **Depois:** aplicação submetida a políticas de segurança, inventário de componentes, análise de vulnerabilidades e assinatura digital.

## Tecnologias

| Tecnologia | Finalidade |
|---|---|
| .NET 8 | Desenvolvimento da API |
| Swagger | Documentação e testes dos endpoints |
| Docker | Conteinerização da aplicação |
| OPA / Rego | Validação de políticas de segurança |
| Syft | Geração do SBOM |
| Trivy | Identificação de vulnerabilidades conhecidas |
| Cosign | Assinatura e verificação de imagens |
| GitHub Container Registry | Publicação das imagens Docker |

## Funcionalidades da API

| Método | Endpoint | Descrição |
|---|---|---|
| GET | `/health` | Verifica a disponibilidade da API |
| GET | `/produtos` | Lista os produtos cadastrados |
| GET | `/produtos/{id}` | Consulta um produto pelo identificador |

Os dados são armazenados em memória, sem necessidade de banco de dados.

### Executando a aplicação

```bash
dotnet run --project src/ProdutosApi
```

O Swagger está disponível em `/swagger` quando a aplicação é executada no ambiente de desenvolvimento.

## Acompanhamento do desenvolvimento

### Etapa 1 — Estrutura inicial

- [x] Criar projeto .NET 8 Minimal API
- [x] Configurar `.gitignore`
- [x] Implementar endpoints da API
- [x] Configurar Swagger
- [x] Validar os endpoints
- [x] Confirmar execução sem erros

### Etapa 2 — Conteinerização

- [x] Criar Dockerfile inicial
- [x] Construir imagem Docker
- [x] Executar aplicação em contêiner
- [x] Demonstrar execução como usuário root
- [x] Registrar evidências do cenário inseguro

### Etapa 3 — Políticas de segurança (OPA/Rego)

- [x] Criar política Rego
- [x] Definir regra para impedir execução como root
- [x] Testar política com OPA
- [x] Demonstrar bloqueio da configuração insegura
- [x] Corrigir Dockerfile utilizando `USER app`
- [x] Validar aprovação da configuração corrigida

### Etapa 4 — Inventário e vulnerabilidades

- [x] Gerar SBOM com Syft
- [x] Salvar SBOM em formato CycloneDX JSON
- [x] Executar análise com Trivy
- [x] Identificar vulnerabilidades conhecidas
- [x] Registrar CVE, severidade e componente afetado
- [x] Salvar evidências da análise

### Etapa 5 — Integridade da cadeia de suprimentos

- [x] Definir cenário de substituição de imagem
- [x] Publicar imagem no GitHub Container Registry
- [x] Assinar imagem com Cosign keyless
- [x] Verificar assinatura e identidade do assinante
- [x] Demonstrar rejeição de imagem não assinada
- [x] Registrar evidências da verificação

**Imagem legítima:**

`ghcr.io/mariars11/produtos-api:v2`

Digest:

`sha256:921eacb29fd646fc4dafdc1469b7d3df85548cf4655092432bf2164ff1aa246b`

A verificação Cosign confirmou a assinatura, o certificado e a existência do registro no log de transparência.

**Imagem substituta utilizada na simulação:**

`ghcr.io/mariars11/produtos-api:adulterada`

Digest:

`sha256:c1eb9fc3af490d60048039b9355ef4ddbbf42a24aa6e21cbc6962d61dba3491b`

A verificação retornou:

```text
Error: no signatures found
```

A simulação utilizou uma versão anterior da API, que executava como usuário root. A imagem substituta não foi assinada.

### Etapa 6 — Compliance e documentação

- [x] Elaborar mapa de ameaças
- [x] Relacionar ameaças aos controles implementados
- [x] Documentar evidências disponíveis em caso de ataque
- [x] Relacionar o projeto a um ataque real à cadeia de suprimentos
- [ ] Preparar apresentação de cinco minutos

## Critérios de avaliação

- [x] Escrever e testar uma política Rego
- [x] Gerar o SBOM da imagem
- [x] Identificar e registrar vulnerabilidades reais
- [x] Assinar e verificar a imagem com Cosign
- [ ] Relacionar o exercício a um ataque real à cadeia de suprimentos na apresentação final

## Organização das evidências

```text
evidencias/
├── 01-containerizacao/
│   ├── container-root.txt
│   └── dockerfile-root.png
├── 02-politicas-seguranca/
│   ├── imagem-vulneravel.json
│   ├── imagem-corrigida.json
│   ├── opa-bloqueio.txt
│   └── opa-aprovacao.txt
├── 03-inventario-vulnerabilidades/
│   ├── sbom.json
│   ├── trivy-resultado.json
│   └── trivy-resultado.txt
├── 04-assinatura-integridade/
│   ├── cosign-verificacao-valida.txt
│   └── cosign-verificacao-adulterada.txt
└── 05-compliance/
    └── relatorio-compliance.md
```

A pasta `05-compliance` reúne o mapeamento de ameaças, controles e evidências do projeto.

## Principais resultados

**1. Configuração insegura identificada:** a primeira imagem Docker executava como usuário root.

**2. Política de segurança aplicada:** o OPA/Rego identificou a configuração inadequada, e o Dockerfile foi corrigido para executar com usuário não privilegiado.

**3. Inventário de componentes gerado:** o Syft produziu um SBOM com 3.588 componentes identificados na análise realizada.

**4. Vulnerabilidades identificadas:** o Trivy apontou vulnerabilidades conhecidas em componentes da imagem, registradas nos arquivos de evidência.

**5. Integridade demonstrada:** o Cosign validou a assinatura da imagem legítima e rejeitou a imagem substituta não assinada.

## Conclusão

Uma aplicação funcional não é necessariamente segura.

A combinação de políticas como código, SBOM, análise de vulnerabilidades e assinaturas digitais aumenta a visibilidade e a confiança na cadeia de suprimentos de software.

Esses controles são complementares: uma assinatura válida não garante ausência de vulnerabilidades, assim como a identificação de vulnerabilidades não comprova a procedência de uma imagem.

A integração dessas verificações ao pipeline de CI/CD é recomendada para automatizar a aplicação das políticas antes do deploy.

---

**Status:** Etapas técnicas concluídas; documentação e apresentação final em andamento.

**Módulo:** CY-SE-013 — Segurança da Cadeia de Suprimentos de Software.