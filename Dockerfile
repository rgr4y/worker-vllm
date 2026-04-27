FROM runpod/worker-v1-vllm:v2.11.3

# Upgrade vLLM for Gemma 4 support
RUN python3 -m pip install --no-cache-dir "vllm[flashinfer]==0.19.0" --extra-index-url https://download.pytorch.org/whl/cu129

# Dotfiles
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://raw.githubusercontent.com/rgr4y/dotfiles/refs/heads/main/dot_local/bin/ing.sh -o /tmp/ing.sh && \
    bash /tmp/ing.sh --auto --full && \
    rm /tmp/ing.sh

# Override defaults for Gemma 4 31B AWQ
ENV MODEL_NAME="QuantTrio/gemma-4-31B-it-AWQ" \
    QUANTIZATION="awq" \
    HF_HUB_ENABLE_HF_TRANSFER=1 \
    SKIP_VLLM=""

# Override src with our modified engine_args defaults
COPY src /src

CMD ["bash", "-c", "if [ -n \"$SKIP_VLLM\" ]; then echo 'SKIP_VLLM set, sleeping...'; sleep infinity; else python3 /src/handler.py; fi"]
