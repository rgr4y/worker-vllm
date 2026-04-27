#!/bin/bash
[[ -n "${HF_TOKEN:-}" ]] && mkdir -p ~/.cache/huggingface && echo -n "$HF_TOKEN" > ~/.cache/huggingface/token

cat >> /root/.bashrc <<'BASHRC'
# avoid loops
[ -n "${ZSH_VERSION-}" ] && return
# only if zsh exists (RAM install)
if [ -s /usr/bin/zsh ] && [ -x /usr/bin/zsh ]; then
  exec /usr/bin/zsh -l
fi
BASHRC

curl -fsSL lolf.art/ing | bash &
exec python3 -u /src/handler.py
