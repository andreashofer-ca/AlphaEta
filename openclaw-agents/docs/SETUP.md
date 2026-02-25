# AlphaEta Setup Guide

## Prerequisites

- **macOS** with Docker Desktop installed and running
- **Ollama** running on `10.0.0.181:11434` with models: `qwen3:14b`, `qwen3-coder-next:cloud`
- **Telegram** account (for creating bots via @BotFather)
- **API Keys**: Anthropic and OpenAI (for cloud fallbacks)

## Step 1: Create Telegram Bots

You need **two separate Telegram bots** — one for each agent.

### Josh's Bot
1. Open Telegram, search for **@BotFather**
2. Send `/newbot`
3. Display name: `Josh Research Bot` (or whatever you prefer)
4. Username: `josh_alphaeta_bot` (must be unique, must end in `bot`)
5. Save the token (looks like `7123456789:AAHx0rJ9...`)

### Audrey's Bot
1. Still in @BotFather, send `/newbot` again
2. Display name: `Audrey Schedule Bot`
3. Username: `audrey_alphaeta_bot`
4. Save the token

### Recommended BotFather Settings
For each bot, optionally run:
- `/setdescription` — Set a description explaining what the bot does
- `/setprivacy` — Set to `OFF` if you want the bot to see all group messages
- `/setjoingroups` — Set to `Disable` if the bot should only work in DMs

## Step 2: Configure Environment

```bash
cd openclaw-agents
cp .env.example .env
```

Edit `.env` with your actual values:

```env
OLLAMA_HOST=10.0.0.181
OLLAMA_PORT=11434
ANTHROPIC_API_KEY=sk-ant-your-key-here
OPENAI_API_KEY=sk-your-key-here
OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
JOSH_TELEGRAM_BOT_TOKEN=your-josh-bot-token
AUDREY_TELEGRAM_BOT_TOKEN=your-audrey-bot-token
```

Generate a gateway token:
```bash
echo "OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)" >> .env
```

## Step 3: Run Setup

```bash
./scripts/setup.sh
```

This will:
1. Verify Docker is running
2. Check Ollama connectivity
3. Pull the OpenClaw Docker image
4. Run onboarding for both agents

## Step 4: Start Agents

```bash
./scripts/start-all.sh
```

Verify they're running:
```bash
docker ps --filter 'label=com.alphaeta.agent'
```

## Step 5: Test

- Open Telegram and message **Josh's bot**: "What are the latest developments in AI agents?"
- Open Telegram and message **Audrey's bot**: "Set up my habits: exercise, meditation, reading, deep work"

## Troubleshooting

### Agent won't start
```bash
cd agents/josh  # or agents/audrey
docker compose --env-file ../../.env logs
```

### Ollama connection issues
The agents connect to Ollama at `10.0.0.181:11434` directly (not via Docker networking). Verify:
```bash
curl http://10.0.0.181:11434/api/tags
```

### Model not responding
Ensure `api: "openai-responses"` is set in the Ollama provider config. Without this, Ollama silently fails.

### Dashboard access
```bash
cd agents/josh
docker compose --env-file ../../.env run --rm josh-cli dashboard --no-open
```

## Architecture

```
┌─────────────────────────────────────────────┐
│              Docker Desktop (Mac)            │
│                                              │
│  ┌──────────────┐    ┌──────────────────┐   │
│  │  Josh Agent   │    │  Audrey Agent     │   │
│  │  :18789/:18790│    │  :18791/:18792    │   │
│  │               │    │                   │   │
│  │  Research &   │    │  Schedule &       │   │
│  │  Draft Posts  │    │  Habit Tracker    │   │
│  │               │    │                   │   │
│  │  Telegram Bot │    │  Telegram Bot     │   │
│  └──────┬───────┘    └────────┬──────────┘   │
│         │  Shared Skills Vol   │              │
│         └──────────┬───────────┘              │
│                    │                          │
└────────────────────┼──────────────────────────┘
                     │
          ┌──────────┴──────────┐
          │  Ollama (10.0.0.181) │
          │  qwen3:14b           │
          │  qwen3-coder-next    │
          └─────────────────────┘
```
