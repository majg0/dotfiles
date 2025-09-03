if ! ssh-add -l >/dev/null 2>&1; then
    if [ -S "$SSH_AUTH_SOCK" ]; then
        rm -f "$SSH_AUTH_SOCK"
    fi
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519
fi
