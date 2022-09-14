KITTY_PATH="$XDG_CONFIG_HOME/kitty"

mkdir -p $KITTY_PATH

ln -sf "$DOTFILES/kitty/kitty.conf" "$KITTY_PATH/kitty.conf"

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
