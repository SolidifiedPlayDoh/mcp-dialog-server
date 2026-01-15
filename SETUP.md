# Quick Setup Guide

## 1. Build (if not already done)
```bash
cd mcp-dialog-server
npm install
npm run build
```

## 2. Add to Cursor MCP Settings

Open Cursor settings (Cmd+,) and find "MCP Servers" or search for "mcp" in settings.

Add this configuration:

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

**Important:** Make sure the path matches your actual location!

## 3. Restart Cursor

Close and reopen Cursor for the MCP server to load.

## 4. Test It!

Once set up, I can use it like this:

**Example:** If you ask for Python code, I'll show a popup:
- Question: "Are you sure you want Python? Swift might be better!"
- Buttons: ["Python", "Swift", "Cancel"]
- Default: "Swift"

You click a button, and I proceed based on your choice!

## Troubleshooting

- **Server not found:** Check the path in Cursor settings matches your actual file location
- **Permission denied:** Make sure `dist/index.js` is executable: `chmod +x dist/index.js`
- **Dialog doesn't appear:** Check Cursor's MCP logs/console for errors
