#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
pactl load-module module-loopback source="alsa_input.usb-TC-Helicon_GoXLRMini-00.HiFi__goxlr_stereo_in_GoXLRMini_0_0_1__source" sink="alsa_output.usb-ASUS_ROG_Strix_Fusion_Wireless-00.iec958-stereo"

pactl set-default-sink alsa_output.usb-TC-Helicon_GoXLRMini-00.HiFi__goxlr_stereo_out_GoXLRMini_0_0_1__sink

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi                                                                                                                                      
