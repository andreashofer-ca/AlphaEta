# AlphaEta — OpenClaw Multi-Agent Platform

A Docker-based multi-agent system running on Docker Desktop for macOS. Two OpenClaw agents with shared configuration, connected to a local Ollama instance with cloud API fallbacks.

## Agents

| Agent | Role | Telegram | Ports |
|-------|------|----------|-------|
| **Josh** | AI & Tech Research, content drafting | Own bot | 18789, 18790 |
| **Audrey** | Personal schedule, habit tracking | Own bot | 18791, 18792 |

## Shared Infrastructure

- **Models**: Ollama `qwen3:14b` + `qwen3-coder-next:cloud` on `10.0.0.181`
- **Cloud Fallbacks**: Anthropic Claude + OpenAI GPT
- **Common Skills**: Web search, summarization, formatting utilities
- **State**: Each agent maintains independent state in Docker volumes

## Quick Start

```bash
# 1. Clone and configure
git clone https://github.com/andreashofer-ca/AlphaEta.git
cd AlphaEta/openclaw-agents
cp .env.example .env
# Edit .env with your API keys and Telegram bot tokens

# 2. Setup (pulls images, runs onboarding)
./scripts/setup.sh

# 3. Start both agents
./scripts/start-all.sh

# 4. Stop both agents
./scripts/stop-all.sh
```

See [docs/SETUP.md](docs/SETUP.md) for the full setup guide including Telegram bot creation.

## Project Structure

```
openclaw-agents/
├── shared/                  # Config & skills shared by all agents
│   ├── openclaw-base.json   # Shared models, providers, defaults
│   └── skills/              # Common skill definitions
├── agents/
│   ├── josh/                # Research agent
│   │   ├── docker-compose.yml
│   │   ├── openclaw.json    # Josh-specific config
│   │   ├── workspace/       # Josh's persistent files
│   │   └── skills/          # Josh-specific skills
│   └── audrey/              # Schedule & habits agent
│       ├── docker-compose.yml
│       ├── openclaw.json    # Audrey-specific config
│       ├── workspace/       # Audrey's persistent files (habit logs, schedule)
│       └── skills/          # Audrey-specific skills
├── scripts/                 # Management scripts
│   ├── setup.sh
│   ├── start-all.sh
│   └── stop-all.sh
├── .env.example             # Environment variable template
└── docs/
    └── SETUP.md             # Detailed setup guide
```

## Adding a New Agent

1. Copy an existing agent directory: `cp -r agents/josh agents/newagent`
2. Edit `agents/newagent/openclaw.json` — change name, personality, tools, skills
3. Edit `agents/newagent/docker-compose.yml` — change container names and ports
4. Add new Telegram bot token to `.env`
5. Run onboarding: `cd agents/newagent && docker compose --env-file ../../.env run --rm newagent-cli onboard`
