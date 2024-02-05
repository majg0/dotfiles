INSTALL_FILE=install-starship-sh
curl -sS https://starship.rs/install.sh > $INSTALL_FILE
chmod +x $INSTALL_FILE
./$INSTALL_FILE -y
rm $INSTALL_FILE
