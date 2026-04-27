FROM runpod/worker-v1-vllm:v2.14.0

# Upgrade vLLM for Gemma 4 support
RUN python3 -m pip install --no-cache-dir \
    "vllm[flashinfer]>=0.19.1" --extra-index-url https://download.pytorch.org/whl/cu129
RUN python3 -c "import transformers; print(f'transformers={transformers.__version__}')"

# Override defaults for Gemma 4 31B AWQ
ENV MODEL_NAME="QuantTrio/gemma-4-31B-it-AWQ" \
    QUANTIZATION="awq" \
    HF_HUB_ENABLE_HF_TRANSFER=1

COPY src /src

CMD ["python3", "/src/handler.py"]