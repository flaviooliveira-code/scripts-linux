#!/usr/bin/env bash
#remove kernel antigo

#Variáveis de cores
vermelho="\033[1;31m"
azul="\033[1;34m"
NORMAL="\033[m"

menu()
{
if [[ $(id -u) -ne 0 ]]; then
	echo -e "${vermelho}Execute como root (sudo).${NORMAL}"
	exit 1
fi

clear
echo -e "${azul}Kernel Atual do Sistema${NORMAL}"
uname -r
echo
echo -e "${azul}Kernels encontrados no Sistema${NORMAL}"
dpkg-query -l | awk '/linux-image-*/ {print $2}'
echo
echo
sleep 4
echo -e "${vermelho}Se tiver driver proprietário NVIDIA ou AMD, aconselho desabilitar antes de excluir os kernels antigos.\nLogo em seguida ative-os no kernel atual.Caso contrário pode resultar perda do driver de vídeo após o reboot do sistema, já que os drivers não foram compilados no kernel atual."
echo -e "${azul}Deseja exluir os kernels antigos, menos o atual? \nKernel atual: `uname -r` \ns/n${NORMAL}"
sleep 1
read -n1 -s escolha

case $escolha in
	S|s) echo
		echo -e ${vermelho}Removendo Kernels antigos${NORMAL}
        dpkg -l 'linux-image-[0-9]*' \
          | awk '/^ii/ { print $2 }' \
          | grep -v "$(uname -r | sed 's/-generic$//')" \
          | xargs -r apt-get -y purge
        update-grub
        ;;
	N|n) echo
		echo -e ${azul}Operação Cancelada${NORMAL}
		sleep 2 && exit
        ;;
	*) echo
		echo -e ${vermelho}Opção incorreta${NORMAL}
        sleep 2 && menu
        ;;
esac
}
menu
