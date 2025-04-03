#!/bin/bash

# Параметры конфигурации
SAMBA_USER="sambauser"
SAMBA_PASSWORD="password"
SHARE_NAME="public"
SHARE_PATH="/srv/samba/$SHARE_NAME"

# Установка пакетов
sudo apt update && sudo apt install -y samba

# Создание папки для общего доступа
sudo mkdir -p "$SHARE_PATH"
sudo chown nobody:nogroup "$SHARE_PATH"
sudo chmod 777 "$SHARE_PATH"

# Создание пользователя Samba
sudo useradd -M -s /sbin/nologin "$SAMBA_USER"
echo -e "$SAMBA_PASSWORD\n$SAMBA_PASSWORD" | sudo smbpasswd -a -s "$SAMBA_USER"
sudo smbpasswd -e "$SAMBA_USER"

# Резервное копирование оригинального конфигурационного файла
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Настройка Samba
sudo bash -c "cat > /etc/samba/smb.conf" <<EOL
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   security = user
   map to guest = Bad User
   dns proxy = no

[$SHARE_NAME]
   path = $SHARE_PATH
   browsable = yes
   writable = yes
   guest ok = no
   valid users = @$SAMBA_USER
EOL

# Перезапуск службы Samba
sudo systemctl restart smbd
sudo systemctl enable smbd

# Вывод информации
echo "Samba установлена и настроена. Подключайтесь к папке: \\\\$HOSTNAME\\$SHARE_NAME"
