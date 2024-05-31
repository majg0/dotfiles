source "$modpath/env.sh"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_INIT_SKIP_PATH_CHECK=yes sh -s -- --no-modify-path -y

$XDG_CONFIG_HOME/cargo/bin/rustup component add rust-analyzer
