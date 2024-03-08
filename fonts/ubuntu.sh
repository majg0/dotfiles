font=Hasklig
target="/usr/share/fonts/opentype/${font}"
if [ ! -d $target ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/${font}.zip
  unzip ${font}.zip -d ${font}
  \rm ${font}.zip
  sudo \mv ${font} ${target}
fi
