sudo apt --yes install zsh

if [ ! $(cat /etc/passwd | grep $USER | grep zsh) ]; then
        echo -e "${light_cyan}changing default login shell to zsh${default}"
	chsh -s $(which zsh)
fi
