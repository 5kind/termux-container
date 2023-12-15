basename=${0##*/}
WantedBy=${basename%.sh}
LOGFILE=/cache/$MODID.log

mv "$LOGFILE" "$LOGFILE".bak

for service in $MODDIR/$WantedBy.d/*.sh ;do
    printf "* Starting service ${service##*/} ...\t"
    . "$service" &&
    printf "%s" "[  OK  ]" ||
    printf "%s" "[FAILED]"
    printf "\n"
done > "$LOGFILE" 2>&1
