#!/bin/bash

printMenu(){
	
cat << END
1. Напечатать имя текущего каталога
2. Сменить текущий каталог
3. Выдать список пользователей, имеющих хотя бы один процесс
4. Создать файл
5. Скопировать файл
6. Выйти из программы

END

	return
}

while true
do
	printMenu
	read -p "Введите номер пункта из меню: " opt
	case $opt in
		1)
			printf "`pwd`\n\n"
			;;
		2)
			read -p "Путь до новой директории: " newdir
			cd "$newdir"
			printf "Текущий каталог сменён на `pwd`\n\n"
			;;
		3)
			# TODO
			printf 'Пока не умею\n\n'
			;;
		4)
			read -p "Введите имя файла: " filename
			touch "$filename"
			printf "Файл $filename создан\n\n"
			;;
		5)
			read -p "Файл для копирования: " filename
			read -p "Путь копирования: " path
			cp "$filename" "$path"
			printf "Файл $filename скопирован в $path\n\n"
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
