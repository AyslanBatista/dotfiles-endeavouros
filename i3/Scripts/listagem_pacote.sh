#!/bin/zsh
##############################################################
#
# Guardando a Listagem de Pacotes Depois de fazer Atualização
#
#############################################################

#VARIAVEIS
source ~/.zshrc
CAMINHO_PASTA_LISTAGEM="$HOME/Documents/pacman/"
DATA_ATUAL=`date +%d_%m_%Y`
declare -a ULTIMO_ARQUIVO=(`ls -t ${CAMINHO_PASTA_LISTAGEM}`)


main()
{
        verificando_arquivo
        verificando_diferencas
}
verificando_arquivo()
{
        if [ -f "${CAMINHO_PASTA_LISTAGEM}pacman_${DATA_ATUAL}.txt" ]; then
                echo "Arquivo Já existe"
        else
                armazenando_lista_pacote
        fi
}
armazenando_lista_pacote()
{
        yay -Q > ${CAMINHO_PASTA_LISTAGEM}pacman_${DATA_ATUAL}.txt
}
verificando_diferencas()
{
        diff -u ${CAMINHO_PASTA_LISTAGEM}${ULTIMO_ARQUIVO[1]}  ${CAMINHO_PASTA_LISTAGEM}${ULTIMO_ARQUIVO[2]}
}
main
