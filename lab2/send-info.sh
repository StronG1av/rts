#!/bin/bash
password="wasd"
remote_server="maksim@192.168.0.162:/home/maksim/results"
local_dir="/home/lab2/results/*"
sshpass -p "$password" scp $local_dir "$remote_server"
echo "Файлы успешно перенесены на сервер!"
