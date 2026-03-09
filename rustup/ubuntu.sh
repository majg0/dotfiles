source "$modpath/env.sh"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_INIT_SKIP_PATH_CHECK=yes sh -s -- --no-modify-path -y

"$CARGO_HOME/bin/rustup" component add rust-analyzer
"$CARGO_HOME/bin/rustup" target add wasm32-unknown-unknown