#!/bin/bash

# Параметры подключения
SERVER_IP="192.168.0.163"
SHARE_NAME="public"
MOUNT_POINT="/mnt/samba_share"
USERNAME="sambauser"
PASSWORD="password"

# Установка необходимых пакетов
sudo apt update && sudo apt install -y cifs-utils

# Создание точки монтирования
sudo mkdir -p "$MOUNT_POINT"

# Монтирование сетевого ресурса
sudo mount -t cifs "//$SERVER_IP/$SHARE_NAME" "$MOUNT_POINT" -o username=$USERNAME,password=$PASSWORD,iocharset=utf8,file_mode=0777,dir_mode=0777

# Проверка успешности монтирования
if mountpoint -q "$MOUNT_POINT"; then
    echo "Подключение успешно: $MOUNT_POINT"
else
    echo "Ошибка подключения"
fi
