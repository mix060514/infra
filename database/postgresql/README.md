# PostgreSQL

使用 Docker Compose 部署的 PostgreSQL 資料庫服務。

## 快速開始

```bash
# 啟動服務
docker compose up -d

# 查看日誌
docker compose logs -f

# 停止服務
docker compose down
```

## 設定

編輯 `.env` 檔案來設定環境變數：

- `POSTGRES_USER` - 資料庫使用者名稱
- `POSTGRES_PASSWORD` - 資料庫密碼
- `POSTGRES_DB` - 預設資料庫名稱
- `POSTGRES_VERSION` - PostgreSQL 版本 (預設: `17-alpine`)

## 連線資訊

- **Host**: `localhost`
- **Port**: `5432`

## 資料持久化

資料庫資料儲存在 `./data` 目錄中。
