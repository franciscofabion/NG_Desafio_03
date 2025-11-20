# Monitoramento de Diretório com Bash

[![Status](https://img.shields.io/badge/status-ativo-brightgreen)](https://github.com/franciscofabion/NG_Desafio_03)
[![Linux](https://img.shields.io/badge/sistema-Linux-blue)](https://www.linux.org/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE)

Este projeto implementa um serviço Linux que monitora um diretório e move arquivos automaticamente para outro diretório assim que são criados.

---

## 1. Funcionalidades

- Monitoramento em tempo real do diretório de origem  
- Movimentação automática para o diretório de destino  
- Serviço inicia junto com o sistema (systemd)  

---

## 2. Requisitos

- Linux  
- `inotify-tools`  
- Acesso root para criar o serviço systemd  

---

## 3. Instalação

### 3.1. Instalar `inotify-tools`

sudo apt install inotify-tools
3.2. Criar os diretórios de origem e destino
mkdir -p /home/fabio
mkdir -p /home/fabio/ngbilling
3.3. Criar o script /usr/local/bin/mover_arquivo.sh
#!/bin/bash
ORIGEM="/home/fabio"
DESTINO="/home/fabio/ngbilling"

inotifywait -m -e create "$ORIGEM" |
while read caminho evento arquivo
do
    mv "$ORIGEM/$arquivo" "$DESTINO/"
done
3.4. Tornar o script executável
sudo chmod +x /usr/local/bin/mover_arquivo.sh
3.5. Criar o serviço systemd /etc/systemd/system/mover_arquivo.service
[Unit]
Description=Serviço de monitoramento e movimentação de arquivos
After=network.target

[Service]
ExecStart=/usr/local/bin/mover_arquivo.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
3.6. Ativar e iniciar o serviço
sudo systemctl daemon-reload
sudo systemctl enable mover_arquivo.service
sudo systemctl start mover_arquivo.service
4. Uso
Coloque arquivos no diretório de origem (/home/fabio).

Eles serão movidos automaticamente para o diretório de destino (/home/fabio/ngbilling).

5. Observações
Teste o script manualmente antes de criar o serviço.

O serviço roda em background e inicia automaticamente no boot do Linux.

É possível alterar os caminhos de origem e destino conforme necessidade.

6. Tecnologias

Systemd

inotify-tools

7. Licença
Este projeto está licenciado sob a MIT License. Veja o arquivo LICENSE para detalhes.
