#!/bin/bash
######################################
#
# SCRIPT QUE ATIVA FIREWALL E SSHD
#
######################################

#Criar um arquivo com o nome .secrets onde contem
#uma variavel com o nome PORTA_SSHD com o numero
#da porta que sera usada no SSH e o Firewall 

#VARIAVEIS
#source $HOME/.config/i3/Scripts/.secrets
source /opt/.secrets
declare -a FIREWALL_PORTA=(`firewall-cmd --list-all`)

ativando_desativando_firewall()
{
        if [ "${FIREWALL_PORTA[17]}" == "${PORTA_SSHD}/tcp" ]; then
                 firewall-cmd --permanent --remove-port=${PORTA_SSHD}/tcp
                 firewall-cmd --reload
                 systemctl stop sshd
                 firewall-cmd --list-all
                 systemctl status sshd
        else
                firewall-cmd --permanent --add-port=${PORTA_SSHD}/tcp
                firewall-cmd --reload
                systemctl start sshd
                firewall-cmd --list-all
                systemctl status sshd

        fi
}
ativando_desativando_firewall
