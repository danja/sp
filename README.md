# sonic-pi-mcp

This connects any MCP client with Sonic Pi enabling you to create music with English.

## Sonic Pi MCP Server

This repository includes a Node.js MCP (Model Context Protocol) server for controlling Sonic Pi via OSC.

*I wanted to use [mcp-sonic-pi](https://github.com/vinayak-mehta/mcp-sonic-pi) but had issues on my system so ported it to Node*

### Features
- Direct OSC communication with Sonic Pi (no psonic dependency)
- Supports both Sonic Pi v3.x and v4.x
- Automatic port detection from Sonic Pi log files


### Setup
1. Install dependencies:
 

2. Configure in `~/.claude.json`:
   ```json
   "sonic-pi": {
     "type": "stdio",
     "command": "node",
     "args": ["/path/to/sonic-pi-mcp/mcp/server.js"],
     "env": {}
   }
   ```

3. Restart Claude Code

### Port Configuration Note
The MCP server automatically detects the correct port from Sonic Pi's log files. If Sonic Pi is running on a non-standard OSC port (e.g., 4560 instead of the default 4557), the server will find and use the correct port automatically by parsing `~/.sonic-pi/log/server-output.log`.

### Documentation
See `/mcp/README.md` for detailed documentation.
