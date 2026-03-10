#!/usr/bin/env bash
# 01/12/2015
# Atualizado para 2026-03
# Script para configurar repositórios Debian oficiais e instalar pacotes base.

set -u

if [[ $(id -u) -ne 0 ]]; then
  echo "Você precisa executar como root (sudo)."
  exit 1
fi

check_debian() {
  if [[ ! -r /etc/os-release ]]; then
    echo "Não foi possível identificar o sistema (/etc/os-release)."
    exit 1
  fi

  # shellcheck disable=SC1091
  . /etc/os-release

  if [[ "${ID:-}" != "debian" ]]; then
    echo "Este script é exclusivo para Debian. Sistema detectado: ${ID:-desconhecido}"
    exit 1
  fi

  if [[ -z "${VERSION_CODENAME:-}" ]]; then
    echo "Não foi possível identificar a versão do Debian."
    exit 1
  fi

  case "$VERSION_CODENAME" in
    bookworm|trixie)
      echo "Debian detectado: ${PRETTY_NAME:-Debian}"
      ;;
    *)
      echo "Versão Debian detectada: ${PRETTY_NAME:-Debian}."
      echo "Continuando com configuração padrão para ${VERSION_CODENAME}."
      ;;
  esac
}

setup_sources() {
  local codename backup
  codename="$VERSION_CODENAME"
  backup="/etc/apt/sources.list.backup.2026"

  echo "Criando backup de /etc/apt/sources.list em $backup"
  cp /etc/apt/sources.list "$backup"

  cat > /etc/apt/sources.list <<SRC
deb http://deb.debian.org/debian $codename main contrib non-free non-free-firmware
deb http://deb.debian.org/debian $codename-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security $codename-security main contrib non-free non-free-firmware
SRC
}

install_base_packages() {
  local pkgs=(
    curl
    wget
    ca-certificates
    gnupg
    apt-transport-https
    firefox-esr
    chromium
    vlc
    audacious
    ffmpeg
    p7zip-full
    unrar-free
    bleachbit
    openjdk-17-jdk
  )

  echo "Atualizando lista de pacotes..."
  apt-get update

  echo "Instalando pacotes base..."
  apt-get install -y "${pkgs[@]}"

  echo "Executando limpeza final..."
  apt-get autoremove -y
  apt-get autoclean -y
}

main() {
  clear
  echo "Bem-vindo. Este script prepara o Debian para uso básico em 2026."
  echo

  check_debian

  read -r -n1 -p "Deseja continuar com a configuração? (s/n): " escolha
  echo

  case "$escolha" in
    s|S)
      setup_sources
      install_base_packages
      echo "Concluído."
      ;;
    n|N)
      echo "Saindo sem alterações."
      ;;
    *)
      echo "Opção inválida. Saindo."
      exit 1
      ;;
  esac
}

main
