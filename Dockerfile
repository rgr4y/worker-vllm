FROM runpod/worker-v1-vllm:v2.14.0

# Upgrade vLLM for Gemma 4 support
RUN python3 -m pip install --no-cache-dir \
    "vllm[flashinfer]==0.19.0" --extra-index-url https://download.pytorch.org/whl/cu129 && \
    python3 -m pip install --no-cache-dir "transformers>=4.57.0"

# Override defaults for Gemma 4 31B AWQ
ENV HF_HUB_ENABLE_HF_TRANSFER=1

# Start the handler
CMD ["python3", "/src/handler.py"]