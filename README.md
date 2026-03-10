# Scripts Linux (Atualizado para 2026)

Coleção de scripts shell para automação de tarefas comuns em Linux (Debian/Ubuntu e derivados), como limpeza do sistema, backup, instalação de pacotes e utilitários administrativos.

## Status do projeto

- Revisão geral aplicada em **10 de março de 2026**.
- Scripts com ajustes de compatibilidade, correções de bugs e melhorias de robustez.
- Validação sintática executada com `bash -n` nos arquivos principais.

## Requisitos gerais

- `bash`
- Permissões de execução (`chmod +x <script>.sh`)
- Alguns scripts exigem `sudo/root`
- Conexão com internet para scripts de instalação

## Scripts disponíveis

### Administração e manutenção

- `autoclean-linux.sh`: limpeza de cache, pacotes órfãos e arquivos temporários.
- `otimiza_sistema.sh`: ajustes de parâmetros de desempenho (legado).
- `removeoldkernel.sh`: remove kernels antigos mantendo o atual.
- `poweroff.sh`: agenda/cancela desligamento com interface `zenity`.
- `testa_conexao.sh`: teste simples de conectividade.

### Instalação e configuração

- `install-LAMP.sh`: instalação básica de stack LAMP (Apache, MySQL, PHP).
- `silent-install-debian.sh`: configuração de repositórios Debian modernos e instalação de pacotes base.
- `popcorntime-install.sh`: instalar/remover Popcorn Time via Flatpak.
- `teamspeak-install.sh`: instalar/remover TeamSpeak via Flatpak.
- `reset-config-unity.sh`: reset de configurações do Unity (script legado).

### Virtualização

- `vmservice.sh`: registra VM para inicialização como serviço (fluxo legado VirtualBox).
- `vboxcontrol`: script init para controle de VMs do VirtualBox.

### Dados e backup

- `backup-automatico.sh`: backup Full/Incremental com `rsync` e `zenity`.
- `script-base-de-dados.sh`: extrai texto de PDFs e gera `dados.csv` filtrado.

## Como usar

1. Entre na pasta do projeto.
2. Dê permissão de execução ao script desejado.
3. Execute com ou sem `sudo`, conforme necessidade.

Exemplos:

```bash
chmod +x autoclean-linux.sh
sudo ./autoclean-linux.sh
```

```bash
chmod +x teamspeak-install.sh
./teamspeak-install.sh
```

## Observações importantes

- Alguns scripts são **legados** e podem depender de componentes antigos da distro.
- Scripts de instalação foram adaptados para abordagens viáveis em 2026 quando possível.
- Revise o conteúdo antes de executar em ambiente de produção.
- Use com cautela e faça backup dos dados importantes antes de rodar scripts de manutenção ou instalação.
