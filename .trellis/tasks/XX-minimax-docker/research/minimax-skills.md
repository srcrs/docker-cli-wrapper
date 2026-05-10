# Research: MiniMax-AI/skills Repository

- **Query**: MiniMax-AI/skills GitHub repository structure, skills available, how they work with MiniMax API
- **Scope**: external
- **Date**: 2026-05-10

## Findings

### Repository Overview

The [MiniMax-AI/skills](https://github.com/MiniMax-AI/skills) repository (11,685 stars, 996 forks, MIT license) contains AI coding skills designed for AI coding agents like Claude Code, Cursor, Codex, and OpenCode. It is written primarily in C# but contains skill definitions in Markdown.

### Files Found

| File Path | Description |
|---|---|
| `skills/frontend-dev/` | Full-stack frontend development skill with design, motion, AI-generated assets, copywriting |
| `skills/minimax-multimodal-toolkit/` | Core skill for MiniMax API access via `mmx` CLI |
| `skills/gif-sticker-maker/` | Animated GIF generation via MiniMax Image & Video API |
| `skills/minimax-pdf/` | PDF document generation and filling |
| `skills/pptx-generator/` | PowerPoint generation via PptxGenJS |
| `skills/minimax-xlsx/` | Excel/spreadsheet manipulation via XML templates and pandas |
| `skills/minimax-docx/` | DOCX creation and editing via OpenXML SDK |
| `skills/vision-analysis/` | Image analysis via MiniMax VL API |
| `skills/minimax-music-gen/` | Music generation via MiniMax Music API |
| `skills/minimax-music-playlist/` | Playlist generation based on taste profile |
| `skills/buddy-sings/` | Let Claude Code pet sing via minimax-music-gen |
| `skills/android-native-dev/` | Android native development (Kotlin/Jetpack Compose) |
| `skills/ios-application-dev/` | iOS development (UIKit, SnapKit, SwiftUI) |
| `skills/flutter-dev/` | Flutter cross-platform development |
| `skills/react-native-dev/` | React Native and Expo development |
| `skills/shader-dev/` | GLSL shader techniques |
| `skills/fullstack-dev/` | Full-stack backend and frontend integration |

### Skill Structure

Each skill follows this directory layout:

```
skills/<skill-name>/
├── SKILL.md                 # Required - entry point with YAML frontmatter
├── references/              # Optional - detailed reference docs
│   └── *.md
└── scripts/                 # Optional - helper scripts
    ├── *.py
    └── requirements.txt     # Required if scripts/ exists
```

**SKILL.md Frontmatter Fields:**
- `name` (required) - must match directory name
- `description` (required) - trigger conditions for when to use the skill
- `license` - defaults to MIT
- `metadata` - version, category, sources

### Core Skill: minimax-multimodal-toolkit (mmx CLI)

The `minimax-multimodal-toolkit` skill provides access to the `mmx` CLI tool which is the primary interface to MiniMax API:

**Installation:**
```bash
npm install -g mmx-cli
mmx auth login --api-key sk-xxxxx
```

**Key Commands:**
| Command | Purpose |
|---|---|
| `mmx text chat` | Chat completion with MiniMax-M2.7 model |
| `mmx image generate` | Generate images (model: image-01) |
| `mmx video generate` | Generate video (model: MiniMax-Hailuo-2.3) |
| `mmx speech synthesize` | Text-to-speech (model: speech-2.8-hd) |
| `mmx music generate` | Music generation (model: music-2.5) |
| `mmx vision describe` | Image understanding via VLM |
| `mmx search query` | Web search via MiniMax |
| `mmx quota show` | Display Token Plan usage |

**Agent Flags (for non-interactive contexts):**
- `--non-interactive` - fail fast on missing args
- `--quiet` - suppress spinners, stdout is pure data
- `--output json` - machine-readable JSON
- `--async` - return task ID immediately (video generation)
- `--dry-run` - preview API request
- `--yes` - skip confirmation prompts

### frontend-dev Skill

Combines five capabilities: design engineering, motion systems (Framer Motion, GSAP), AI-generated media assets via MiniMax API, persuasive copywriting (AIDA framework), and generative art (p5.js, Three.js).

**Asset Scripts:**
- `scripts/minimax_tts.py` - Text-to-speech
- `scripts/minimax_music.py` - Music generation
- `scripts/minimax_video.py` - Video generation (async)
- `scripts/minimax_image.py` - Image generation

**Reference Documents:**
- `references/minimax-cli-reference.md` - CLI flags quick reference
- `references/asset-prompt-guide.md` - Asset prompt engineering rules
- `references/minimax-tts-guide.md` - TTS usage & voices
- `references/minimax-music-guide.md` - Music prompts & lyrics format
- `references/minimax-video-guide.md` - Camera commands & models
- `references/minimax-image-guide.md` - Ratios & batch generation
- `references/minimax-voice-catalog.md` - All voice IDs
- `references/motion-recipes.md` - Animation code snippets
- `references/env-setup.md` - Environment setup
- `references/troubleshooting.md` - Common issues

### Docker/Containerization Notes

No Docker-related content found in the repository. The skills are designed to run on the host system with the `mmx` CLI installed.

### Installation Methods

**Claude Code:**
```bash
claude plugin marketplace add https://github.com/MiniMax-AI/skills
claude plugin install minimax-skills
```

**Cursor:**
```bash
git clone https://github.com/MiniMax-AI/skills.git ~/.cursor/minimax-skills
```

**Codex:**
```bash
git clone https://github.com/MiniMax-AI/skills.git ~/.codex/minimax-skills
```

**OpenCode:**
```bash
git clone https://github.com/MiniMax-AI/skills.git ~/.minimax-skills
```

### Contributing Guidelines

Each PR must follow Conventional Commits format, contain one purpose (add/fix/improve a skill), and include a PR description explaining what and why. Skills must not hardcode API keys - they must read from environment variables. File size should be kept in check since skills are loaded into the agent context window.

### External References

- [MiniMax-AI/skills GitHub](https://github.com/MiniMax-AI/skills) - Main repository
- [mmx-cli npm package](https://www.npmjs.com/package/mmx-cli) - CLI for MiniMax API
- [MiniMax Documentation](https://www.minimaxi.com/) - Platform documentation

### Related Specs

None found in the local `.trellis/spec/` directory related to MiniMax skills.

## Caveats / Not Found

- The repository's primary language is listed as C# but skill content is in Markdown/Python
- No Docker configuration found - skills assume host-level npm installation of mmx-cli
- No direct connection found between this repo and the local minimax-docker-wrapper project