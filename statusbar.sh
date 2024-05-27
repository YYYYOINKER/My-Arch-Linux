while true; do
    
    BRIGHTNESS_STATUS=$(light -s sysfs/backlight/intel_backlight -G | awk '{print int($1)}')

    # Read CPU Temperature devide by 1000
    TEMP_C=$(( $(cat /sys/class/thermal/thermal_zone0/temp) /1000))

    # Determine temperature icon
    TEMP_ICON=""  # default to "thermometer half"
    if [ "$TEMP_C" -gt 70 ]; then
        TEMP_ICON=""  # "thermometer full"
    elif [ "$TEMP_C" -gt 50 ]; then
        TEMP_ICON=""  # "thermometer three-quarters"
    fi

    # Check WiFi status using nmcli which is part of NetworkManager, more reliable in this context
    WIFI_STATUS=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
    WIFI_ICON=" "  # Default to WiFi connected icon
    if [ -z "$WIFI_STATUS" ]; then
        WIFI_ICON=""  # No WiFi icon if no network is connected
    fi

    # Get volume level and status, set icon
    VOLUME_LEVEL=$(amixer get Master | grep -o "[0-9]*%" | head -1 | tr -d '%')
    VOLUME_ICON=""  # Default to "volume up"
    if [ "$(amixer get Master | grep '\[off\]')" ]; then
        VOLUME_ICON=""  # "audio-description" icon for muted
    elif [ "$VOLUME_LEVEL" -eq 0 ]; then
        VOLUME_ICON=""  # "volume off" for zero volume
    elif [ "$VOLUME_LEVEL" -le 50 ]; then
        VOLUME_ICON=""  # "volume down"
    fi

    # Battery status and icon   
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
    BATTERY_ICON="" 

    # Current date and time
    DATE_INFO=$(date +"%F %R")

    # Construct the status string
    STATUS="   | $WIFI_ICON |   $BRIGHTNESS_STATUS | $VOLUME_ICON $VOLUME_LEVEL | $TEMP_ICON $TEMP_C | $BATTERY_ICON $BATTERY_LEVEL | 📅 $DATE_INFO    "

    # Update the dwm status bar
    xsetroot -name "$STATUS"
    sleep 1
done &

