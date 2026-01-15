#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { exec } from "child_process";
import { promisify } from "util";

const execAsync = promisify(exec);

interface DialogOptions {
  question: string;
  buttons: string[];
  defaultButton?: string;
  cancelButton?: string;
}

async function showMacOSDialog(options: DialogOptions): Promise<string> {
  const { question, buttons, defaultButton, cancelButton } = options;

  // Build AppleScript dialog command
  // macOS dialog can have up to 3 buttons
  const buttonList = buttons.slice(0, 3).map((btn, idx) =>
    `"${btn.replace(/"/g, '\\"')}"`
  ).join(", ");

  let script = `display dialog "${question.replace(/"/g, '\\"')}" `;

  if (buttonList) {
    script += `buttons {${buttonList}} `;
  }

  if (defaultButton && buttons.includes(defaultButton)) {
    script += `default button "${defaultButton.replace(/"/g, '\\"')}" `;
  }

  if (cancelButton && buttons.includes(cancelButton)) {
    script += `cancel button "${cancelButton.replace(/"/g, '\\"')}" `;
  }

  script += `with icon note`;

  try {
    const { stdout, stderr } = await execAsync(
      `osascript -e '${script}'`
    );

    // AppleScript returns "button returned:ButtonName"
    const match = stdout.match(/button returned:(.+)/);
    if (match) {
      return match[1].trim();
    }

    // If cancelled, return cancel button or first button
    if (stderr || !match) {
      return cancelButton || buttons[0] || "Cancel";
    }

    return buttons[0] || "OK";
  } catch (error: any) {
    // User cancelled or error occurred
    if (error.code === 1 || error.message.includes("User cancelled")) {
      return cancelButton || buttons[0] || "Cancel";
    }
    throw error;
  }
}

const server = new Server(
  {
    name: "mcp-dialog-server",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: "show_dialog",
        description: "Shows a native macOS dialog popup with a question and multiple button options. Returns the button label that was clicked. Maximum 3 buttons per dialog (macOS limitation). For more options, use multiple sequential popups.",
        inputSchema: {
          type: "object",
          properties: {
            question: {
              type: "string",
              description: "The question or message to display in the dialog",
            },
            buttons: {
              type: "array",
              items: { type: "string" },
              description: "Array of button labels (max 3 buttons per dialog - use multiple popups for more options)",
              minItems: 1,
            },
            defaultButton: {
              type: "string",
              description: "Optional: The label of the default button (must be in buttons array)",
            },
            cancelButton: {
              type: "string",
              description: "Optional: The label of the cancel button (must be in buttons array)",
            },
          },
          required: ["question", "buttons"],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  if (name === "show_dialog") {
    try {
      if (!args || typeof args !== "object") {
        throw new Error("Invalid arguments");
      }

      const dialogArgs = args as unknown as DialogOptions;

      // Check if more than 3 buttons are provided
      if (dialogArgs.buttons && dialogArgs.buttons.length > 3) {
        return {
          content: [
            {
              type: "text",
              text: `Error: Maximum 3 buttons per dialog (macOS limitation). You provided ${dialogArgs.buttons.length} buttons: ${dialogArgs.buttons.join(", ")}. Please use multiple sequential popups to handle more options.`,
            },
          ],
          isError: true,
        };
      }

      const result = await showMacOSDialog(dialogArgs);
      return {
        content: [
          {
            type: "text",
            text: result,
          },
        ],
      };
    } catch (error: any) {
      return {
        content: [
          {
            type: "text",
            text: `Error: ${error.message}`,
          },
        ],
        isError: true,
      };
    }
  }

  throw new Error(`Unknown tool: ${name}`);
});

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("MCP Dialog Server running on stdio");
}

main().catch((error) => {
  console.error("Fatal error:", error);
  process.exit(1);
});
