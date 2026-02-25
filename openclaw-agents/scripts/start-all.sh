#!/usr/bin/env bash
# =============================================================================
# Start all AlphaEta OpenClaw agents
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "ERROR: .env not found. Run ./scripts/setup.sh first."
    exit 1
fi

echo "Starting AlphaEta agents..."

echo ""
echo "  Starting Josh (Research Agent)..."
cd "$PROJECT_DIR/agents/josh"
docker compose --env-file "$ENV_FILE" up -d josh-gateway
echo "  ✓ Josh is running on port ${JOSH_GATEWAY_PORT:-18789}"

echo ""
echo "  Starting Audrey (Schedule & Habits)..."
cd "$PROJECT_DIR/agents/audrey"
docker compose --env-file "$ENV_FILE" up -d audrey-gateway
echo "  ✓ Audrey is running on port ${AUDREY_GATEWAY_PORT:-18791}"

echo ""
echo "All agents started. Check status with: docker ps --filter 'label=com.alphaeta.agent'"
