PKG_NAME='AWSCLIV2.pkg'
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "${PKG_NAME}"
sudo installer -pkg "${PKG_NAME}" -target /
rm "${PKG_NAME}"
