gentoo-pipewire-launcher &
dunst &
picom --backend xrender &

~/.fehbg

xset r rate 200 60
xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary --output HDMI-0 --right-of DP-0 --mode 1920x1080 --rate 170
xinput --set-prop 'Logitech USB Receiver' 'libinput Accel Speed' -0.75
setxkbmap us -option caps:swapescape

eval "$(ssh-agent -s)"

exec dbus-launch --exit-with-session i3
