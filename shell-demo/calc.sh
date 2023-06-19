
re='^[0-9]+$'

while true
do
	#/bin/echo -n ">> "
	read -p ">> " a operator b
	if ! [[ $a =~ $re ]]; then	
		case $a in
			HIST)
				#result=$(cat HIST | tail -n 5)
				save_hst=$(cat HIST | tail -n 5)
				echo "$save_hst"
				continue
				;;
			EXIT)exit 0				;;
			ANS)
				a=`cat save_ans.log.txt`
			;;
		#*)	continue			;;
		esac
	fi

	if [[ $operator == '/' && $b == 0 ]]; then
		echo "MATH ERROR"
		continue
	fi

	if [[ $operator != '+' && $operator != '-' && $operator != '*' && $operator != '/' && $operator != '%' ]];
	then
		echo "SYNTAX ERROR"
		continue
	fi

	case $operator in
		'+')result=`echo $a+$b | bc`		;;
		'-')result=`echo $a-$b | bc`		;;
		'*')result=`echo $a\*$b |bc`		;;
		'/')result=`echo "scale=2; $a/$b" | bc`	;;
		'%')result=`echo $a%$b | bc`		;;
	esac
	
	echo $result > save_ans.log.txt
	if [[ $operator == '*' ]]; then
		echo -e "$a \x2A $b = $result" >> HIST
	else
		echo -e "$a $operator $b = $result" >> HIST
	fi

	echo $result | bc
done
