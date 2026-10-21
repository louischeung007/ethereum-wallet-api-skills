# Ethereum Wallet Manager — Claude Skill

A fund-safe Ethereum wallet-management skill for Claude Code. It lets Claude create wallets, check balances, validate addresses, query gas prices, and list transactions through a remote wallet-manager API — authenticated with a user-provided `X-API-Key`.

Funds are safe by design: **sending/transferring funds is not exposed** by default and requires separate authorization.

## Features

- 7 REST operations and 7 MCP tools (no fund-transfer capability)
- API Key authentication (no email/password login)
- ETH balance, live gas price, address validation, transaction history
- Explicitly excludes fund transfers

## What's included

| File | Purpose |
| --- | --- |
| `SKILL.md` | Skill definition and usage instructions |
| `scripts/wallet_api.sh` | Ready-to-run `curl` wrapper script |
| `openapi.yaml` | OpenAPI 3.0 specification of the API |
| `README.md` | This document |

## Prerequisites

1. A running **Ethereum Wallet Manager API** (self-hosted) with a user account.
2. An API Key generated from the web console (requires the `wallet` / `transaction` permission scopes).

## Install as a Claude Code skill

Copy the skill folder into your Claude skills directory:

```bash
cp -r ethereum-wallet-api ~/.claude/skills/
```

Or add it to a project as `.claude/skills/ethereum-wallet-api/`.

Then set your connection info:

```bash
export API_BASE_URL="https://your-server.example.com"
export API_KEY="your-api-key"
```

## REST quick start

```bash
./scripts/wallet_api.sh list-wallets
./scripts/wallet_api.sh create-wallet "My Wallet"
./scripts/wallet_api.sh balance <wallet-id>
./scripts/wallet_api.sh gas
```

## MCP tools

The backend also exposes an MCP server at `/mcp` (Streamable HTTP, stateless) with no fund-transfer capability.

| Tool | Auth |
| --- | --- |
| `create_wallet` | API Key |
| `list_wallets` | API Key |
| `get_balance` | API Key |
| `validate_address` | public |
| `gas_price` | public |
| `list_transactions` | API Key |
| `get_transaction` | API Key |

### Connect from Claude Code

```json
{
  "mcpServers": {
    "ethereum-wallet": {
      "type": "http",
      "url": "https://your-server.example.com/mcp",
      "headers": {
        "X-API-Key": "your-api-key"
      }
    }
  }
}
```

> **Auth note:** The MCP transport is stateless, so the `X-API-Key` header must be sent on every request. Claude Code and Claude Desktop honor the `headers` field above. Clients without custom-header support (some Cursor versions) can still call the public tools (`validate_address`, `gas_price`); the authenticated tools require a client that sends headers.

## Security

- The API Key is passed via the `X-API-Key` header and must never be committed to source control.
- Fund transfers (`POST /api/transaction/transfer`) are implemented but disabled by default; contact the operator to enable them.
- Address validation and gas-price queries are public endpoints.

## License

[Apache License 2.0](LICENSE)