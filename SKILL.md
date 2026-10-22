---
name: ethereum-wallet-api
description: Manage Ethereum wallets via the Ethereum Wallet Manager HTTP API — create wallets, check balances, validate addresses, query gas prices, and list transactions. Authenticates with the X-API-Key header. Use this skill whenever the user wants to manage Ethereum wallets through the API.
---

# Ethereum Wallet Manager API

Manage Ethereum wallets over a simple HTTP API. Authentication uses the `X-API-Key` request header (no email/password login required).

## Prerequisites

1. Sign in to the web console and generate an API Key from your account dashboard (requires the `wallet` / `transaction` permission scopes).
2. Install `curl` and `jq` on your machine.
3. Set environment variables:

```bash
export API_BASE_URL="https://mcp.69.72.80.230.sslip.io"
export API_KEY="your-api-key"
```

## Available operations

| Operation | Method | Path |
| --- | --- | --- |
| Create wallet | POST | /api/wallet |
| List wallets | GET | /api/wallet |
| Wallet details | GET | /api/wallet/{id} |
| Check balance | GET | /api/wallet/{id}/balance |
| Validate address | GET | /api/wallet/validate-address/{address} |
| Gas price | GET | /api/wallet/gas-price |
| List transactions | GET | /api/transaction?page=&pageSize= |
| Transaction details | GET | /api/transaction/{id} |
| Gas price options | GET | /api/transaction/gas-price-options |

## Quick-start script

Call the bundled `scripts/wallet_api.sh` directly, for example:

```bash
./scripts/wallet_api.sh list-wallets
./scripts/wallet_api.sh create-wallet "My Wallet"
./scripts/wallet_api.sh balance <wallet-id>
./scripts/wallet_api.sh gas
```

## MCP tools

The same backend also exposes a Model Context Protocol (MCP) server at `/mcp` (Streamable HTTP, stateless) with no fund-transfer tools. AI agents can call these tools directly instead of using curl. The transfer operation is intentionally not exposed as an MCP tool.

| Tool | Parameters | Auth |
| --- | --- | --- |
| `create_wallet` | `name` (required), `description`, `remark`, `category` | API Key |
| `list_wallets` | — | API Key |
| `get_balance` | `walletId` (GUID) | API Key |
| `validate_address` | `address` | public |
| `gas_price` | — | public |
| `list_transactions` | `page`, `pageSize` | API Key |
| `get_transaction` | `transactionId` (GUID) | API Key |

### Connect from Claude Code

```json
{
  "mcpServers": {
    "ethereum-wallet": {
      "type": "http",
      "url": "https://mcp.69.72.80.230.sslip.io/mcp",
      "headers": {
        "X-API-Key": "your-api-key"
      }
    }
  }
}
```

> **Auth note:** The MCP transport is stateless, so the `X-API-Key` header must be sent on every request. Claude Code and Claude Desktop honor the `headers` field above. Clients without custom-header support (some Cursor versions) can still call the public tools (`validate_address`, `gas_price`); the authenticated tools require a client that sends headers.

## Initiate a transfer (requires separate authorization)

The transfer endpoint `POST /api/transaction/transfer` is implemented, but for fund-safety reasons it is not enabled by default — contact the service provider to request access. It is intentionally not included in this skill's default script.

## Security notes

- Never hardcode the API Key in code or commit it to a repository; keep it in an environment variable.
- Address validation and gas-price queries are public endpoints and do not require an API Key.