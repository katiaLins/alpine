#!/bin/sh

# Atualizar sistema e repositórios
apk update && apk upgrade

# Instalar servidor Xorg e drivers de vídeo básicos
apk add xorg-server xf86-video-vesa xf86-input-keyboard xf86-input-mouse

# Detectar placa de vídeo e instalar drivers específicos (opcional)
if lspci | grep -i vga | grep -i intel; then
  apk add xf86-video-intel
elif lspci | grep -i vga | grep -i amd; then
  apk add xf86-video-ati
elif lspci | grep -i vga | grep -i nvidia; then
  apk add xf86-video-nvidia
fi

# Instalar XFCE
apk add xfce4 xfce4-terminal xfce4-whiskermenu-plugin xfce4-panel-profiles

# Instalar gerenciador de login LightDM
apk add lightdm lightdm-gtk3-greeter

# Habilitar LightDM na inicialização
rc-update add lightdm default

# Instalar pacotes úteis (navegador, arquivos, rede, escritório leve)
apk add firefox thunar file-roller sudo networkmanager \
networkmanager-openvpn chromium evince libreoffice-writer libreoffice-calc

# Habilitar NetworkManager
rc-update add NetworkManager default

# Reiniciar para entrar no ambiente gráfico
echo "Instalação concluída. Reiniciando em 10 segundos..."
sleep 10
reboot