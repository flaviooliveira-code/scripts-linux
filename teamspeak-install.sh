#!/usr/bin/env bash
# 2016 - Atualizado para 2026-03
# Instalação/remoção do TeamSpeak via Flatpak.

set -u

APP_ID="com.teamspeak.TeamSpeak"
FLATHUB_URL="https://flathub.org/repo/flathub.flatpakrepo"

if [[ $(id -u) -eq 0 ]]; then
  echo "Execute sem root. O script usa sudo apenas quando necessário."
  exit 1
fi

check_connection() {
  ping -c 2 1.1.1.1 >/dev/null 2>&1
}

ensure_flatpak() {
  if command -v flatpak >/dev/null 2>&1; then
    return 0
  fi

  echo "Flatpak não encontrado. Instalando..."
  sudo apt-get update && sudo apt-get install -y flatpak
}

ensure_flathub() {
  if flatpak remote-list | awk '{print $1}' | grep -qx "flathub"; then
    return 0
  fi

  echo "Adicionando Flathub..."
  flatpak remote-add --if-not-exists flathub "$FLATHUB_URL"
}

install_teamspeak() {
  check_connection || {
    echo "Sem conexão com a internet."
    exit 1
  }

  ensure_flatpak
  ensure_flathub

  echo "Instalando $APP_ID..."
  flatpak install -y flathub "$APP_ID"

  echo "Concluído. Execute com: flatpak run $APP_ID"
}

remove_teamspeak() {
  if ! command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak não encontrado. Nada para remover."
    return 0
  fi

  echo "Removendo $APP_ID..."
  flatpak uninstall -y "$APP_ID" || true
  echo "Concluído."
}

main() {
  clear
  echo "TeamSpeak Installer 2026"
  echo
  echo "i) Instalar"
  echo "r) Remover"
  echo "s) Sair"
  echo

  read -r -n1 -p "Escolha i(instalar), r(remover) ou s(sair): " escolha
  echo

  case "$escolha" in
    i|I)
      install_teamspeak
      ;;
    r|R)
      remove_teamspeak
      ;;
    s|S)
      echo "Saindo..."
      ;;
    *)
      echo "Alternativa inválida."
      exit 1
      ;;
  esac
}

main
