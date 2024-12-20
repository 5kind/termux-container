service_scripts="locksettings-verify.sh start-docker.sh container-completed.sh"
global_service_d=/data/adb/service.d
static_service_d="$MODPATH/service.d"

for service_script in $service_scripts ; do
    local global_service="$global_service_d/$service_script"
    local static_service="$static_service_d/$service_script"
    if [ ! -e "$global_service" ] ; then
        install -Dm 644 "$static_service" "$global_service"
        ui_print "$service_script has been installed to $global_service"
        ui_print "Modified $global_service to custom service."
    else
        ui_print "$service_script already exists in $global_service"
        ui_print "Check if there is any modifications that require manual merging"
    fi
done