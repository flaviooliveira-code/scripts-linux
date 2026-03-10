#!/usr/bin/env bash
# 02/12/2015 - Atualizado para 2026-03
# Instalação/remoção do Popcorn Time via Flatpak (método mais estável em 2026).

set -u

APP_ID="app.popcorntime.PopcornTime"
FLATHUB_URL="https://flathub.org/repo/flathub.flatpakrepo"

check_connection() {
  echo "Verificando conexão com a internet..."
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

  echo "Adicionando repositório Flathub..."
  flatpak remote-add --if-not-exists flathub "$FLATHUB_URL"
}

install_app() {
  check_connection || {
    echo "Sem conexão com a internet."
    exit 1
  }

  ensure_flatpak
  ensure_flathub

  echo "Instalando $APP_ID..."
  flatpak install -y flathub "$APP_ID"

  echo "Instalação concluída."
  echo "Para abrir: flatpak run $APP_ID"
}

remove_app() {
  if ! command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak não encontrado. Nada para remover."
    return 0
  fi

  echo "Removendo $APP_ID..."
  flatpak uninstall -y "$APP_ID" || true
  echo "Remoção concluída."
}

main() {
  clear
  echo "Bem-vindo"
  echo
  echo "i) Instalar"
  echo "r) Remover"
  echo "s) Sair"
  echo

  read -r -n1 -p "Escolha i(instalar), r(remover) ou s(sair): " escolha
  echo

  case "$escolha" in
    i|I)
      install_app
      ;;
    r|R)
      remove_app
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
