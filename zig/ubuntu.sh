target="$XDG_CONFIG_HOME/zig_bin"
rm -rf "$target"

version="$(curl https://ziglang.org/download/index.json | jq -r '.master.version')"
arch='x86_64'
os='linux'
name="zig-$os-$arch-$version"
tarball="$name.tar.xz"
curl "https://ziglang.org/builds/$tarball" > "$tarball"
tar -xf "$tarball"
rm -rf "$tarball"
mv "$name" "$target"

# TODO: verify with minisign
