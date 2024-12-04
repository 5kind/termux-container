service_scripts="locksettings-verify.sh"
global_service_d=/data/adb/service.d
static_service_d="$MODPATH/service.d"

for service_script in "$service_scripts" ; do
    local global_service="$global_service_d/$service_script"
    local static_service="$static_service_d/$service_script"
    if [ ! -e "$global_service" ] ; then
        install -Dm 644 "$static_service" "$global_service"
    fi
done