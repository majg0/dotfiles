target="$XDG_CONFIG_HOME/zig_bin"
rm -rf "$target"

version="$(curl 'https://ziglang.org/download/index.json' | jq -r '.master.version')"
arch=$(uname -m)
os='linux'
if [ $(uname) = 'Darwin' ]; then
  os='macos'
fi
name="zig-$os-$arch-$version"
tarball="$name.tar.xz"
curl "https://ziglang.org/builds/$tarball" > "$tarball"
tar -xf "$tarball"
rm -rf "$tarball"
mv "$name" "$target"

# TODO: verify with minisign

echo "WARNING: zig + zls may be incompatible"
curl "https://zigtools-releases.nyc3.digitaloceanspaces.com/zls/master/${arch}-${os}/zls" > zls
chmod +x zls
mv zls "$target/"
