# Add the key for the 1Password `apt` repository:

curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --batch --yes --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Add the 1Password `apt` repository:

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
  sudo tee /etc/apt/sources.list.d/1password.list

# Add the debsig-verify policy:

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --batch --yes --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Install 1Password CLI:

sudo apt update
sudo apt install 1password
sudo apt install 1password-cli
