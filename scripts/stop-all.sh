#!/usr/bin/env bash
# =============================================================================
# Stop all AlphaEta OpenClaw agents
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_DIR/.env"

echo "Stopping AlphaEta agents..."

echo "  Stopping Josh..."
cd "$PROJECT_DIR/agents/josh"
docker compose --env-file "$ENV_FILE" down 2>/dev/null || true
echo "  ✓ Josh stopped"

echo "  Stopping Audrey..."
cd "$PROJECT_DIR/agents/audrey"
docker compose --env-file "$ENV_FILE" down 2>/dev/null || true
echo "  ✓ Audrey stopped"

echo ""
echo "All agents stopped."
