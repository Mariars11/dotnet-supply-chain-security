
package security

import rego.v1

# Obtém o usuário configurado na imagem.
# Se não existir, considera uma string vazia.

user := object.get(input.Config, "User", "")

# Bloqueia imagens sem usuário definido.
deny contains msg if {
    user == ""
    msg := "BLOQUEADO: imagem sem usuario definido (root por padrao)"
}

# Bloqueia usuário root explícito.
deny contains msg if {
    user == "root"
    msg := "BLOQUEADO: container configurado para executar como root"
}

# Bloqueia UID 0.
deny contains msg if {
    user == "0"
    msg := "BLOQUEADO: container configurado com UID 0"
}
