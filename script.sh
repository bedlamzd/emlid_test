#!/bin/bash
# shellcheck disable=SC2162
#
# Тестовое задание в Emlid

ERROR_LOG="task_err"

print_menu() {
  cat <<END
1. Напечатать имя текущего каталога
2. Сменить текущий каталог
3. Выдать список пользователей, имеющих хотя бы один процесс
4. Создать файл
5. Скопировать файл
6. Выйти из программы

END
}

err() {
  printf "Ошибка! %s\n\n" "$(tail -n 1 ${ERROR_LOG})" >&1
}

read() {
  # По заданию необходимо читать с новой строки
  echo "$1"
  command read -r "$2"
}

while true; do
  print_menu
  read "Введите номер пункта из меню: " opt
  case ${opt} in
    1)
      printf "Текущий каталог: %s\n\n" "$(pwd)"
      ;;
    2)
      read "Путь до новой директории: " newdir
      if cd -- "${newdir}" 2>>${ERROR_LOG}; then
        printf "Текущий каталог: %s\n\n" "$(pwd)"
      else
        err
      fi
      ;;
    3)
      printf "Список пользователей, имеющих хотя бы один процесс:\n"
      printf "%s\n\n" "$(ps -ef --no-headers --sort=user | awk '{print $1}' | uniq)"
      ;;
    4)
      read "Введите имя файла: " filename
      if touch -- "${filename}" 2>>${ERROR_LOG}; then
        printf "Файл \"%s\" создан\n\n" "${filename}"
      else
        err
      fi
      ;;
    5)
      read "Файл для копирования: " filename
      read "Путь копирования: " path
      if cp -- "${filename}" "${path}" 2>>${ERROR_LOG}; then
        printf "Файл \"%s\" скопирован в \"%s\"\n\n" "${filename}" "${path}"
      else
        err
      fi
      ;;
    6)
      echo "Осуществляю выход из программы."
      exit 0
      ;;
    *)
      printf "Нет такого пункта в меню.\n\n"
      ;;
  esac
done
