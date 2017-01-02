#!/usr/bin/bash

. lemonpanel.config

desk_pad=" "

while read -r line; do
	wrkspc_info="%{T1}%{A4:bspc desktop -f prev:}%{A5:bspc desktop -f next:}"
	case $line in
		W*)
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ]; do
				item="$1"
				name="${item#?}"
                name="%{A:bspc desktop -f $name:} ${desk_pad}${name}${desk_pad} %{A}"
				case $item in
					O*)
						# focused occupied desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_L%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					F*)
						# focused free desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_L%{F-}%{B-}"
						wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					U*)
						# focused urgent desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_L%{F-}%{B-}"
						wrkspc_info="$wrkspc_info%{B$FOCUSSD_BG}%{F$FOCUSSD_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
						;;
					o*)
						# occupied desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						;;
					f*)
						# free desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						;;
					u*)
						# urgent desktop
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$WRKSPC_FG}${name}%{F-}%{B-}"
                        wrkspc_info="$wrkspc_info%{B$WRKSPC_BG}%{F$FOCUSSD_BG}  %{F-}%{B-}"
						;;
				esac
				shift
			done
	esac
    last_desk=$(echo $line | awk -F':' ' { print $1 } ' | awk ' { print $11 }')
    if [[ "${last_desk:0:1}" == [OFU] ]]; then
        wrkspc_info=${wrkspc_info::-37}
        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$FOCUSSD_BG}$SEP_R%{F-}%{B-}"
    else
        wrkspc_info=${wrkspc_info::-38}
        wrkspc_info="$wrkspc_info%{B$BAR_BG}%{F$WRKSPC_BG}$SEP_R%{F-}%{B-}"
    fi
    wrkspc_info="$wrkspc_info%{A}%{A}%{T-}"
    echo "$wrkspc_info"
done < <(bspc subscribe report)
