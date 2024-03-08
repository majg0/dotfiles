sudo apt --yes install i3 pulseaudio-utils
sudo update-alternatives --install /usr/bin/x-session-manager x-session-manager $(which i3) 60
if [ $XDG_CURRENT_DESKTOP != i3 ]; then
  notify "${light_cyan}Log back in to use i3!${default}"
fi
