FROM runpod/worker-v1-vllm:v2.14.0

# Upgrade vLLM for Gemma 4 support
RUN python3 -m pip install --no-cache-dir \
    "vllm[flashinfer]>=0.19.1" --extra-index-url https://download.pytorch.org/whl/cu129
RUN python3 -c "import transformers; print(f'transformers={transformers.__version__}')"

# Override defaults for Gemma 4 31B AWQ
ENV HF_HUB_ENABLE_HF_TRANSFER=1

RUN apt-get update && apt-get --no-install-recommends -y install curl zsh \
    && rm -rf /var/lib/apt/lists/*

COPY src /src
RUN chmod +x /src/start.sh

CMD ["/src/start.sh"]
