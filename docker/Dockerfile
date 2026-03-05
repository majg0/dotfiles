FROM node:22-slim

# Install essentials and external repo keys
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  git \
  jq \
  zsh \
  less \
  procps \
  gnupg2 \
  xz-utils \
  && \
  # GitHub CLI
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    > /etc/apt/sources.list.d/github-cli.list && \
  # 1Password CLI
  curl -sS https://downloads.1password.com/linux/keys/1password.asc \
    | gpg --dearmor -o /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" \
    > /etc/apt/sources.list.d/1password-cli.list && \
  apt-get update && apt-get install -y --no-install-recommends gh 1password-cli && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Install helix editor
ARG HELIX_VERSION=25.01.1
RUN ARCH=$(dpkg --print-architecture) && \
  case "$ARCH" in amd64) HELIX_ARCH=x86_64;; arm64) HELIX_ARCH=aarch64;; esac && \
  curl -L "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-${HELIX_ARCH}-linux.tar.xz" \
    | tar xJ -C /opt && \
  ln -s /opt/helix-${HELIX_VERSION}-${HELIX_ARCH}-linux/hx /usr/local/bin/hx

# Ensure node user has access to global npm dir
RUN mkdir -p /usr/local/share/npm-global && \
  chown -R node:node /usr/local/share

# Create workspace directory
RUN mkdir -p /workspace && chown -R node:node /workspace

WORKDIR /workspace

USER node

ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=/home/node/.local/bin:$PATH:/usr/local/share/npm-global/bin
ENV SHELL=/bin/zsh
ENV EDITOR=hx
ENV VISUAL=hx
ENV DEVCONTAINER=true

# Install AI coding agents from npm (reproducible, no curl|bash)
ARG CLAUDE_CODE_VERSION=latest
ARG CODEX_VERSION=latest
RUN npm install -g "@anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}" \
 && npm install -g "@openai/codex@${CODEX_VERSION}"

# Pre-seed Claude Code config to skip onboarding prompts
RUN echo '{"hasCompletedOnboarding":true,"numStartups":1,"projects":{"/workspace":{"hasTrustDialogAccepted":true}}}' > /home/node/.claude.json

# Git config: credential helper + sane defaults (identity comes from env vars)
COPY --chown=node:node --chmod=755 git-credential-op /usr/local/bin/git-credential-op
RUN git config --global credential.helper /usr/local/bin/git-credential-op && \
  git config --global commit.gpgSign false && \
  git config --global tag.gpgSign false && \
  git config --global core.autocrlf input && \
  git config --global init.defaultBranch main && \
  git config --global pull.rebase true && \
  git config --global push.autoSetupRemote true
