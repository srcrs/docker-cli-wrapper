# Research: MiniMax-AI/cli

- **Query**: Research MiniMax-AI/cli GitHub repository for CLI commands, dependencies, API interaction, Docker support, API endpoints, headless usage, and install footprint
- **Scope**: external
- **Date**: 2026-05-10

## Findings

### Repository Overview

| Property | Value |
|---|---|
| Full Name | MiniMax-AI/cli |
| Stars | 1,706 |
| Language | TypeScript |
| Default Branch | main |
| npm Package | mmx-cli |
| Version | 1.0.12 |
| Engine | Node.js >= 18 |

### CLI Commands

| Command | Subcommands | Description |
|---|---|---|
| `mmx text` | chat | Multi-turn chat, streaming, system prompts, JSON output |
| `mmx image` | generate | Text-to-image with aspect ratio and batch controls |
| `mmx video` | generate, task, download | Async video generation with progress tracking |
| `mmx speech` | synthesize, voices | TTS with 30+ voices, speed control, streaming playback |
| `mmx music` | generate, cover | Text-to-music with lyrics, instrumental, cover generation |
| `mmx vision` | describe | Image understanding and description |
| `mmx search` | query | Web search powered by MiniMax |
| `mmx auth` | login, status, refresh, logout | Authentication via API key or OAuth |
| `mmx config` | show, set, export-schema | Configuration management |
| `mmx quota` | - | View token quota usage |
| `mmx update` | - | Self-update checker |

### npm Dependencies

**Production Dependencies** (3 total):
- `@clack/prompts` (^0.7.0) - UI prompts
- `bun-plugin-dts` (^0.4.0) - TypeScript declaration generation
- `es-toolkit` (^1.46.1) - Utility functions

**Dev Dependencies**:
- `@types/bun`, `eslint`, `typescript`, `typescript-eslint`

**Analysis**: Extremely lightweight. No heavy SDK dependencies - all API interaction is custom HTTP calls.

### Package Structure (dist/)

Only 3 files published to npm:
- `dist/mmx.mjs` - CLI entry point
- `dist/sdk.mjs` - TypeScript SDK
- `dist/index.d.ts` - Type declarations

### API Interaction

#### Base URLs
| Region | Base URL |
|---|---|
| Global | `https://api.minimax.io` |
| CN | `https://api.minimaxi.com` |

#### API Endpoints

| Feature | Endpoint | Method |
|---|---|---|
| Text/Chat | `/anthropic/v1/messages` | POST |
| Speech | `/v1/t2a_v2` | POST |
| Voices List | `/v1/get_voice` | GET |
| Image | `/v1/image_generation` | POST |
| Video Generate | `/v1/video_generation` | POST |
| Video Task Status | `/v1/query/video_generation?task_id={id}` | GET |
| Music | `/v1/music_generation` | POST |
| Search | `/v1/coding_plan/search` | POST |
| Vision (VLM) | `/v1/coding_plan/vlm` | POST |
| Quota | `/v1/token_plan/remains` | GET |
| Files Upload | `/v1/files` | POST |
| Files List | `/v1/files` | GET |
| Files Delete | `/v1/files?file_id={id}` | DELETE |
| Files Retrieve | `/v1/files/retrieve?file_id={id}` | GET |

#### Authentication Methods

1. **API Key** (preferred for headless/CI):
   - Flag: `--api-key sk-xxxxx`
   - Config file: `~/.mmx/config.json`
   - Environment: `MINIMAX_API_KEY`

2. **OAuth** (interactive browser flow):
   - File: `~/.mmx/credentials.json`
   - Token refresh supported

**Auth Resolution Order** (from `src/auth/resolver.ts`):
1. `--api-key` flag
2. OAuth credentials file
3. API key from config file

### Docker Support

**Status: NONE**

- No `Dockerfile` in repository
- No `docker` directory
- No docker-related files in the tree
- No container configuration in `package.json`

### Headless/Non-Interactive Usage

**Yes, fully supported.**

Key flags for headless use:
- `--api-key <key>` - Pass API key directly (no OAuth flow)
- `--output json` - JSON output for parsing
- `--quiet` - Suppress non-essential output
- `--async` - For video generation (returns task ID immediately)

Environment variable support:
- `MINIMAX_API_KEY` - API key via environment
- Config via `~/.mmx/config.json`

Streaming support for real-time output:
- `--stream` flag for text chat
- Streaming audio output for speech

### Minimal Install Footprint

**Very lightweight:**
- npm install size: ~3 dist files + deps
- No native binaries
- No platform-specific builds
- Config stored in `~/.mmx/`

### Related Files

| Path | Description |
|---|---|
| `README.md` | Main documentation with all command examples |
| `SDK.md` | TypeScript SDK usage documentation |
| `AGENTS.md` | Agent coding guidelines and project structure |
| `ERRORS.md` | Error reference for all commands |
| `src/client/endpoints.ts` | All API endpoint URL builders |
| `src/auth/resolver.ts` | Credential resolution logic |
| `src/registry.ts` | Command registry |

### SDK Usage Example

```typescript
import { MiniMaxSDK } from 'mmx-cli/sdk';

const sdk = new MiniMaxSDK({
  apiKey: 'sk-xxxxx',
  region: 'global', // or 'cn'
});

// Text chat
const response = await sdk.text.chat({
  model: 'MiniMax-M2.7',
  messages: [{ role: 'user', content: 'Hello!' }],
});

// Streaming
const stream = await sdk.text.chat({ ..., stream: true });
for await (const event of stream) {
  console.log(event.choices[0]?.delta?.content);
}
```

## Caveats / Not Found

- No Docker support exists in the repository - containerization would need to be created from scratch
- No built-in CI/CD integration examples
- No offline mode or local model support
- Quota endpoint always uses `api.minimax.io` or `api.minimaxi.com` regardless of baseUrl setting