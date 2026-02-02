#!/bin/bash
# ttyd + tmux 專業部署腳本

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SERVICE_NAME="ttyd.service"

echo "🛠️  正在為 $USER 部署 ttyd (Tmux 模式)..."

# 1. 建立 Service 檔案範本
cat <<EOF > "$DIR/$SERVICE_NAME.tmp"
[Unit]
Description=ttyd Web Terminal with Tmux
After=network.target

[Service]
# 使用 tmux new -A -s ttyd 確保中斷連線後程式不死
ExecStart=$DIR/ttyd.x86_64 -p 7681 -W bash
Restart=always
User=$USER
WorkingDirectory=$HOME
Environment=PATH=/usr/bin:/usr/local/bin

[Install]
WantedBy=multi-user.target
EOF

# 2. 建立連結並啟動
sudo ln -sf "$DIR/$SERVICE_NAME.tmp" /etc/systemd/system/$SERVICE_NAME
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

echo "✅ 部署成功！"
echo "🌐 開啟瀏覽器訪問 http://localhost:7681"
