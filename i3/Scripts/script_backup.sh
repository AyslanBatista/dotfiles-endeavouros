#!/bin/bash
#################################################
#
# Fazendo o Backup do meu computador Principal
#
#################################################

#VARIAVEIS
#Criar um arquivo .secrets que contem as variaveis:
#CAMINHO_PASTA_BACKUP Caminho completo com o nome da pasta que guardará o backup, não colocar / no final
#NOME_PASTA nome da pasta que guardará todo o backup
#CAMINHO_BACKUP Caminho onde a pasta ficará guardada 
#USER_IP variavel que contem o nome do usuario e ip para acesso via ssh
#PORTA_SSH variavel que contem a porta do ssh

source $HOME/backup/.secrets

# Caminho das Pasta que será feita o backup
declare -a PASTA_PARA_BACKUP=(
"/etc"
"/usr/local/bin"
"/var"
"/opt"
"/root"
"/boot"
"/home/ayslan"
)

main()
{
        verificando_ssh
        verificando_arquivo_compactado
        fazendo_backup
        compactando
        return 0
}
verificando_ssh()
{
C=$SSH_AUTH_SOCK
R=n/a
unset SSH_AUTH_SOCK
        for s in $(ls $C /tmp/ssh-*/agent.* 2>/dev/null | sort -u) ; do
                if SSH_AUTH_SOCK=$s ssh-add -l >/dev/null ; then R=$? ; else R=$? ; fi
                case "$R" in
                        0|1) export SSH_AUTH_SOCK=$s ; break ;;
                esac
        done
        if ! test -S "$SSH_AUTH_SOCK" ; then
                eval $(ssh-agent -s)
                unset SSH_AGENT_PID
                R=1
        fi
echo "Using $SSH_AUTH_SOCK"
        if test "$R" = "1" ; then
                ssh-add
        fi
}
verificando_arquivo_compactado()
{
        if [ -f "$CAMINHO_PASTA_BACKUP.tar" ]; then
                mv $CAMINHO_PASTA_BACKUP.tar .
                sudo tar -xvf ${NOME_PASTA}.tar
                sudo rm  -rf ${NOME_PASTA}.tar
        else
                echo "Não existe a pasta $CAMINHO_PASTA_BACKUP.tar compactada"
        fi
}
fazendo_backup()
{
        for dir in ${PASTA_PARA_BACKUP[@]}; do
               rsync -vzarP -e 'ssh -p '$PORTA_SSH'' --progress --delete ${USER_IP}:$dir ${NOME_PASTA}
        done
}
compactando()
{
        if [ -d "$NOME_PASTA" ]; then
                sudo time tar -cvf ${NOME_PASTA}.tar EndeavourOS/
                sudo rm -rf ${NOME_PASTA}
                mv ${NOME_PASTA}.tar ${CAMINHO_BACKUP} 
        else
                echo "Não existe a pasta ${NOME_PASTA} para compactar"
        fi 
}
main
