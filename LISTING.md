# Listing Copy (for marketplace / community submission)

Copy the fields below into the relevant submission form, marketplace listing, or
pull-request description. All copy targets a global, English-speaking audience.

---

## 1. Basic info

- **Name:** Ethereum Wallet Manager
- **Skill name (technical):** `ethereum-wallet-api`
- **Category:** Developer Tools / Blockchain
- **Tags:** `ethereum`, `wallet`, `web3`, `evm`, `api`, `mcp`, `crypto`

## 2. One-line tagline

Fund-safe Ethereum wallet management for Claude Code — create wallets and read
balances, gas, addresses, and transactions, via your own self-hosted API.

## 3. Short description (≤160 chars)

Create Ethereum wallets, check balances, validate addresses, and query gas
prices through your own wallet-manager API. Fund transfers require separate
authorization and are disabled by default.

## 4. Long description

Ethereum Wallet Manager is a Claude Code skill that connects Claude to a
self-hosted Ethereum wallet-management API, so it can create wallets, read
balances, validate addresses, query gas prices, and list transactions — all
authenticated with a per-user `X-API-Key`.

It ships in two forms: a ready-to-run `curl` wrapper script, and a set of
MCP tools with no fund-transfer capability, so it works whether you prefer
plain HTTP calls or native Model Context Protocol integration.

**Security first.** The skill is read-only for funds by design. The
transfer endpoint exists in the backend but is not exposed through this skill;
enabling it requires separate authorization from the API operator. Each user
authenticates with their own API Key generated from the web console — no shared
credentials, no password login.

**How it works**

1. Deploy the Ethereum Wallet Manager backend (self-hosted).
2. Generate an API Key from the web console.
3. Install this skill and set `API_BASE_URL` + `API_KEY` — or point Claude Code
   at the `/mcp` endpoint with an `X-API-Key` header.

## 5. Feature bullets

- Create and manage Ethereum wallets
- Check wallet balances (read live from the chain)
- Validate Ethereum addresses
- Query current gas price
- List and inspect transaction history (paged)
- API Key authentication via the `X-API-Key` header
- MCP server (Streamable HTTP) at `/mcp` — no fund-transfer tools
- Fund transfers excluded by default

## 6. Who it's for

- Developers who already run (or want to run) a self-hosted Ethereum wallet
  backend and want AI-assisted balance/tx lookups.
- Teams that want to give Claude read-only visibility into wallets without
  granting the ability to move funds.

## 7. Installation (short)

```bash
export API_BASE_URL="https://your-server.example.com"
export API_KEY="your-api-key"
./scripts/wallet_api.sh list-wallets
```

## 8. Community listing entries

A single ready-to-paste one-liner:

- `ethereum-wallet-api` — Fund-safe Ethereum wallet management skill for Claude
  Code: create wallets, check balances, validate addresses, query gas, and list
  transactions via a self-hosted API. [GitHub](https://github.com/louischeung007/ethereum-wallet-api-skills)

Concrete PR targets (verify each repo's current contribution guide before
opening a PR — the ecosystem moves quickly):

| Repository | What to add | Notes |
| --- | --- | --- |
| `punkpeye/awesome-mcp-servers` | MCP server entry | Skill also ships a fund-safe MCP server (no fund-transfer tools) at `/mcp`; list under "Blockchain & Cryptocurrency". |
| `anthropics/skills` | Skill example/PR | Anthropic's official skills repo; follow its SKILL.md conventions. |
| `hesreallyhim/awesome-claude-code` | Resource entry | Well-known awesome list of Claude Code tools and skills. |
| `modelcontextprotocol/servers` | Server reference | If listing the MCP component separately. |

Suggested entry for awesome-mcp-servers:

- [Ethereum Wallet Manager](https://github.com/louischeung007/ethereum-wallet-api-skills) — Fund-safe Ethereum wallet MCP server (Streamable HTTP): create wallets, check balances, validate addresses, query gas prices, and list transactions. API-key authenticated.

## 9. Reviewer notes / FAQ

- **Requires** a self-hosted Ethereum Wallet Manager API and a user-generated
  API Key. There is no hosted/public endpoint bundled with this skill.
- **Read-only for funds.** No transfer/send capability is exposed.
- Address validation and gas-price queries are public; wallet/transaction
  queries require a valid API Key.
- MCP endpoint: `/mcp` (Streamable HTTP, stateless).