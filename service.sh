basename=${0##*/}
WantedBy=${basename%.sh}
LOGFILE=/cache/$MODID.log

for service in $MODDIR/$WantedBy.d/*.sh ;do
    printf "* Starting service ${service##*/} ...\t"
    . "$service" &
    printf "%s" "[RUNNING]"
    printf "\n"
done >> "$LOGFILE" 2>&1
