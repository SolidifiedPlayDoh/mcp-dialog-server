#!/bin/bash

# Create Release Script for MCP Dialog Server
# Builds the project and creates a GitHub release with downloadable assets

set -e

VERSION=${1:-"1.0.0"}
RELEASE_NAME="v${VERSION}"

echo "🎯 Building MCP Dialog Server for release..."
npm run build

echo "📦 Creating release package..."
mkdir -p release
cp -r dist release/
cp package.json release/
cp package-lock.json release/
cp README.md release/
cp SETUP.md release/
cp LICENSE release/
cp install.sh release/

# Create a tarball
tar -czf mcp-dialog-server-${VERSION}.tar.gz -C release .
zip -r mcp-dialog-server-${VERSION}.zip release/

echo "✨ Creating GitHub release..."
gh release create ${RELEASE_NAME} \
  --title "MCP Dialog Server ${RELEASE_NAME}" \
  --notes "🎉 First release of MCP Dialog Server!

**What's included:**
- ✅ Native macOS dialog popups for AI assistants
- ✅ Automatic installation script
- ✅ Full documentation
- ✅ Perfect for neurodivergent developers :3

**Quick Install:**
\`\`\`bash
# Download and extract
tar -xzf mcp-dialog-server-${VERSION}.tar.gz
cd release
npm install && npm run build
./install.sh
\`\`\`

Made with ❤️ and lots of fluff! 🐾✨" \
  mcp-dialog-server-${VERSION}.tar.gz \
  mcp-dialog-server-${VERSION}.zip

echo "🧹 Cleaning up..."
rm -rf release

echo "✅ Release created! Check it out at:"
echo "https://github.com/SolidifiedPlayDoh/mcp-dialog-server/releases/tag/${RELEASE_NAME}"
