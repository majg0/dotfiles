conf="${HOME}/.ssh/config"
ln -sf "${modpath}/config" "${conf}"
ln -sfn "${modpath}/config.d" "${conf}.d"
chmod 600 ${conf} ${conf}.d
chmod 700 ${conf}.d
chmod 600 ${conf}.d/*
