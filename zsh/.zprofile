PATH="$HOME/bin/:$HOME/.local/bin/:$PATH:/usr/sbin"

if xinput list | grep 'Mionix' > /dev/null; then
    mouseid=$(xinput list --id-only 'pointer:Laview Technology Mionix Naos 7000')
    # Set mouse speed 
    xinput set-prop $mouseid 154 2.400000, 0.000000, 0.000000, 0.000000, 2.400000, 0.000000, 0.000000, 0.000000, 1.000000

    # Activate middle click scroll
    . ~/bin/middle-click-scroll $mouseid
fi

if type albert > /dev/null && ! pgrep albert >/dev/null 2>&1; then
    albert & 
fi

# Set caps lock to <CTRL>
/usr/bin/setxkbmap -option "ctrl:nocaps"
