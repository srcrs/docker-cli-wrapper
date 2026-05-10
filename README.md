# Docker CLI Wrapper

用 Docker 运行 npm 工具，主机不需要安装 Node.js/npm。

## 原理

每个 npm 工具用一个 shell wrapper 封装，通过 `docker run` 直接执行，用完即删，配置文件通过 volume 挂载到 `~/.tool-name`，运行后自动修复属主。

参考了 [Trellis CLI](https://github.com/mindfoldhq/trellis) 的实现方式。

## 结构

```
.
├── wrappers/          # wrapper 脚本目录
│   └── mmx            # MiniMax CLI wrapper (第一个实例)
├── Makefile
└── README.md
```

## 添加新 wrapper

复制 `wrappers/mmx` 模板，改三处：

```bash
#!/usr/bin/env bash
# <tool-name> wrapper - runs <npm-package> inside Docker

set -e

_uid=$(id -u)
_gid=$(id -g)
_config_dir="${HOME}/.<tool-name>"

exec docker run --rm -i \
  -v "${_config_dir}:/home/app/.<tool-name>" \
  -w /home/app \
  node:22-alpine \
  sh -c "
    npm install -g --force <npm-package> >/dev/null 2>&1
    _rc=0
    <npm-command> \"\$@\" || _rc=\$?
    find /home/app/.<tool-name> -not -user ${_uid} -exec chown ${_uid}:${_gid} {} + 2>/dev/null || true
    exit \$_rc
  " -- "$@"
```

安装到 `~/.local/bin/`：

```bash
cp wrappers/<tool-name> ~/.local/bin/<tool-name>
chmod +x ~/.local/bin/<tool-name>
```

## 当前可用

### mmx (MiniMax CLI)

```bash
# 安装
cp wrappers/mmx ~/.local/bin/mmx && chmod +x ~/.local/bin/mmx

# 配置（API key 存在 ~/.mmx/config.json）
mmx config set --key api-key --value your-key
mmx config set --key region --value cn

# 使用
mmx text chat "hello"
mmx image generate "一只猫"
mmx speech synthesize "你好"
mmx music generate "轻快音乐"
```
