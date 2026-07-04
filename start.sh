#!/usr/bin/env bash
set -euo pipefail

PORT=${1:-3000}

echo "  Starting portfolio server on port $PORT..."
echo ""

# Check for node
if ! command -v node &> /dev/null; then
  echo "Error: Node.js is required. Install from https://nodejs.org"
  exit 1
fi

# Kill anything already on the port
if lsof -ti ":$PORT" &> /dev/null; then
  echo "  Port $PORT is busy — freeing it..."
  lsof -ti ":$PORT" | xargs kill -9 2>/dev/null || true
  sleep 1
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
PORT=$PORT exec node server.js
