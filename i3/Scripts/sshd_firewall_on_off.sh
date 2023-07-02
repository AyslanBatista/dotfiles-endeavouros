#!/bin/bash
######################################
#
# SCRIPT QUE ATIVA FIREWALL E SSHD
#
######################################

#Criar um arquivo com o nome .secrets
#onde contém o numero da porta que
#o SSH e o Firewall etá usando

#VARIAVEIS
source $HOME/.config/i3/Scripts/.secrets
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
