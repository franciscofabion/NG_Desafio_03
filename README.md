# Monitoramento de Diretório com Bash

[![Status](https://img.shields.io/badge/status-ativo-brightgreen)](https://github.com/seuusuario/monitoramento-bash)
[![Linux](https://img.shields.io/badge/sistema-Linux-blue)](https://www.linux.org/)

Este projeto implementa um serviço Linux que monitora um diretório e move arquivos automaticamente para outro diretório assim que são criados.

---

## Funcionalidades

- Monitoramento em tempo real de diretório de origem
- Movimentação automática para diretório de destino
- Serviço inicia junto com o sistema (systemd)

---

## Requisitos

- Linux
- `inotify-tools`
- Acesso root para criar o serviço systemd

---

## Instalação Rápida

1. Instale o `inotify-tools`:

```bash
sudo apt install inotify-tools

## Crie os diretórios de origem e destino

mkdir -p /home/fabio
mkdir -p /home/fabio/ngbilling

## Crie o script /usr/local/bin/mover_arquivo.sh:

#!/bin/bash
ORIGEM="/home/fabio"
DESTINO="/home/fabio/ngbilling"

inotifywait -m -e create "$ORIGEM" |
while read caminho evento arquivo
do
    mv "$ORIGEM/$arquivo" "$DESTINO/"
done

## Torne o script executável

sudo chmod +x /usr/local/bin/mover_arquivo.sh

## Crie o serviço systemd /etc/systemd/system/mover_arquivo.service

[Unit]
Description=Servico de monitoramento e movimentacao de arquivos
After=network.target

[Service]
ExecStart=/usr/local/bin/mover_arquivo.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target

## Ative e inicie o serviço

sudo systemctl daemon-reload
sudo systemctl enable mover_arquivo.service
sudo systemctl start mover_arquivo.service

## Uso

Coloque arquivos no diretório de origem (/home/fabio). Eles serão movidos automaticamente para o diretório de destino (/home/fabio/ngbilling).

