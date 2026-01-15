#!/bin/bash

# One-liner install script for MCP Dialog Server
# Run with: curl -fsSL https://raw.githubusercontent.com/SolidifiedPlayDoh/mcp-dialog-server/main/quick-install.sh | bash

set -e

echo "🎯 Installing MCP Dialog Server..."
echo ""

# Create temp directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Get latest release URL
LATEST_RELEASE=$(curl -s https://api.github.com/repos/SolidifiedPlayDoh/mcp-dialog-server/releases/latest)
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep "browser_download_url.*tar.gz" | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "❌ Could not find download URL. Falling back to git clone..."
    git clone https://github.com/SolidifiedPlayDoh/mcp-dialog-server.git
    cd mcp-dialog-server
    npm install && npm run build
    ./install.sh
    exit 0
fi

echo "📥 Downloading latest release..."
curl -L -o mcp-dialog-server.tar.gz "$DOWNLOAD_URL"

echo "📦 Extracting..."
tar -xzf mcp-dialog-server.tar.gz

cd release

# Check if node_modules exists, if not install dependencies
if [ ! -d "node_modules" ]; then
    echo "📚 Installing dependencies..."
    npm install --production
fi

# Run install script
echo "⚙️  Configuring Cursor..."
./install.sh

echo ""
echo "✨ Done! Restart Cursor to start using it! :3"
