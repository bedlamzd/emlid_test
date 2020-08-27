#!/bin/bash

ERROR_LOG="task_err"
exec 2>>${ERROR_LOG}

printMenu(){
cat << END
1. Напечатать имя текущего каталога
2. Сменить текущий каталог
3. Выдать список пользователей, имеющих хотя бы один процесс
4. Создать файл
5. Скопировать файл
6. Выйти из программы

END
}

printError(){
	message=$1
	printf "Ошибка. ${message}\n\n" >&1
}

read(){
	# Нужно из-за проблемы с read, при перенаправлении ошибок пропадает промпт.
	printf "$1"
	command read $2
}


while true
do
	printMenu
	read "Введите номер пункта из меню: " opt
	case $opt in
		1)
			printf "Текущий каталог: `pwd`\n\n"
			;;
		2)
			read "Путь до новой директории: " newdir
			cd "${newdir}" # Выполняется всегда для заполнения лога ошибок автоматически
			[ $? == 0 ] && printf "Текущий каталог: `pwd`\n\n" || printError "Не существует директории \"${newdir}\""
			;;
		3)
			printf "Список пользователей, имеющих хотя бы один процесс:\n"
			printf "`ps -ef --no-headers --sort=user | awk '{print $1}' | uniq`\n\n"
			;;
		4)
			read "Введите имя файла: " filename
			touch "$filename" # Выполняется всегда для заполнения лога ошибок автоматически
			[ $? == 0 ] && printf "Файл \"$filename\" создан\n\n" || printError "Нет такой директории \"`dirname "$filename"`\""
			;;
		5)
			read "Файл для копирования: " filename
			read "Путь копирования: " path
			if [ ! -e "$filename" ]
			then
				message="Нет такого файла \"$filename\""
			elif [ ! -d "`dirname "$path"`" ]
			then
				message="Нет такой директории \"`dirname "$path"`\""
			fi
			cp "$filename" "$path" # Выполняется всегда для заполнения лога ошибок автоматически
			[ $? == 0 ] && printf "Файл \"$filename\" скопирован в \"$path\"\n\n" || printError "$message"
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


