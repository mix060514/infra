# AI Stack

使用 Docker Compose 部署的 AI 服務，包含 Ollama 和 Open-WebUI。

## 前置需求

- NVIDIA GPU
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## 快速開始

```bash
# 啟動服務
docker compose up -d

# 下載模型
docker exec -it ollama ollama pull llama3.2
```

## 服務

| 服務 | URL | 說明 |
|------|-----|------|
| Open-WebUI | http://localhost:3000 | 聊天介面 |
| Ollama API | http://localhost:11434 | LLM API |

## 自訂模型

`models/gguf/` 目錄下有預設的 Modelfile，可用於建立自訂模型：

```bash
# 進入容器
docker exec -it ollama bash

# 建立自訂模型 (需先將 .gguf 檔案放入 models/gguf/)
ollama create my-model -f /models/Modelfile
```

## 資料持久化

- `data/ollama/` - Ollama 模型與設定
- `data/open-webui/` - Open-WebUI 使用者資料
- `models/gguf/` - 自訂 GGUF 模型檔案 (不會 git 追蹤)
