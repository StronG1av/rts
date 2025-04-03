#!/bin/bash

# Разбор аргументов
while getopts "y:" opt; do
  case $opt in
    y) year=$OPTARG ;;
    *) echo "Использование: $0 -y <год>"; exit 1 ;;
  esac
done

# Проверка на високосный год
if (( (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) )); then
  echo "$year - високосный год" > /home/lab2/results/result_branching.txt
else
  echo "$year - не високосный год" > /home/lab2/results/result_branching.txt
fi
