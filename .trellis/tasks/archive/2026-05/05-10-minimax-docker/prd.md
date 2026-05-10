# Docker CLI Wrapper

## Goal

用 Docker 运行 npm 工具（以 mmx-cli 为例），主机不需要安装 Node.js/npm，wrapper 脚本放在 `~/.local/bin/`，换机器也能拷贝过去直接用。

## What I Already Know

### MiniMax-AI/cli (mmx-cli)
- **npm 包**: mmx-cli
- **命令**: text chat, image generate, video generate, speech synthesize, music generate, vision describe, search query, quota show
- **配置**: API key 存在 `~/.mmx/config.json`
- **Headless 支持**: `--output json --quiet --api-key` flags 完全支持

### Trellis CLI 实现方式
- 一个 bash wrapper，`docker run --rm -i` 直接运行
- 每次启动容器装 npm 包，用完即删
- `find ... -exec chown` 解决 root 权限问题

## Decisions Made

- **单脚本模式**: 不需要 Dockerfile / docker-compose
- **动态 UID/GID**: `find ... -exec chown` 修复挂载目录属主
- **配置目录挂载**: `${HOME}/.mmx` 挂载到容器内同名路径
- **位置**: `~/.local/bin/mmx`，和 `trellis` / `claude` 并列

## Requirements

- [ ] Docker 封装 mmx-cli 功能
- [ ] 主机不需要 Node.js 环境
- [ ] 换机器可拷贝直接用
- [ ] wrapper 脚本可复用，添加新工具时改三处即可

## Acceptance Criteria

- [ ] `mmx --version` 正常输出
- [ ] `mmx config set --key region --value cn` 正常写入
- [ ] 配置文件属主与宿主用户一致
