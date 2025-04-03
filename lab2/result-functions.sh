#!/bin/bash
# Разбор аргументов
while getopts "s:e:" opt; do
  case $opt in
    s) start_date=$OPTARG ;;
    e) end_date=$OPTARG ;;
    *) echo "Использование: $0 -s <начальная_дата> -e <конечная_дата>"; exit 1 ;;
  esac
done
# Проверка на корректность ввода
if [[ -z "$start_date" || -z "$end_date" ]]; then
  echo "Ошибка: необходимо указать обе даты." > /home/lab2/results/result_functions.txt
  exit 1
fi

# Вычисление разницы в днях
diff_days=$(( ( $(date -d "$end_date" +%s) - $(date -d "$start_date" +%s) ) / 86400 ))
echo "Разница между $start_date и $end_date: $diff_days дней" > /home/lab2/results/result_functions.txt
