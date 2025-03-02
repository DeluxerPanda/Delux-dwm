#
# ~/.bash_profile
#

 [[ -f ~/.bashrc ]] && . ~/.bashrc
#  Source="alsa_input.usb-TC-Helicon_GoXLRMini-00.HiFi__goxlr_stereo_in_GoXLRMini_0_0_1__source"
#  Sink="alsa_output.usb-ASUS_ROG_Strix_Fusion_Wireless-00.analog-stereo"
#  pactl load-module module-loopback source="$Source" sink="$Sink"


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi                                                                                                                                      
