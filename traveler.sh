#!/bin/bash

POWDER_BLUE=$(tput setaf 153)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
player="[38;5;254m@"


# Reset terminal on exit
trap 'tput cnorm; tput sgr0; clear' EXIT
# invisible cursor, no echo
tput civis
stty -echo
#printf "\033c"
clear

#variables
swordslot=("15" "2" "Toy Sword" "20" "20")
shieldslot=("6" "4" "Toy Shield" "10" "15")
spellslot=("0" "6" "nothing" "nothing")
attackskillslot=("0" "3" "nothing" "0" "0")
defenseskillslot=("0" "5" "nothing" "0" "0")
playerlife=100
playerdefense=0
playerblocking=0
resizecols=$(tput cols)
prevcols=0
resizerows=$(tput lines)
prevrows=0
nomovement='┐_=¬│┤└┴┬├─┼┘┌¯\╤╒╘/╥╫öÄÜˆ^⌂▲≈╜╞╡╪'
currentmap="32"
canblock=0

#enemies
mapenem13="3"
enem_113=("1" "1" "[38;5;001mÄ" "31" "16" "31" "16" "55" "25" "30" "20" "100" "100")
enem_213=("1" "1" "[38;5;001mö" "25" "8" "25" "8" "35" "15" "10" "20" "100" "100")
enem_313=("1" "2" "[38;5;001mÄ" "9" "11" "9" "11" "55" "25" "30" "20" "100" "100")
mapenem12="3"
enem_112=("1" "1" "[38;5;001mö" "22" "10" "22" "10" "55" "25" "30" "20" "75" "75")
enem_212=("1" "1" "[38;5;001mÄ" "37" "12" "37" "12" "55" "25" "30" "20" "100" "100")
enem_312=("1" "2" "[38;5;001mÄ" "23" "2" "23" "2" "55" "25" "30" "20" "100" "100")
mapenem11="3"
enem_111=("1" "1" "[38;5;001mÄ" "7" "16" "7" "16" "55" "25" "30" "20" "100" "100")
enem_211=("1" "1" "[38;5;001mÄ" "34" "6" "34" "6" "55" "25" "30" "20" "100" "100")
enem_311=("1" "2" "[38;5;001mž" "47" "9" "47" "9" "85" "35" "60" "10" "300" "300")


mapenem23="3"
enem_123=("1" "1" "[38;5;001mö" "17" "6" "17" "6" "30" "15" "10" "25" "75" "75")
enem_223=("1" "1" "[38;5;001mö" "39" "9" "39" "9" "30" "15" "10" "25" "75" "75")
enem_323=("1" "2" "[38;5;001mÄ" "30" "4" "30" "4" "55" "25" "30" "20" "100" "100")
mapenem22="3"
enem_122=("1" "1" "[38;5;001mö" "20" "7" "20" "7" "30" "15" "10" "25" "75" "75")
enem_222=("1" "1" "[38;5;001mö" "35" "9" "35" "9" "30" "15" "10" "25" "75" "75")
enem_322=("1" "2" "[38;5;001mÄ" "3" "11" "3" "11" "55" "25" "30" "20" "100" "100")
mapenem21="3"
enem_121=("1" "1" "[38;5;001mö" "7" "15" "7" "15" "30" "15" "30" "25" "75" "75")
enem_221=("1" "1" "[38;5;001mö" "29" "4" "29" "4" "30" "15" "10" "25" "75" "75")
enem_321=("1" "2" "[38;5;001mÄ" "41" "13" "41" "13" "55" "25" "30" "20" "100" "100")

mapenem33="3"
enem_133=("1" "1" "[38;5;001mö" "13" "13" "13" "13" "30" "15" "10" "25" "75" "75")
enem_233=("1" "1" "[38;5;001mö" "33" "17" "33" "17" "30" "15" "10" "15" "50" "50")
enem_333=("1" "2" "[38;5;001mü" "25" "6" "25" "6" "15" "5" "10" "15" "50" "50")
mapenem32="3"
enem_132=("1" "1" "[38;5;001mü" "17" "7" "17" "7" "15" "5" "10" "15" "50" "50")
enem_232=("1" "1" "[38;5;001mü" "42" "2" "42" "2" "15" "5" "10" "15" "50" "50")
enem_332=("1" "2" "[38;5;001mü" "46" "17" "46" "17" "15" "5" "10" "15" "50" "50")
mapenem31="3"
enem_131=("1" "1" "[38;5;001mö" "34" "14" "34" "14" "30" "15" "10" "25" "75" "75")
enem_231=("1" "1" "[38;5;001mü" "8" "10" "8" "10" "15" "5" "10" "15" "50" "50")
enem_331=("1" "2" "[38;5;001mü" "32" "2" "32" "2" "15" "5" "10" "15" "50" "50")



numchestsy1=("1" "3" "2")
numchestsy2=("2" "3" "3")
numchestsy3=("1" "1" "3")

chest_441732=("1" "4" "4")
chest_13831=("1" "2" "12")
chest_101133=("1" "3" "21")
chest_251833=("1" "2" "13")
chest_351133=("1" "5" "31")
chest_61021=("1" "4" "5")
chest_14121=("1" "6" "41")
chest_1222=("1" "6" "42")
chest_25222=("1" "5" "32")
chest_38122=("1" "3" "23")
chest_191523=("1" "6" "43")
chest_44123=("1" "2" "14")
chest_45123=("1" "4" "3")
chest_71711=("1" "6" "44")
chest_7212=("1" "3" "22")
chest_23012=("1" "4" "2")
chest_31112=("1" "5" "33")
chest_42313=("1" "2" "11")
chest_441313=("1" "4" "1")

item0=("0" "0" "Nothing" "0" "0")
item1=("1" "4" "'Ghostly Titanium Visage'" "75" "40")
item2=("2" "4" "Soul-Forged Buckler" "60" "30")
item3=("3" "4" "Relief, Shield Wall of Conquered Worlds" "50" "20")
item4=("4" "4" "Hollow Hardwood Shield" "20" "20")
item5=("5" "4" "Challenger Carapace" "40" "40")
item6=("6" "4" "Toy Shield" "10" "15")
item11=("11" "2" "Cursed Doomblade" "100" "5")
item12=("12" "2" "Feral Obsidian Shortsword" "40" "20")
item13=("13" "2" "Apocalypse, Vengeance of Hate" "55" "5")
item14=("14" "2" "Pain, Reaper of Conquered Worlds" "30" "85")
item15=("15" "2" "Toy Sword" "20" "20")
item21=("21" "3" "Fake Slash" "35" "5")
item22=("22" "3" "Sword Aura" "20" "20")
item23=("23" "3" "Swift Jab" "0" "35")
item31=("31" "5" "Shield Dexterity" "20" "-30")
item32=("32" "5" "Iron Arm" "30" "0")
item33=("33" "5" "Stalker's Defiance" "40" "-20")
item41=("41" "6" "Charm of Pain" "Adds 25 damage to your damage pool." "25")
item42=("42" "6" "Ceremony of Deflection" "Lowers the chance of blocking error by 15")
item43=("43" "6" "Hellfire Flare" "Enemies you engage will automatically take 10 damage per round")
item44=("44" "6" "Alteration of the Stars" "Will block an enemies critical hit once per battle")


function save {
	clear
	echo "Enter name for save: "
	read name
	rm -f "saves/$name"
	touch "saves/$name"
	echo #just id

}

function damagecalc {
	crithit=0
	errorcheck=0
	defenserandom=$((1+$RANDOM%100))
	attackrandom=$((1+$RANDOM%100))
	blockpower=0
	if [[ defenserandom -lt $definpt2 ]]; then
		blockpower=0
		errorcheck=1
	else
		blockpower=$definpt1
	fi
	if [[ attackrandom -lt $attinpt2 ]]; then
		attbonus=$((100+$RANDOM%100))
		attbonus=$(echo "scale=2; $attbonus/100" | bc)
		attbonus=$(echo "scale=2; $attbonus*$attinpt1" | bc)
		attbonus=${attbonus%.*}
		crithit=$attbonus
	else
		attbonus=$attinpt1
	fi

	damagetaken=$(($attbonus-$blockpower))
	if [[ $damagetaken -lt 0 ]]; then
		damagetaken=0
	fi
}




while [ $resizecols -lt 87 -o $resizerows -lt 31 ]; do
	resizecols=$(tput cols)
	resizerows=$(tput lines)
	if [ $resizecols -ne $prevcols -o $resizerows -ne $prevrows ]; then
		clear
		tput cup 0 0; printf "%s\n" " <----------------------------------------------------------------------------------->"
		printf "%s\n" "∧ Please Make Window Wider"
		for i in {1..31}
		do
			printf "%s\n" "|"
		done
		if [ $resizerows -lt 31 ]; then
			printf "%s" "∨ Please Make Window Longer"
		else
			printf "%s" "∨"
		fi
		prevcols=$resizecols
		prevrows=$resizerows
	fi
done
clear
tput cup 15 0
echo "Loading..."
sleep 2
clear
for i in {1..29}; do
	line=$(sed "${i}q;d" maps/ascii-art.ans)
	if [ $i -lt 8 ]; then 
		echo "$POWDER_BLUE $BLINK $line"
	else
		echo "$POWDER_BLUE $NORMAL $line"
	fi
done
aplay -q sounds/menu.wav &
tput cup 28 2; echo "Press I for information (READ BEFORE PLAYING!)"
tput cup 29 2; echo "Press Q to quit"
tput cup 30 2; echo "Press anything else to play"

read -sn 1 continue
killall aplay
clear
if [[ $continue =~ [Qq] ]]; then
	tput cnorm; tput sgr0; clear
    stty sane
    stty erase ^H
    exit 0

fi
if [[ $continue =~ [Ii] ]];then
	clear
	echo "Disclaimer: As with any games with this many details, there are probably still bugs."
	echo "    If you find one, please let me know so that I can fix it."
	echo "      (I do plan on continuing work on this game.)"
	echo ""
	echo "Things to note:"
	echo "    -This game has sound! Turn up your volume if you want to hear the sfx"
	echo "    -These maps were made by us!"
	echo "    [38;5;001m-If the map is not lining up, please change your terminal font![38;5;255m"
	echo "       FreeMono works well."   "(Audio also requires 'aplay')"
	echo ""
	echo "Gameplay:"
	echo "    -The stronger enemies Will easily kill you when you just start out."
	echo "    -From weakest to strongest: ü < ö < Ä < ž"
	echo "    -Once an enemy spots you, they will chase you down until you die or leave that "
	echo "       map section. (Choose your engagements wisely!)"
	echo "    -You win by killing the final boss (ž)"
	echo "    -[38;5;127m○[38;5;255m is a chest. When standing on it, press 'e' to open."
	echo "    -You also can heal on chests. Press 'h' when on top of one to heal your life."
	echo "    -You start at the bottom center of the 3x3 map grid"
	echo "      _______"
	echo "      | | | |"
	echo "      -------"
	echo "      | | | |"
	echo "      -------"
	echo "      | |*| |"
	echo "      _______"
	echo ""
	echo "If you don't feel like trying to level up, press 'c' now and you will get the best item in each category."
	echo "Enjoy!"


	read -sn 1 wantitems
	if [[ $wantitems == [Cc] ]]; then
		shieldslot=("1" "4" "'Ghostly Titanium Visage'" "75" "40")
		swordslot=("11" "2" "Cursed Doomblade" "100" "5")
		defenseskillslot=("31" "5" "Shield Dexterity" "20" "-30")
		attackskillslot=("22" "3" "Sword Aura" "20" "20")
		spellslot=("44" "6" "Alteration of the Stars" "Will block an enemies critical hit once per battle")
	else
		exec "./traveler.sh"
		exit 0
	fi

	
fi


sleep 0
clear
tput cup 0 0
for i in {1..21}; do
	lines=$(sed "${i}q;d" maps/map$currentmap.ans)
	printf "$lines\n"
done
for i in {0..19}; do
	if [[ $i -eq 0 ]] || [[ $(($i % 2)) -eq 0 ]]; then
		tput cup $i 56
		printf "[38;5;059m+------------------------------+"
	else
		tput cup $i 56
		printf "|                              |"
	fi
done
playerlife=$playerlife			
tput cup 1 57
printf "[38;5;255mLife: [38;5;001m${playerlife}%%"
tput cup 3 57
printf "[38;5;255mDefense: [38;5;021m$playerdefense + $playerblocking%% "
tput cup 5 57
printf "[38;5;255mAttack: [38;5;124m$playerattack + $playercrit%% [38;5;255m"
tput cup 7 57
printf "[38;5;255mSpell: [38;5;190m${spellslot[2]}[38;5;255m"
tput cup 9 57
printf "[38;5;255mWASD: Movement[38;5;255m"
tput cup 11 57
printf "[38;5;255mE: Interact[38;5;255m"
tput cup 13 57
printf "[38;5;255mF: Fight![38;5;255m"
tput cup 15 57
printf "[38;5;255mH: Heal[38;5;255m"
tput cup 17 57
printf "[38;5;255mI: Inventory[38;5;255m"
tput cup 19 57
printf "[38;5;255mQ: Quit[38;5;255m"
tput cup 20 0
printf "%s\n" "[38;5;255mThe Orks have invaded your homeland![38;5;255m"
printf "%s\n" "[38;5;255mTheir king [38;5;001mž [38;5;255m hides in the mountains"
printf "%s\n" "[38;5;255mKill him to force the enemy to retreat!"

x=17
y=19


tput cup $y $x
printf $player
#------------------------------------------------------


movelimitfinal="$(date -u +%s.%N)"
while sleep 0.001
do
    read -rsn 1 key
    movelimitinit="$(date -u +%s.%N)"
    #do

        diffmovelimit=$(echo "(($movelimitinit - $movelimitfinal) * 10) / 1" | bc -l | sed 's/\..*$//')
        if [[ $diffmovelimit -lt "1" ]]; then
            diffmovelimit=0
        fi
        if [[ $diffmovelimit -ge "3" ]]; then
        	oldx=$x
        	oldy=$y

        	

            if [[ $key == [Ss] ]]; then
               (( y++ ))
               aplay -q sounds/walk.wav &
            fi
            if [[ $key == [Ww] ]];then
            	(( y-- ))
            	aplay -q sounds/walk.wav &
            fi
            if [[ $key == [Dd] ]];then 
            	(( x++ ))
            	aplay -q sounds/walk.wav &
            fi
            if [[ $key == [Aa] ]];then 
            	(( x-- ))
            	aplay -q sounds/walk.wav &
            fi
            if [[ $((y+1)) -ne 0 ]]; then
            	linetest=$(sed "$((y+1))q;d" maps/map$currentmap.txt)
            	linetest=$(echo ${linetest:$x:1} )
        	fi

        	if [[ $key == [Ii] ]];then
        		tput cup 20 0
        		printf  "%s\n" "[38;5;124mSword: ${swordslot[2]}"
        		printf  "%s\n" "    Damage: ${swordslot[3]}, Crit Chance: ${swordslot[4]} %"
        		printf  "%s\n" "Sword Skill: ${defenseskillslot[2]}"
        		printf  "%s\n" "    Damage Modifier: ${attackskillslot[3]}, Crit Chance modifier: ${attackskillslot[4]} % "
        		printf  "%s\n" "[38;5;21mShield: ${shieldslot[2]}"
        		printf  "%s\n" "    Block Amount: ${shieldslot[3]}, Error Chance: ${shieldslot[4]} % "
        		printf  "%s\n" "Shield Skill: ${defenseskillslot[2]}"
        		printf  "%s\n" "    Block Amount Modifier: ${defenseskillslot[3]}, Error Chance modifier: ${defenseskillslot[4]} % "
        		printf  "%s\n" "[38;5;190mSpell: ${spellslot[2]}"
        		printf  "%s\n" "    ${spellslot[3]}[38;5;255m"
        		read -sn 1
        		tput cup 20 0
        		for i in {20..30}; do
        			tput cup $i 0
        			printf  "%s\n" "                                                                                             "
        		done
        		clear
        	fi
        	if [[ $key == [Qq] ]]; then
        		clear
        		echo "Are you sure?[Y/n]"
        		read -sn 1 wtquit
        		if [[ $wtquit == [Yy] ]]; then
        			tput cnorm; tput sgr0; clear
    				stty sane
    				stty erase ^H
    				exit 0
        			
        		fi

        	fi


            if [[ $key == [Ee] ]] && [[ $linetest == "○" ]]; then
            	aplay -q sounds/chest.wav &
            	whatchest="chest_$x$y$currentmap"
            	declare -n whatchest=chest_$x$y$currentmap
            	declare -n whatitem=item${whatchest[2]}
            	tput cup 20 0
				printf "%s\n" "[38;5;255mYou found ${whatitem[2]}"
				sleep 1
            	case ${whatchest[1]} in
            		2)
						type="Type: Sword"
						descr="Damage: ${whatitem[3]}, crit hit chance: ${whatitem[4]}%"
						currentitem="Replace current sword (${swordslot[3]} + ${swordslot[4]}%)[Y/n]?"
						declare -n whatslot=swordslot
						;;
					3)
						type="Type: Weapon Skill"
						descr="Damage modifier: +${whatitem[3]}, crit hit chance modifier: +${whatitem[4]}%"
						currentitem="Replace current attack skill (+${attackskillslot[3]} / +${attackskillslot[4]}%)[Y/n]?"
						declare -n whatslot=attackskillslot
						;;
					4)
						type="Type: Shield"
						descr="Block Amount ${whatitem[3]}, Error Chance: ${whatitem[4]}%"
						currentitem="Replace current shield (${shieldslot[3]} + ${shieldslot[4]}%)[Y/n]?"
						declare -n whatslot=shieldslot
						;;
					5)
						type="Type: Defense Skill"
						descr="Block Amount modifier: +${whatitem[3]}, Error Chance modifier: ${whatitem[4]}"
						currentitem="Replace current defense skill (+${defenseskillslot[3]} / +${defenseskillslot[4]}%)[Y/n]?"
						declare -n whatslot=defenseskillslot
						;;
					6)
						type="Type: Spell"
						descr=${whatitem[3]}
						currentitem="Replace current spell (${spellslot[3]})[Y/n]?"
						declare -n whatslot=spellslot
						;;
					*)
						type=""
						descr=""
						;;
				esac

            	tput cup 21 0
            	printf "%s\n" "$type"
            	printf "%s\n" "$descr"
            	#if [[ ${!whatslot} -ne "" ]]; then
            		printf "%s\n" "$currentitem"
            		sleep 1
            		read -sn 1 yesorno
            		if [[ $yesorno =~ [Yy] ]]; then
            			aplay -q sounds/equip.wav &
            			temp=${whatslot[0]}   #
            			whatslot=("${whatitem[@]}")
            			whatchest[2]=$temp
            			
            			
            			#echo ${shieldslot[*]}
            			#echo ${shieldslot[4]}
            			#echo ${chest_441732[*]}
            			
            		

            		fi


            	#else
            	#	read -n 1 -s -r
            	#fi
            fi

            if [[ $key == [Hh] ]]; then #○
            	linetest=$(sed "$((y+1))q;d" maps/map$currentmap.txt)
            	linetest=$(echo ${linetest:$x:1} )
            	if [[ $linetest == "○" ]]; then
            		playerlife=$(($playerlife+10))
            	fi
            	if [[ $playerlife -gt 100 ]]; then
            		playerlife=100
            	fi
           	fi

            if [[ $key == [Ff] ]]; then
            	declare -n whatenem=mapenem$currentmap
				for i in $(seq 1 ${whatenem} ); do
					declare -n enemychecker=enem_$i$currentmap
					if [[ ${enemychecker[3]} -eq $x ]] && [[ ${enemychecker[4]} -eq $y ]] && [[ ${enemychecker[0]} -ne 0 ]]; then
						definpt1=${enemychecker[9]}
						definpt2=${enemychecker[10]}
						attinpt1=$playerattack
						attinpt2=$playercrit
						damagecalc
						tput cup 20 0
            			printf "%s\n" "You attacked an enemy!"
            			if [[ $errorcheck -eq 1 ]]; then
            				printf "%s\n" "Their Block missed!"
            			fi
            			if [[ ${spellslot[0]} -eq 43 ]]; then
            				damagetaken=$(($damagetaken+10))
            			fi
            			if [[ $crithit -ne 0 ]]; then
            				printf "%s\n" "Critical Hit! They took $damagetaken damage."
            			else
            				printf "%s\n" "They took $damagetaken damage."
            			fi
            			if [[ $damagetaken -ne 0 ]]; then
            				aplay -q sounds/enempain.wav &
            			else
            				aplay -q sounds/hit.wav &
            			fi
            			enemychecker[11]=$((${enemychecker[11]}-$damagetaken))
            			if [[ ${enemychecker[11]} -le 0 ]]; then
            				aplay -q sounds/enemdeath.wav &
            				printf "%s\n" "The enemy died!"
            				canblock=0
            				enemychecker[0]=0
            				if [[ "${enemychecker[2]}" == "[38;5;001mž" ]]; then
            					read -sn 1
            					clear
            					echo "[38;5;255mYou Won! Thanks for playing!"
            					aplay -q sounds/win.wav &
       						 	read -sn 1
       						 	tput cnorm; tput sgr0; clear
       		 					stty sane
       						 	stty erase ^H
       						 	exit 0
       						 fi

            			else
            				printf "%s\n" "Enemy now has ${enemychecker[11]} life."
            			fi
            			read -sn 1

					 	
					fi 
				done
            fi

            if [[ x -gt 54 ]] && [[ $(($currentmap%10)) -lt 3 ]]; then
            	let "currentmap+=1"
            	declare -n whatenem=mapenem$currentmap
				for i in $(seq 1 ${whatenem} ); do
					declare -n enemychecker=enem_$i$currentmap
					enemychecker[3]=${enemychecker[5]}
					enemychecker[4]=${enemychecker[6]}
					enemychecker[11]=${enemychecker[12]}
					enemychecker[0]=1
					canblock=0
	
				done

            	x="0"
            elif [[ x -gt 54 ]] && [[ $(($currentmap%10)) -ge 3 ]]; then
            	x=$oldx
            else
            	:
            fi
            if [[ x -lt 0 ]] && [[ $(($currentmap%10)) -gt 1 ]]; then
            	let "currentmap-=1"
            	x="54"
            	declare -n whatenem=mapenem$currentmap
				for i in $(seq 1 ${whatenem} ); do
					declare -n enemychecker=enem_$i$currentmap
					enemychecker[3]=${enemychecker[5]}
					enemychecker[4]=${enemychecker[6]}
					enemychecker[11]=${enemychecker[12]}
					enemychecker[0]=1
					canblock=0
	
				done

            elif [[ x -lt 0 ]] && [[ $(($currentmap%10)) -le 1 ]]; then
            	x=$oldx
            else
            	:
            fi
            if [[ y -gt 19 ]] && [[ $currentmap -lt 30 ]]; then
            	let "currentmap+=10"
            	y="0"
            	declare -n whatenem=mapenem$currentmap
				for i in $(seq 1 ${whatenem} ); do
					declare -n enemychecker=enem_$i$currentmap
					enemychecker[3]=${enemychecker[5]}
					enemychecker[4]=${enemychecker[6]}
					enemychecker[11]=${enemychecker[12]}
					enemychecker[0]=1
					canblock=0
	
				done
            elif [[ y -gt 19 ]] && [[ $currentmap -gt 30 ]]; then
            	y=$oldy
            else
            	:
            fi
            if [[ y -lt 0 ]] && [[ $currentmap -lt 20 ]]; then
            	y=$oldy
            	
            elif [[ y -lt 0 ]] && [[ $currentmap -gt 20 ]]; then
            	let "currentmap-=10"
            	y="19"
            	declare -n whatenem=mapenem$currentmap
				for i in $(seq 1 ${whatenem} ); do
					declare -n enemychecker=enem_$i$currentmap
					enemychecker[3]=${enemychecker[5]}
					enemychecker[4]=${enemychecker[6]}
					enemychecker[11]=${enemychecker[12]}
					enemychecker[0]=1
					canblock=0
	
				done
            else
            	:
            fi

            linetest=$(sed "$((y+1))q;d" maps/map$currentmap.txt)
            linetest=$(echo ${linetest:$x:1} )
            
            if [[ "$nomovement" =~ .*"$linetest".* ]]; then
            	x=$oldx
            	y=$oldy
            fi
            movelimitfinal="$(date -u +%s.%N)"


            declare -n whatenem=mapenem$currentmap
			for i in $(seq 1 ${whatenem} ); do

				declare -n enemychecker=enem_$i$currentmap
				oldenx=${enemychecker[3]}
				oldeny=${enemychecker[4]}
				closex=$(($x-${enemychecker[3]}))
				closey=$(($y-${enemychecker[4]}))
				if [[ $closex -lt 6 ]] && [[ $closex -gt 0 ]] && [[ $closey -lt 4 ]] && [[ $closey -gt -4 ]]; then
					enemychecker[3]=$((${enemychecker[3]}+1))
				fi
				if [[ $closex -gt -6 ]] && [[ $closex -lt 0 ]] && [[ $closey -lt 4 ]] && [[ $closey -gt -4 ]]; then
					enemychecker[3]=$((${enemychecker[3]}-1))
				fi

				if [[ $closey -lt 4 ]] && [[ $closey -gt 0 ]] && [[ $closex -gt -6 ]] && [[ $closex -lt 6 ]]; then
					enemychecker[4]=$((${enemychecker[4]}+1))
				fi
				if [[ $closey -gt -4 ]] && [[ $closey -lt 0 ]] && [[ $closex -gt -6 ]] && [[ $closex -lt 6 ]]; then
					enemychecker[4]=$((${enemychecker[4]}-1))
				fi
			

				linetesten=$(sed "$((${enemychecker[4]}+1))q;d" maps/map$currentmap.txt)
				linetemp=${enemychecker[3]}
            	linetesten=$(echo ${linetesten:$linetemp:1} )
            	if [[ "$nomovement" =~ .*"$linetesten".* ]]; then
            		enemychecker[3]=$oldenx
            		enemychecker[4]=$oldeny
            	fi

            	

       		done

       		 

       		((playerdefense=${shieldslot[3]}+${defenseskillslot[3]}))
       		if [[ ${spellslot[0]} -eq 42 ]]; then
            	((playerblocking=${shieldslot[4]}+${defenseskillslot[4]}-15))
            else
				((playerblocking=${shieldslot[4]}+${defenseskillslot[4]}))
			fi
			if [[ ${spellslot[0]} -eq 41 ]]; then
            	((playerattack=${swordslot[3]}+${attackskillslot[3]}+25))
            else
				((playerattack=${swordslot[3]}+${attackskillslot[3]}))
			fi
			((playercrit=${swordslot[4]}+${attackskillslot[4]}))

			if [[ $playerblocking -lt 0 ]]; then
				playerblocking=0
			fi

            buffer=$(
            clear
            tput cup 0 0
            for i in {1..21}; do
            	lines=$(sed "${i}q;d" maps/map$currentmap.ans)
				printf "$lines\n"
				
			done
			tput cup $y $x
			printf "%s" "$player"
			
			#tput cup 25 5

			#whatenem="mapenem$currentmap"
			declare -n whatenem=mapenem$currentmap
			for i in $(seq 1 ${whatenem} ); do
				declare -n enemychecker=enem_$i$currentmap

				if [[ ${enemychecker[0]} -ne 0 ]]; then
					tput cup ${enemychecker[4]} ${enemychecker[3]}
					printf "%s" ${enemychecker[2]}

				fi
			done

			for i in {0..19}; do
				if [[ $i -eq 0 ]] || [[ $(($i % 2)) -eq 0 ]]; then
					tput cup $i 56
					printf "[38;5;059m+------------------------------+"
				else
					tput cup $i 56
					printf "|                              |"
				fi
			done

			playerlife=$playerlife			
			tput cup 1 57
			printf "[38;5;255mLife: [38;5;001m${playerlife}%%"
			tput cup 3 57
			printf "[38;5;255mDefense: [38;5;021m$playerdefense + $playerblocking%% "
			tput cup 5 57
			printf "[38;5;255mAttack: [38;5;124m$playerattack + $playercrit%% [38;5;255m"
			tput cup 7 57
			printf "[38;5;255mSpell: [38;5;190m${spellslot[2]}[38;5;255m"
			tput cup 9 57
			printf "[38;5;255mWASD: Movement[38;5;255m"
			tput cup 11 57
			printf "[38;5;255mE: Interact[38;5;255m"
			tput cup 13 57
			printf "[38;5;255mF: Fight![38;5;255m"
			tput cup 15 57
			printf "[38;5;255mH: Heal[38;5;255m"
			tput cup 17 57
			printf "[38;5;255mI: Inventory[38;5;255m"
			tput cup 19 57
			printf "[38;5;255mQ: Quit[38;5;255m"
			tput cup 25 0
			)

			printf "%s" "$buffer"
			declare -n whatenem=mapenem$currentmap
			for i in $(seq 1 ${whatenem} ); do

				declare -n enemychecker=enem_$i$currentmap
				if [[ $x -eq ${enemychecker[3]} ]] && [[ $y -eq ${enemychecker[4]} ]] && [[ ${enemychecker[0]} -ne 0 ]]; then
            		definpt1=$playerdefense
            		definpt2=$playerblocking
            		attinpt1=${enemychecker[7]}
            		attinpt2=${enemychecker[8]}
            		damagecalc
            		tput cup 20 0
            		printf "%s\n" "[38;5;255mYou were attacked!"
            		if [[ $errorcheck -eq 1 ]]; then
            			printf "%s\n" "Your Block missed!"
            		fi
            		if [[ $crithit -ne 0 ]] && [[ $canblock -eq 1 ]]; then
            			printf "%s\n" "Critical Hit! You took $damagetaken damage."
            		elif [[ $crithit -ne 0 ]] && [[ $canblock -eq 0 ]] && [[ ${spellslot[0]} -eq 44 ]]; then
            			printf "%s\n" "Critical Hit! Your spell blocks it!"
            			damagetaken=0
            			canblock=1
            		else
            			printf "%s\n" "You took $damagetaken damage."
            		fi
            		
            		
            		
            		if [[ $damagetaken -ne 0 ]]; then
            			aplay -q sounds/youpain.wav &
            		else
            			aplay -q sounds/hit.wav &
           			fi
            		playerlife=$(($playerlife-$damagetaken))
            		if [[ $playerlife -lt 0 ]]; then
            			playerlife=0
            		fi
            		tput cup 1 57
					printf "[38;5;255mLife: [38;5;001m$playerlife​%% "
					sleep 1
            		read -sn 1
            		tput cup 20 0
					printf "%s\n" "                                                      "
					printf "%s\n" "                                                      "
					printf "%s\n" "                                                      "
					printf "%s\n" "                                                      "


#-----------------------------------------------------------------------------------------

            	fi


			done
			#printf "%s" "$buffer"

			if [[ $playerlife -le 0 ]]; then
       		 	clear
       		 	echo "[38;5;124mYou Died.[38;5;255m"
       		 	aplay -q sounds/gameover.wav &
       		 	read -sn 1
       		 	tput cnorm; tput sgr0; clear
       		 	stty sane
       		 	stty erase ^H
       		 	exit 0
       		fi

            

        fi
    perl -MPOSIX -e 'tcflush 0,0'


	

    #sleep 5
done




