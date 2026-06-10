FROM python:3.12-slim

RUN pip install --no-cache-dir "aegis-governance[mcp]"

# Sandbox mode works with no API key (10 evaluations/day).
# Set AEGIS_API_KEY for the full authenticated surface.
ENTRYPOINT ["aegis-mcp-server"]
