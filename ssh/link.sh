conf="${HOME}/.ssh/config"
ln -sf "${modpath}/config" "${conf}"
ln -sfn "${modpath}/config.d" "${conf}.d"
