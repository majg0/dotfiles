# Add the key for the 1Password `apt` repository:

wget --output-document - https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --batch --yes --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Add the 1Password `apt` repository:

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
  sudo tee /etc/apt/sources.list.d/1password.list

# Add the debsig-verify policy:

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
wget --output-document - https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
wget --output-document - https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --batch --yes --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Install 1Password CLI:

sudo apt update
sudo apt --yes install 1password
sudo apt --yes install 1password-cli

chmod 700 "$XDG_CONFIG_HOME/op"

# NOTE: create default plugins file so it exists on initial shell startup
if [ ! -f "$XDG_CONFIG_HOME/op/plugins.sh" ]; then
	notify 'Please immediately perform:'
	notify '1. Open 1Password'
	notify "2. Navigate through ${light_yellow}⋮${default} > ${light_yellow}Settings...${default} > ${light_yellow}Developer${default}"
	notify "3. Click ${light_yellow}Set Up SSH Agent...${default}"
	notify "4. Do not copy or edit. Click ${light_yellow}⨯${default}"
	notify "5. Uncheck ${light_yellow}Use rich approval prompt${default}"
	notify "6. Check ${light_yellow}Integrate with 1Password CLI${default}"
	notify "7. Run ${light_blue}op plugin init gh${default}. You won't need to configure any alias, as plugins are sourced on shell startup."
fi
