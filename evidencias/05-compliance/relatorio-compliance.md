# Mapa de Ameaças e Evidências — Supply Chain Security

**Projeto:** ProdutosApi — .NET 8  
**Módulo:** CY-SE-013 — Segurança da Cadeia de Suprimentos de Software

## 1. Mapeamento de ameaças

| Ameaça | Controle implementado | Evidência |
|---|---|---|
| Contêiner executado como root | Dockerfile com `USER app` e validação OPA/Rego | `01-containerizacao/` e `02-politicas-seguranca/` |
| Configuração insegura aprovada para implantação | Política Rego que rejeita imagens executadas como root | `opa-bloqueio.txt` e `opa-aprovacao.txt` |
| Dependências desconhecidas | Inventário SBOM gerado com Syft | `sbom.json` |
| Vulnerabilidades conhecidas em componentes | Análise de vulnerabilidades com Trivy | `trivy-resultado.json` e `trivy-resultado.txt` |
| Substituição por imagem não assinada | Assinatura keyless e verificação com Cosign | `cosign-verificacao-valida.txt` e `cosign-verificacao-adulterada.txt` |

## 2. Cenário de ataque simulado

A imagem original `produtos-api:v1` executava como usuário root e foi rejeitada pela política OPA/Rego.

Após a correção, a imagem `produtos-api:v2` passou a utilizar o usuário não privilegiado `app`, foi publicada no GitHub Container Registry e assinada digitalmente com Cosign keyless.

Para simular uma substituição não autorizada, publicamos a versão anterior com a tag `adulterada`, sem assinatura digital.

**Resultados:**
- Imagem legítima `v2`: assinatura validada.
- Imagem substituta `adulterada`: `Error: no signatures found`.

A simulação demonstra que a verificação de assinatura consegue distinguir a imagem aprovada de uma imagem substituta sem assinatura confiável.

## 3. Relação com ataque real

O comprometimento do **xz-utils (2024)** exemplifica o risco de inserção de código malicioso em componentes utilizados por outros softwares.

O caso reforça a importância de conhecer dependências, avaliar vulnerabilidades e estabelecer controles sobre a procedência dos artefatos.

Entretanto, uma assinatura válida não garante que um componente esteja livre de código malicioso. Por isso, os controles devem ser utilizados em conjunto.

## 4. Evidências disponíveis

As evidências estão organizadas em `evidencias/`, nas pastas de containerização, políticas de segurança, inventário e vulnerabilidades, assinatura e integridade, e compliance.

Os registros permitem demonstrar a configuração insegura inicial, o bloqueio pela política, a correção aplicada, os componentes identificados, as vulnerabilidades encontradas e os resultados das verificações de assinatura.

## 5. Conclusão

A aplicação de controles complementares aumenta a segurança e a rastreabilidade da cadeia de suprimentos de software.

Para que as verificações impeçam efetivamente implantações inseguras, recomenda-se integrá-las como etapas obrigatórias do pipeline de CI/CD.