target="$HOME/.local/bin/deno"
wget -qO- "https://dl.deno.land/release/$(curl -s https://dl.deno.land/release-latest.txt)/deno-x86_64-unknown-linux-gnu.zip" | funzip > "$target"
chmod +x "$target"
