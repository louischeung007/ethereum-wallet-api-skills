#!/usr/bin/env bash
# Ethereum Wallet Manager API convenience wrapper script
# See SKILL.md in the parent directory for usage.

set -euo pipefail

: "${API_BASE_URL:?Set the API_BASE_URL environment variable first}"
: "${API_KEY:?Set the API_KEY environment variable first}"

BASE="${API_BASE_URL%/}"
AUTH_HEADER="X-API-Key: ${API_KEY}"

# GET request with the auth header + JSON content type
json_get() {
  curl -s -H "$AUTH_HEADER" -H "Content-Type: application/json" "$@"
}

# List wallets
list-wallets() {
  json_get "${BASE}/api/wallet"
}

# Create wallet
create-wallet() {
  local name="${1:-}"
  [ -z "$name" ] && { echo "usage: create-wallet <name>"; exit 1; }
  json_get -X POST "${BASE}/api/wallet" \
    -d "{\"name\":\"${name}\",\"description\":\"\",\"remark\":\"\",\"category\":\"\"}"
}

# Wallet details
wallet-detail() {
  local id="${1:-}"; [ -z "$id" ] && { echo "usage: wallet-detail <id>"; exit 1; }
  json_get "${BASE}/api/wallet/${id}"
}

# Check balance
balance() {
  local id="${1:-}"; [ -z "$id" ] && { echo "usage: balance <id>"; exit 1; }
  json_get "${BASE}/api/wallet/${id}/balance"
}

# Validate address (public)
validate-address() {
  local addr="${1:-}"; [ -z "$addr" ] && { echo "usage: validate-address <address>"; exit 1; }
  curl -s "${BASE}/api/wallet/validate-address/${addr}"
}

# Current gas price (public)
gas() {
  curl -s "${BASE}/api/wallet/gas-price"
}

# Gas price options (public)
gas-options() {
  curl -s "${BASE}/api/transaction/gas-price-options"
}

# List transactions
list-transactions() {
  local page="${1:-1}"; local pageSize="${2:-10}"
  json_get "${BASE}/api/transaction?page=${page}&pageSize=${pageSize}"
}

# Transaction details
transaction-detail() {
  local id="${1:-}"; [ -z "$id" ] && { echo "usage: transaction-detail <id>"; exit 1; }
  json_get "${BASE}/api/transaction/${id}"
}

cmd="${1:-}"
shift || true
case "$cmd" in
  list-wallets) list-wallets "$@" ;;
  create-wallet) create-wallet "$@" ;;
  wallet-detail) wallet-detail "$@" ;;
  balance) balance "$@" ;;
  validate-address) validate-address "$@" ;;
  gas) gas "$@" ;;
  gas-options) gas-options "$@" ;;
  list-transactions) list-transactions "$@" ;;
  transaction-detail) transaction-detail "$@" ;;
  *) echo "unknown command: $cmd"; exit 1 ;;
esac