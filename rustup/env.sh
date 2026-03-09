export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"

mkdir -p "$CARGO_HOME"
touch "$CARGO_HOME/env"

source "$CARGO_HOME/env"