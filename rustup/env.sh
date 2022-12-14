export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"

# NOTE: ensures the file exists
mkdir -p "$CARGO_HOME"
touch "$CARGO_HOME/env"

# NOTE: adds binaries to path only if not already included
source "$CARGO_HOME/env"
