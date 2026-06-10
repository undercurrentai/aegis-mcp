# AEGIS Governance — MCP Server

[![PyPI](https://img.shields.io/pypi/v/aegis-governance)](https://pypi.org/project/aegis-governance/)
[![License: BSL-1.1](https://img.shields.io/badge/license-BSL--1.1-blue)](https://aegis.undercurrentholdings.com/docs)

**Quantitative governance for AI agents and engineering decisions.** AEGIS evaluates proposals through six quantitative gates — Risk, Profit, Novelty, Complexity, Quality, Utility — and returns a structured decision (`PROCEED` / `PAUSE` / `HALT` / `ESCALATE`) with confidence scores, rationale, and a hash-chained audit trail.

Give your agent a decision gate it can call before it acts — and an audit record compliance can actually read (NIST AI RMF, EU AI Act Annex IV).

- **Works immediately, no signup**: the local server runs in sandbox mode (10 evaluations/day).
- 6 local tools (evaluations, risk checks, health, decision history, usage) — 10 on the hosted server.
- Hosted server with hash-chained audit trails — [free Community tier](https://portal.undercurrentholdings.com/signup?product=aegis&utm_source=github&utm_medium=aegis-mcp) (100 evaluations/month, no credit card).
- Want to see it before connecting? [Try the Advisor in your browser](https://aegis.undercurrentholdings.com/advisor) — no install, no signup.

## Quickstart (local, no account needed)

```bash
pip install "aegis-governance[mcp]"
```

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

Runs in sandbox mode out of the box. Set `AEGIS_API_KEY` in the server's
environment ([free key](https://portal.undercurrentholdings.com/signup?product=aegis&utm_source=github&utm_medium=aegis-mcp))
to unlock decision history, usage reports, and risk checks. Requires Python >= 3.10.

## Hosted server (streamable-http, full 10-tool surface)

Get a free API key at [portal.undercurrentholdings.com](https://portal.undercurrentholdings.com/signup?product=aegis&utm_source=github&utm_medium=aegis-mcp) (GitHub/Google sign-in, key provisioned automatically), then:

**Claude Code**

```bash
claude mcp add --transport streamable-http aegis https://mcp.aegis.undercurrentholdings.com/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
```

**Cursor** (`.cursor/mcp.json`) / **Windsurf** / any streamable-http MCP client:

```json
{
  "mcpServers": {
    "aegis": {
      "type": "streamable-http",
      "url": "https://mcp.aegis.undercurrentholdings.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    }
  }
}
```

**VS Code** (`.vscode/mcp.json`):

```json
{
  "servers": {
    "aegis": {
      "type": "http",
      "url": "https://mcp.aegis.undercurrentholdings.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    }
  }
}
```

## Prefer a local SDK instead of MCP?

The Python SDK has a sandbox mode that works with no account at all (10 evaluations/day):

```bash
pip install aegis-governance
```

```python
from aegis import Aegis

decision = Aegis().evaluate(
    proposal_summary="Add Redis caching layer to reduce API latency",
    risk_baseline=0.02, risk_proposed=0.05,
    novelty_score=0.75, complexity_score=0.8, quality_score=0.9,
)
print(decision.status)  # "proceed"
```

> The local stdio MCP server above ships in `aegis-governance` >= 1.3.0 via the `[mcp]` extra.

## Tools

| Tool | What it does |
|------|--------------|
| `aegis_evaluate_proposal` | Full six-gate evaluation of a proposal; returns PROCEED/PAUSE/HALT/ESCALATE with per-gate scores and rationale |
| `aegis_quick_risk_check` | Fast risk screen for a proposed change |
| `aegis_check_thresholds` | Current gate threshold configuration |
| `aegis_get_scoring_guide` | Domain-specific guidance for deriving gate parameters (e.g. `cicd`) |
| `aegis_record_proposal` | Record a proposal for later verification |
| `aegis_list_proposals` | List recorded proposals |
| `aegis_verify_proposals` | Verify recorded proposals against outcomes |
| `aegis_list_decisions` | List past governance decisions |
| `aegis_get_decision` | Fetch a specific decision with full audit detail |
| `aegis_crypto_status` | Hash-chain audit integrity status |

## Why a governance gate?

AI agents make thousands of decisions with no record of why. AEGIS gives every consequential action a quantitative evaluation and a tamper-evident audit entry — so "the agent decided to deploy" becomes a signed, replayable record with gate scores and rationale.

- **Six gates**: Risk, Profit, Novelty, Complexity, Quality, Utility — calibrated thresholds, KL-divergence drift detection
- **Audit-ready**: hash-chained decision log; NIST AI RMF and EU AI Act Annex IV artifact generation
- **Five integration surfaces**: MCP (this repo), Python SDK, REST API, CLI, GitHub Action

## Links

- **Docs**: [aegis.undercurrentholdings.com/docs](https://aegis.undercurrentholdings.com/docs) · [MCP tools reference](https://aegis.undercurrentholdings.com/docs/api/mcp-tools)
- **Try it in the browser** (no install): [AEGIS Advisor](https://aegis.undercurrentholdings.com/advisor)
- **Pricing**: [portal.undercurrentholdings.com/pricing](https://portal.undercurrentholdings.com/pricing) — free Community tier; paid tiers for teams and regulated environments
- **Source distribution**: [PyPI `aegis-governance`](https://pypi.org/project/aegis-governance/) (BSL-1.1)

---

Built by [Undercurrent](https://undercurrentholdings.com) — *Agency over agents.*
