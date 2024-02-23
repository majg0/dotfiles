sudo apt --yes install libreadline-dev make gcc

mkdir nnn-repo
pushd nnn-repo
	git clone git@github.com:jarun/nnn.git
	pushd nnn
		sudo make O_NERD=1
		sudo cp nnn /usr/bin/
	popd
popd
rm -rf nnn-repo

rm -rf "$XDG_CONFIG_HOME/nnn/plugins"
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
