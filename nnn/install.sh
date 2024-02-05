sudo apt install libreadline-dev

git clone git@github.com:jarun/nnn.git
pushd nnn
sudo make O_NERD=1
sudo cp nnn /usr/bin/
popd
rm -rf nnn

rm -rf "$XDG_CONFIG_HOME/nnn/plugins"
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
