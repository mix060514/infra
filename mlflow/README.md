# MLflow

MLflow 是一個開源的機器學習生命週期管理平台，用於追蹤實驗、打包模型和部署。

## 快速開始

### 1. 設定環境變數

```bash
cp .env.example .env
# 編輯 .env，填入正確的 PostgreSQL 密碼
```

### 2. 建立資料庫

確保 PostgreSQL 已啟動，並建立 MLflow 資料庫：

```bash
docker exec -it infra-postgres psql -U postgres -c "CREATE DATABASE mlflow;"
```

### 3. 啟動服務

```bash
docker compose up -d
```

### 4. 訪問 MLflow UI

瀏覽器開啟 http://localhost:5000

## 環境變數說明

| 變數 | 預設值 | 說明 |
|------|--------|------|
| `POSTGRES_HOST` | `host.docker.internal` | PostgreSQL 主機位址 |
| `POSTGRES_PORT` | `5432` | PostgreSQL 連接埠 |
| `POSTGRES_USER` | `postgres` | PostgreSQL 使用者 |
| `POSTGRES_PASSWORD` | - | PostgreSQL 密碼 |
| `MLFLOW_DB` | `mlflow` | MLflow 使用的資料庫名稱 |
| `MLFLOW_PORT` | `5000` | MLflow 服務連接埠 |

## 常用指令

```bash
# 啟動服務
docker compose up -d

# 查看日誌
docker compose logs -f mlflow

# 停止服務
docker compose down
```

## Python 使用範例

```python
import mlflow

# 設定 tracking URI
mlflow.set_tracking_uri("http://localhost:5000")

# 開始實驗
with mlflow.start_run():
    mlflow.log_param("learning_rate", 0.01)
    mlflow.log_metric("accuracy", 0.95)
```
