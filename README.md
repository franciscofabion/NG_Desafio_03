# Monitoramento de Diretório com Bash

[![Status](https://img.shields.io/badge/status-ativo-brightgreen)](https://github.com/franciscofabion/NG_Desafio_03)
[![Linux](https://img.shields.io/badge/sistema-Linux-blue)](https://www.linux.org/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE)

Este projeto implementa um serviço Linux que monitora um diretório e move arquivos automaticamente para outro diretório assim que são criados.

---

## Sumário

- [Funcionalidades](#funcionalidades)  
- [Requisitos](#requisitos)  
- [Instalação](#instalação)  
- [Uso](#uso)  
- [Observações](#observações)  
- [Tecnologias](#tecnologias)  

---

## Funcionalidades

- Monitoramento em tempo real do diretório de origem  
- Movimentação automática para o diretório de destino  
- Serviço inicia junto com o sistema (systemd)  

---

## Requisitos

- Linux  
- `inotify-tools`  
- Acesso root para criar o serviço systemd  

---

## Instalação

### 1. Instalar `inotify-tools`
```bash
sudo apt install inotify-tools
2. Criar os diretórios de origem e destino
bash
Copiar código
mkdir -p /home/fabio
mkdir -p /home/fabio/ngbilling
3. Criar o script /usr/local/bin/mover_arquivo.sh
bash
Copiar código
#!/bin/bash
ORIGEM="/home/fabio"
DESTINO="/home/fabio/ngbilling"

inotifywait -m -e create "$ORIGEM" |
while read caminho evento arquivo
do
    mv "$ORIGEM/$arquivo" "$DESTINO/"
done
4. Tornar o script executável
bash
Copiar código
sudo chmod +x /usr/local/bin/mover_arquivo.sh
5. Criar o serviço systemd /etc/systemd/system/mover_arquivo.service
ini
Copiar código
[Unit]
Description=Serviço de monitoramento e movimentação de arquivos
After=network.target

[Service]
ExecStart=/usr/local/bin/mover_arquivo.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
6. Ativar e iniciar o serviço
bash
Copiar código
sudo systemctl daemon-reload
sudo systemctl enable mover_arquivo.service
sudo systemctl start mover_arquivo.service
Uso
Coloque arquivos no diretório de origem (/home/fabio).

Eles serão movidos automaticamente para o diretório de destino (/home/fabio/ngbilling).

Observações
Teste o script manualmente antes de criar o serviço.

O serviço roda em background e inicia automaticamente no boot do Linux.

É possível alterar os caminhos de origem e destino conforme necessidade.

Tecnologias
Bash

Systemd

inotify-tools
