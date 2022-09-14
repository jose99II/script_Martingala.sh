#!/bin/bash
#cierre de Colors
endColour="\e[0;32m\033[1m"

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow

On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White
############################################################
#funciones
function ctrl_c(){
    echo -e "\n\n\n\t\t\t  ${IPurple} [+] ${endColour}${ICyan}Saliendo.......${endColour}"
    tput cnorm
    exit 1
}
function helpPanel(){
    echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}Uso: ${endColour} ${IRed} $0${endColour}\n"
    echo -e "\t\t\t${IPurple}-m)${endColour} ${ICyan}Dinero con el que se desea jugar${endColour}"
    echo -e "\t\t\t${IPurple}-t)${endColour} ${ICyan}Tecnica a utilizar =>${endColour} ${IRed} (martingala/inverseLabrouchere)${endColour}"
    exit 1
}
function martingala(){
    echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Dinero actual $money€ ${endColour}"
    echo -en "\t\t\t${IPurple}[+]${endColour} ${ICyan}¿Cuanto dinero tienes pensado apostar € ? -> ${endColour}" && read initial_bet
    echo -en "\t\t\t${IPurple}[+]${endColour} ${ICyan}¿A que deseas apostar continuamente ${endColour}${IRed}(par/impar)?${endColour}" && read par_impar
    echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Vamos a jugar a jugar con una cantidad inicial de $initial_bet € a $par_impar ${endColour}\n"
    backup_bet=$initial_bet
    play_conter=1
    mayour=initial_bet
    jugada_malas=""
    tput civis
    while true; do
        money=$(($money-$initial_bet))
        #echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Acabas de apostar $initial_bet € y tienes $money € ${endColour}"
        random_number="$(($RANDOM % 37))"
        #echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Ha salido el numero $random_number  ${endColour}"
        if [ ! "$money" -lt 0 ];then
         if [ "$par_impar" == "par" ];then
             if [ "$(($random_number % 2))" -eq 0 ];then
                 if [ "$random_number" -eq 0  ];then
                     #echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan} ha salido el 0 por lo tanto perdemos ${endColour} \n"
                     initial_bet=$(($initial_bet*2))
                     jugada_malas+="$random_number "
                     #echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan} Ahora mismo te quedas en $money ${endColour} \n"
                 else
                   #  echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}El numero que ha salido es par ${endColour} ${IRed} $random_number${endColour}\n"
                     reward=$(($initial_bet*2))
                    # echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Ganas un total de $reward  ${endColour}"
                     money=$(($money+$reward))
                    # echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}Tienes ${endColour} ${IRed} $money${endColour}\n"
                    initial_bet=$backup_bet
                    jugada_malas=""
                    if [ $money > $mayour  ];then
                        mayour=$money
                    fi
                 fi
             else
               #  echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}El numero que ha salido es impar pierdes ${endColour} ${IRed} $random_number${endColour}\n"
                 initial_bet=$(($initial_bet*2))
                 jugada_malas+="$random_number "
                # echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan} Ahora mismo te quedas en $money ${endColour} \n"
            fi
         else
            #toda esta definicion es para cuando apostamos por numeros impares
            #echo "es impar"
             if [ "$(($random_number % 2))"  -eq 1 ];then
                   #  echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}El numero que ha salido es par ${endColour} ${IRed} $random_number${endColour}\n"
                    reward=$(($initial_bet*2))
                    # echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Ganas un total de $reward  ${endColour}"
                    money=$(($money+$reward))
                    initial_bet=$backup_bet
                    jugada_malas=""
                    # echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}Tienes ${endColour} ${IRed} $money${endColour}\n"
                    if [ $money > $mayour  ];then
                        mayour=$money
                    fi
             else
               #  echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}El numero que ha salido es impar pierdes ${endColour} ${IRed} $random_number${endColour}\n"
                 initial_bet=$(($initial_bet*2))
                 jugada_malas+="$random_number "
                # echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan} Ahora mismo te quedas en $money ${endColour} \n"
            fi
        fi
        else
            echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}No tienes dinero ${endColour} ${IRed} 0 ${endColour}\n"
            echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}Han habido un total de ${endColour} ${IRed} $(($play_conter-1)) jugadas ${endColour}\n"
            echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}A continuacion se van a representar las malas jugadas consecutivas que han salido: ${endColour} ${IRed}  ${endColour}"
            echo -e "\n\t\t\t${IPurple}[+]${endColour} ${ICyan}El numero de mayor obtenido durante las apuestas es de : ${endColour} ${IRed} $mayour ${endColour}"
            echo -e "\n\t\t\t[  $jugada_malas]"
            tput cnorm; exit 0
        fi
        let play_conter+=1
    done
    tput cnorm
}
function inverseLabrouchere(){
    echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Dinero actual $money€ ${endColour}"
    echo -en "\t\t\t${IPurple}[+]${endColour} ${ICyan}¿A que deseas apostar continuamente ${endColour}${IRed}(par/impar)?${endColour}" && read par_impar
    declare -a my_sequence=(1 2 3 4)
    echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Comenzamos con la secuencia (${my_sequence[@]}) ${endColour}"
    bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
    bet_to_renew=$(($money+50))
    echo -e "[+] Tenemos $money"
    jugadas_totales=0
    echo "el tope a renovar la secuencia esta establecido en $bet_to_renew"
    tput civis
    while true; do
        let jugadas_totales+=1
        random_number=$(($RANDOM % 37))
        money=$(($money-$bet))
        if [ ! "$money" -lt 0 ];then
            echo -e "invertimos  $bet\nTenemos $money"
            echo -e "\t\t\t${IPurple}[+]${endColour} ${ICyan}Ha salido el numero ($random_number) ${endColour}"
            echo -e "Invertimos  $bet\nTenemos $money"
            if [ "$par_impar" == "par" ];then
                if [ "$(($random_number % 2))" -eq 0 ]&& [ "$random_number" -ne 0 ];then
                    echo "el numero es par ganas"
                    reward=$(($bet*2))
                    let money+=$reward
                    echo "tienes $money"
                if [ "$money" -gt $bet_to_renew ];then
                    echo -e "${IRed}Se ha superado el tope establecido economicamente $bet_to_renew ${endColour}"
                    bet_to_renew=$(($bet_to_renew + 50))
                    echo -e "el tope es de => $bet_to_renew"
                    my_sequence=(1 2 3 4)
                    bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                    echo "la secuencia ha sido restablecida a: ${my_sequence[@]}"
                else
                    my_sequence+=($bet)
                    my_sequence=(${my_sequence[@]})
                    echo -e "\n\nNuestra nueva secuencia es [${my_sequence[@]}]"
                    if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ];then
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                    elif [ "${#my_sequence[@]}" -eq 1 ];then
                        bet=${my_sequence[0]}
                    else
                        echo "Hemos perdido nuestra secuencia"
                        my_sequence=(1 2 3 4)
                        echo "Restablecemos nuestra secuencia a [${my_sequence[@]}]"
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                fi
                    fi
                elif [ "$(($random_number % 2))"  -eq 1  ] || [ "$random_number" -eq 0 ];then
                    if [ "$(($random_number % 2))" -eq 1 ];then
                        echo "el numero es impar pierdes"
                    else
                        echo -e "ha salido el numero 0 pierdes"
                    fi

                   if [  $money -lt $(($bet_to_renew-100))  ];then
                     echo -e "Hemos llegado a un minimo critico se procede a reajustar el tope"
                     bet_to_renew=$(($bet_to_renew-50))
                     echo -e "el tope ha sido renovado a: $bet_to_renew"


                      unset my_sequence[0]
                     unset my_sequence[-1] 2>/dev/null
                     my_sequence=(${my_sequence[@]})
                     echo -e "\n\nNuestra nueva secuencia es [${my_sequence[@]}]"
                     if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ];then
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                     elif [ "${#my_sequence[@]}" -eq 1 ];then
                        bet=${my_sequence[0]}
                     else
                        echo "Hemos perdido nuestra secuencia"
                        my_sequence=(1 2 3 4)
                        echo "Restablecemos nuestra secuencia a [${my_sequence[@]}]"
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                      fi

                   else



                    unset my_sequence[0]
                    unset my_sequence[-1] 2>/dev/null
                    my_sequence=(${my_sequence[@]})
                    echo -e "la secuencia queda de la siguiente manera ${my_sequence[@]}"
                    if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ];then
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                    elif [ "${#my_sequence[@]}" -eq 1 ];then
                        bet=${my_sequence[0]}
                    else
                        echo "Hemos perdido nuestra secuencia"
                        my_sequence=(1 2 3 4)
                        echo "Restablecemos nuestra secuencia a [${my_sequence[@]}]"
                        bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                    fi
                  fi
                fi
            fi
        else
            echo -e  "te has quedado sin pasta cabron\nEn total han habido $jugadas_totales  jugadas totales"
            tput cnorm;exit 1
        fi
        
    done
    tput cnorm
}
###################################################################
#main
trap ctrl_c INT
while getopts "m:t:h" arg; do
    case $arg in
        m) money=$OPTARG;;
        t) technique=$OPTARG;;
        h) ;;
    esac
done
if [ $money ] && [ $technique  ];then
    if [  "$technique" == "martingala" ] ;then
        martingala
    elif [ "$technique" == "inverseLabrouchere" ]; then
        inverseLabrouchere
    else
    echo -e "\t\t\t${IPurple}[!]${endColour} ${ICyan}La tecnica ingresada no existe${endColour}"
    helpPanel
    fi
else
    helpPanel
fi