printMenu(){
	
cat << END
1. Напечатать имя текущего каталога
2. Сменить текущий каталог
3. Выдать список пользователей имеющих хотя бы один процесс
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
		echo `pwd`
		;;
	2)
		read -p "Куда идём? " newdir
		cd $newdir
		;;
	3)
		# TODO
		echo "Пока не умею"
		;;
	4)
		read -p "Введите имя файла: " filename
		touch $filename
		;;
	5)
		read -p "Что копируем? " filename
		read -p "Куда копируем? " path
		cp $filename $path
		;;
	6)
		exit 0
		;;
	*)
		echo "Нет такого пункта в меню."
		;;
	esac
done
