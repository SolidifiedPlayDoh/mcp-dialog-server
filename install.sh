#!/bin/bash

# MCP Dialog Server Installation Script
# Automatically configures Cursor to use the dialog server

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_PATH="$SCRIPT_DIR/dist/index.js"
CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
CURSOR_CONFIG_FILE="$CURSOR_CONFIG_DIR/globalStorage/rooveterinaryinc.roo-cline/settings/cline_mcp_settings.json"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🎯 MCP Dialog Server Installer${NC}"
echo ""

# Check if dist/index.js exists
if [ ! -f "$DIST_PATH" ]; then
    echo -e "${RED}❌ Error: dist/index.js not found!${NC}"
    echo "Please run 'npm run build' first."
    exit 1
fi

echo -e "${GREEN}✅ Build file found at: $DIST_PATH${NC}"
echo ""

# Check if Cursor config directory exists
if [ ! -d "$CURSOR_CONFIG_DIR" ]; then
    echo -e "${YELLOW}⚠️  Cursor config directory not found.${NC}"
    echo "Please make sure Cursor is installed and has been opened at least once."
    exit 1
fi

# Create settings directory if it doesn't exist
mkdir -p "$(dirname "$CURSOR_CONFIG_FILE")"

# Check if config file exists, if not create it
if [ ! -f "$CURSOR_CONFIG_FILE" ]; then
    echo -e "${YELLOW}⚠️  Cursor MCP config file not found. Creating it...${NC}"
    echo '{"mcpServers": {}}' > "$CURSOR_CONFIG_FILE"
fi

# Read existing config
CONFIG=$(cat "$CURSOR_CONFIG_FILE")

# Check if dialog-server already exists
if echo "$CONFIG" | grep -q "dialog-server"; then
    echo -e "${YELLOW}⚠️  dialog-server already configured.${NC}"
    read -p "Update existing configuration? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

# Use node to update JSON (more reliable than sed)
node -e "
const fs = require('fs');
const config = JSON.parse(fs.readFileSync('$CURSOR_CONFIG_FILE', 'utf8'));
config.mcpServers = config.mcpServers || {};
config.mcpServers['dialog-server'] = {
    command: 'node',
    args: ['$DIST_PATH']
};
fs.writeFileSync('$CURSOR_CONFIG_FILE', JSON.stringify(config, null, 2));
console.log('✅ Configuration updated!');
"

echo ""
echo -e "${GREEN}✨ Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart Cursor"
echo "2. The dialog server will be available to AI assistants"
echo ""
echo "To test, ask an AI assistant to show you a dialog!"
