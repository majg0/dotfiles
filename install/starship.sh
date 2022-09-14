STARSHIP_PATH=$XDG_CONFIG_HOME
mkdir -p $STARSHIP_PATH

ln -sf "$DOTFILES/starship/starship.toml" "$STARSHIP_PATH/starship.toml"
