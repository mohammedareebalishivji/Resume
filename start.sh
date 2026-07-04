#!/usr/bin/env bash
set -euo pipefail

echo "  Starting portfolio server..."
echo ""

# Check for node
if ! command -v node &> /dev/null; then
  echo "Error: Node.js is required. Install from https://nodejs.org"
  exit 1
fi

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
  echo "  Installing dependencies..."
  npm install
  echo ""
fi

# Build CSS from SCSS
if command -v npx &> /dev/null; then
  echo "  Building CSS..."
  npx sass scss/style.scss public/css/style.css --style compressed --no-source-map 2>/dev/null || true
fi

# Start server
exec node server.js
