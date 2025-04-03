#!/bin/bash
# Разбор аргументов
while getopts "d:" opt; do
  case $opt in
    d) directory=$OPTARG ;;
    *) echo "Использование: $0 -d <директория>"; exit 1 ;;
  esac
done
# Проверка существования директории
if [ ! -d "$directory" ]; then
  echo "Ошибка: директория '$directory' не существует." > /home/lab2/results/result_loops.txt
  exit 1
fi
# Переименование файлов
for file in "$directory"/*; do
  [ -e "$file" ] || continue  # Проверка, что файл существует
  if [ -f "$file" ]; then
    timestamp=$(date +"%Y%m%d_%H%M%S")
    filename=$(basename -- "$file")           # Получаем имя файла с расширением
    extension="${filename##*.}"               # Получаем расширение файла
    filename="${filename%.*}"                 # Убираем расширение из имени
    dirpath=$(dirname -- "$file")             # Получаем путь к директории
    new_name="${dirpath}/${filename}_${timestamp}.${extension}"
    mv "$file" "$new_name"
    echo "Переименован: $file -> $new_name" >> /home/lab2/results/result_loops.txt
  fi
done
