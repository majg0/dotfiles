version=14.1.0
pkg=ripgrep_${version}-1_amd64.deb

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${version}/${pkg}
sudo dpkg -i ${pkg}
rm ${pkg}
