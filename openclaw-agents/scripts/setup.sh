#!/usr/bin/env bash
# =============================================================================
# AlphaEta OpenClaw Agents — First-Time Setup
# =============================================================================
# Run this once after cloning the repo to set up both agents.
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=========================================="
echo "  AlphaEta OpenClaw Agents — Setup"
echo "=========================================="

# --- Check prerequisites ---
echo ""
echo "[1/5] Checking prerequisites..."

if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed. Please install Docker Desktop first."
    exit 1
fi

if ! docker info &> /dev/null 2>&1; then
    echo "ERROR: Docker daemon is not running. Please start Docker Desktop."
    exit 1
fi

echo "  ✓ Docker is available"

# --- Check .env file ---
echo ""
echo "[2/5] Checking environment configuration..."

if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "  Creating .env from template..."
    cp "$PROJECT_DIR/.env.example" "$PROJECT_DIR/.env"
    echo ""
    echo "  ⚠  IMPORTANT: Edit .env with your actual values before continuing!"
    echo "     Required:"
    echo "       - ANTHROPIC_API_KEY"
    echo "       - OPENAI_API_KEY"
    echo "       - OPENCLAW_GATEWAY_TOKEN (generate with: openssl rand -hex 32)"
    echo "       - JOSH_TELEGRAM_BOT_TOKEN (from @BotFather)"
    echo "       - AUDREY_TELEGRAM_BOT_TOKEN (from @BotFather)"
    echo ""
    echo "     After editing .env, run this script again."
    exit 0
fi

# Source .env
set -a
source "$PROJECT_DIR/.env"
set +a

echo "  ✓ .env loaded"

# --- Check Ollama connectivity ---
echo ""
echo "[3/5] Checking Ollama connectivity at ${OLLAMA_HOST:-10.0.0.181}:${OLLAMA_PORT:-11434}..."

OLLAMA_URL="http://${OLLAMA_HOST:-10.0.0.181}:${OLLAMA_PORT:-11434}/api/tags"
if curl -s --connect-timeout 5 "$OLLAMA_URL" > /dev/null 2>&1; then
    echo "  ✓ Ollama is reachable"
    echo "  Available models:"
    curl -s "$OLLAMA_URL" | python3 -c "
import json, sys
data = json.load(sys.stdin)
for m in data.get('models', []):
    print(f\"    - {m['name']} ({m.get('size', 'unknown size')})\")" 2>/dev/null || echo "    (could not parse model list)"
else
    echo "  ⚠  WARNING: Cannot reach Ollama at $OLLAMA_URL"
    echo "     Agents will fall back to cloud APIs until Ollama is available."
fi

# --- Pull Docker image ---
echo ""
echo "[4/5] Pulling OpenClaw Docker image..."
docker pull ghcr.io/openclaw/openclaw:latest

echo "  ✓ Image pulled"

# --- Onboard agents ---
echo ""
echo "[5/5] Running onboard for each agent..."

echo ""
echo "  --- Onboarding Josh ---"
cd "$PROJECT_DIR/agents/josh"
docker compose --env-file "$PROJECT_DIR/.env" run --rm josh-cli onboard || {
    echo "  ⚠  Josh onboarding had issues. You may need to run it manually."
}

echo ""
echo "  --- Onboarding Audrey ---"
cd "$PROJECT_DIR/agents/audrey"
docker compose --env-file "$PROJECT_DIR/.env" run --rm audrey-cli onboard || {
    echo "  ⚠  Audrey onboarding had issues. You may need to run it manually."
}

echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "  Next steps:"
echo "    1. Start agents:  ./scripts/start-all.sh"
echo "    2. Message Josh on Telegram to test research"
echo "    3. Message Audrey on Telegram to set up habits"
echo ""
echo "  Useful commands:"
echo "    ./scripts/start-all.sh   — Start both agents"
echo "    ./scripts/stop-all.sh    — Stop both agents"
echo "    docker compose logs -f   — View logs (run from agent dir)"
echo ""
