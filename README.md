# MCP Dialog Server 🎯✨

> **Native macOS dialog popups for AI assistants** - Perfect for neurodivergent coders who prefer visual interactions over reading long text responses! 🐾

---

## ✨ Why This Exists

Do you ever find yourself skipping over long AI responses? *Same here!* 😅

This tool helps AI assistants communicate with you through **adorable native macOS popups** instead of walls of text. No more reading through paragraphs when you just need a quick answer! >w<

**Perfect for:**
- 🧠 **Autistic coders** who prefer visual, structured interactions
- ⚡ **ADHD developers** who need quick, focused decisions
- 👀 **Anyone** who wants faster, clearer communication with AI

---

## 🚀 Super Quick Install (Easiest!)

**Just one command!** Copy and paste this into your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/SolidifiedPlayDoh/mcp-dialog-server/main/quick-install.sh | bash
```

That's it! The script downloads, extracts, and configures everything automatically. Then just restart Cursor! :3

---

## 📥 Other Install Options

### Option 1: Download Pre-Built Release (No building needed!)

**Latest Release:** [v1.0.0](https://github.com/SolidifiedPlayDoh/mcp-dialog-server/releases/latest)

1. Download: [📦 .tar.gz](https://github.com/SolidifiedPlayDoh/mcp-dialog-server/releases/download/v1.0.0/mcp-dialog-server-1.0.0.tar.gz) or [📦 .zip](https://github.com/SolidifiedPlayDoh/mcp-dialog-server/releases/download/v1.0.0/mcp-dialog-server-1.0.0.zip)
2. Extract: `tar -xzf mcp-dialog-server-1.0.0.tar.gz` (or unzip the .zip)
3. Install: `cd release && ./install.sh`
4. Restart Cursor!

> 💡 Pre-built releases include everything - no `npm install` or `npm run build` needed! ✨

---

### Option 2: Clone from Source

```bash
git clone https://github.com/SolidifiedPlayDoh/mcp-dialog-server.git
cd mcp-dialog-server
npm install && npm run build
./install.sh
```

> 💡 The install script will automatically configure Cursor for you! It's like magic, but fluffier ✨ :3

---

```bash
git clone https://github.com/SolidifiedPlayDoh/mcp-dialog-server.git
cd mcp-dialog-server
npm install && npm run build
./install.sh
```

---

### Option 3: Manual Configuration

If you prefer to configure Cursor yourself:

#### 1. Clone and build

```bash
git clone https://github.com/SolidifiedPlayDoh/mcp-dialog-server.git
cd mcp-dialog-server
npm install
npm run build
```

#### 2. Add to Cursor MCP settings

Open Cursor settings (`Cmd+,` → search "MCP") and add:

```json
{
  "mcpServers": {
    "dialog-server": {
      "command": "node",
      "args": ["/absolute/path/to/mcp-dialog-server/dist/index.js"]
    }
  }
}
```

> ⚠️ **Don't forget to replace `/absolute/path/to/mcp-dialog-server` with your actual path!** 🐾

#### 3. Restart Cursor

Close and reopen Cursor and you're good to go! :3

---

## 💡 How It Works

Once installed, AI assistants can show you native macOS dialogs with questions and button choices. Instead of reading paragraphs, you get instant visual popups! It's like having a helpful friend pop up to ask you things instead of typing a novel~ >w< ✨

**Example flow:**
```
AI asks: "Which language should we use?"
    ↓
Popup shows: [Python] [Swift] [Cancel]
    ↓
You click → AI proceeds based on your choice
    ↓
Everyone's happy! 🎉
```

---

## 🎨 Features

| Feature | Description |
|---------|-------------|
| ✅ **Native macOS dialogs** | Uses AppleScript for system popups (super smooth! :3) |
| ✅ **Up to 3 buttons** | Per dialog (macOS limitation, but we work with it! >w<) |
| ✅ **Multiple popups** | Chain dialogs for more options (like a conversation! ✨) |
| ✅ **Default/Cancel buttons** | Full macOS dialog support |
| ✅ **Works with Cursor** | Seamless MCP integration |

---

## 📋 Requirements

- **macOS** (uses `osascript` - Apple's magic ✨)
- **Node.js** 18+
- **Cursor** with MCP support

---

## 🛠️ Development

Want to help make this even better? Here's how to get started:

```bash
npm install
npm run build
npm start  # Test the server
```

---

## 📝 License

**MIT** - Free to use, modify, and share! Spread the fluff! 🐾 :3

---

## 🤝 Contributing

PRs welcome! This tool helps neurodivergent developers, so improvements are always appreciated. Whether it's bug fixes, new features, or just making things cuter - we'd love your help! >w< ✨

---

<div align="center">

**Made with ❤️ and lots of fluff for the neurodivergent coding community by a neurodivergent developer :3**

*Hope this helps you! 🐾✨ >w<*

</div>
