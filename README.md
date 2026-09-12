# AEGIS Governance — MCP Server

> **Status: the hosted AEGIS service is offline (since September 2026).**
> The hosted API and the hosted MCP endpoint (`mcp.aegis.undercurrentholdings.com`) are offline.
> The local server does not evaluate proposals itself, so no tool returns an evaluation at this time.
> Current status: <https://undercurrentholdings.com/status/>

## What the package is

`aegis-governance` on PyPI is a Python client for the AEGIS API. It also contains a local
MCP server. The package installs one console script, `aegis-mcp-server`. This script starts
a local MCP server that uses the stdio transport. The package has no other command-line tool.

The local server has no evaluation engine. By default, the client sends all requests to the
hosted AEGIS API. Sandbox mode (the mode without an API key) also uses the hosted API. While
the hosted service is offline, tool calls do not return evaluations.

## Install

```bash
pip install "aegis-governance[mcp]"
```

The `[mcp]` extra is necessary for `aegis-mcp-server`. On Python < 3.10, the extra installs
nothing, and `aegis-mcp-server` exits with an install hint.

## Local stdio MCP configuration

**Claude Code**

```bash
claude mcp add aegis -- aegis-mcp-server
```

**Cursor** (`.cursor/mcp.json`) / **Windsurf** / any stdio MCP client:

```json
{
  "mcpServers": {
    "aegis": { "command": "aegis-mcp-server" }
  }
}
```

**VS Code** (`.vscode/mcp.json`):

```json
{
  "servers": {
    "aegis": { "type": "stdio", "command": "aegis-mcp-server" }
  }
}
```

## Tools

`tools/list` from `aegis-mcp-server` in `aegis-governance` 1.4.2 returns these six tools.
Without `AEGIS_API_KEY`, `aegis_evaluate_proposal` and `aegis_health` call the hosted API, and
the other four tools return an `AuthenticationError` JSON result without an API call. With
`AEGIS_API_KEY` set, all six tools call the hosted API.

The descriptions below are quoted from the server. They do not describe a service that is
available now.

| Tool | Description (quoted from the server) |
|------|--------------------------------------|
| `aegis_evaluate_proposal` | Evaluate an engineering proposal through the AEGIS gate checks. |
| `aegis_quick_risk_check` | Quick risk threshold check without a full Bayesian evaluation. |
| `aegis_health` | Check AEGIS API health (service status, version, components). |
| `aegis_list_decisions` | List recent governance decisions for the authenticated customer. |
| `aegis_get_decision` | Fetch a specific governance decision by ID, with full gate detail. |
| `aegis_get_usage` | Get the authenticated customer's evaluation usage report. |

## Reading the source

The `aegis-governance` source repository is private. To read the published source, download
the source distribution (sdist) from PyPI:

```bash
pip download --no-binary :all: --no-deps "aegis-governance==1.4.2"
```

Or get the `.tar.gz` file from the [PyPI release files](https://pypi.org/project/aegis-governance/1.4.2/#files).
