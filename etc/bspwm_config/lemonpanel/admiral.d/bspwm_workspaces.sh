#!/usr/bin/bash

. lemonpanel.config

desk_pad="  "
num_bck_chars=${#desk_pad}
bck_trc=$((36 + $num_bck_chars))
num_sep_chars=${#SEP_R}
bck_trc_sep=$((36 + $num_sep_chars))
last_desk_num=$(($NUM_DESK + 1))
read line < <(bspc subscribe report)
first_desk=$(echo $line | awk -F':' ' { print $2 } ')
first_desk=${first_desk#?}
# last_desk=$(echo $line | awk -F':' -v num="$last_desk_num" ' { print $(num) }')
# last_desk=${last_desk#?}

while read -r line; do
	wrkspc_info="%{T1}%{A4:bspc desktop -f prev:}%{A5:bspc desktop -f next:}"
	case $line in
		W*)
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ]; do
				item="$1"
				name="${item#?}"
                if [[ ${item:0:1} == [OoFfUu] ]]; then
                    if [[ $name == $first_desk && ${item:0:1} == [OFU] ]]; then
                        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$FOCUSSD_BG}$SEP_L%{F-}%{B-}"
                    elif [[ $name == $first_desk && ${item:0:1} != [OFU] ]]; then
                        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$WRKSPC_BG}$SEP_L%{F-}%{B-}"
                    elif [[ $name != $first_desk && ${item:0:1} == [OFU] ]]; then
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_L%{F-}%{B-}"
                    else
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$desk_pad%{F-}%{B-}"
                    fi
                fi
                name="%{A:bspc desktop -f $name:} ${desk_pad}${name}${desk_pad} %{A}"
				case $item in
					O*)
						# focused occupied desktop
                        wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					F*)
						# focused free desktop
						wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					U*)
						# focused urgent desktop
						wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					o*)
						# occupied desktop
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$desk_pad%{F-}%{B-}"
						;;
					f*)
						# free desktop
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$desk_pad%{F-}%{B-}"
						;;
					u*)
						# urgent desktop
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$desk_pad%{F-}%{B-}"
						;;
				esac
				shift
			done
	esac
    last_desk=$(echo $line | awk -F':' ' { print $1 } ' | awk -v num="$last_desk_num" ' { print $(num) }')
    if [[ "${last_desk:0:1}" == [OFU] ]]; then
        wrkspc_info=${wrkspc_info::-$bck_trc_sep}
        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
    else
        wrkspc_info=${wrkspc_info::-$bck_trc}
        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$WRKSPC_BG}$SEP_R%{F-}%{B-}"
    fi
    wrkspc_info="$wrkspc_info%{A}%{A}%{T-}"
    echo "$wrkspc_info"
done < <(bspc subscribe report)
