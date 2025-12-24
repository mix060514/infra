# Infra

個人基礎設施配置，使用 Docker Compose 管理各種自架服務。

## 📁 專案結構

```
infra/
├── ai-stack/           # AI 服務 (Ollama + Open-WebUI)
├── database/
│   └── postgresql/     # PostgreSQL + pgAdmin
└── mlflow/             # MLflow 實驗追蹤
```

## 🚀 快速部署

### 前置需求

- [Docker](https://docs.docker.com/get-docker/) 與 Docker Compose
- NVIDIA GPU + [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) (ai-stack 需要)

### 部署順序

建議按以下順序啟動服務：

#### 1️⃣ PostgreSQL (資料庫基礎)

```bash
cd database/postgresql
cp .env.example .env
# 編輯 .env 設定密碼
docker compose up -d
```

#### 2️⃣ AI Stack (Ollama + Open-WebUI)

```bash
cd ai-stack
docker compose up -d

# 下載模型 (依需求選擇)
docker exec -it ollama ollama pull llama3.2
```

#### 3️⃣ MLflow (需要 PostgreSQL)

```bash
cd mlflow
cp .env.example .env
# 編輯 .env 設定 PostgreSQL 密碼

# 建立 mlflow 資料庫
docker exec -it infra-postgres psql -U postgres -c "CREATE DATABASE mlflow;"

docker compose up -d
```

## 🔗 服務端口

| 服務 | URL | 說明 |
|------|-----|------|
| Open-WebUI | http://localhost:3000 | AI 聊天介面 |
| Ollama API | http://localhost:11434 | LLM API |
| PostgreSQL | localhost:5432 | 資料庫 |
| pgAdmin | http://localhost:5050 | 資料庫管理 |
| MLflow | http://localhost:5000 | 實驗追蹤 |

## 📝 環境變數

每個服務都有 `.env.example` 範例檔，部署時需複製並修改：

```bash
cp .env.example .env
```

> ⚠️ **注意**：`.env` 檔案包含敏感資訊，已被 `.gitignore` 排除，不會上傳到 Git。

## 🛠️ 常用指令

```bash
# 查看所有運行中的容器
docker ps

# 查看特定服務日誌
docker compose logs -f

# 停止服務
docker compose down

# 完全清除 (包含資料)
docker compose down -v
```

## 📚 各服務詳細說明

- [AI Stack](ai-stack/README.md)
- [PostgreSQL](database/postgresql/README.md)
- [MLflow](mlflow/README.md)

## 🔒 安全提醒

- 所有 `.env` 檔案請妥善保管，不要上傳到公開儲存庫
- 建議使用強密碼
- 如需外部訪問，請設定防火牆規則
