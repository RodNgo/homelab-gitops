#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STACK=nextcloud
STACK_DIR="$REPO_ROOT/swarm/nextcloud"

echo "📁 Repo root: $REPO_ROOT"

echo "🔐 Decrypt secrets..."
sops --config /dev/null -d "$STACK_DIR/secrets.sops.yaml" > "$STACK_DIR/secrets.yaml"

echo "🔑 Update Docker secrets..."
docker secret rm ${STACK}_db_root_password 2>/dev/null || true
docker secret rm ${STACK}_db_user_password 2>/dev/null || true

yq '.db_root_password' "$STACK_DIR/secrets.yaml" | docker secret create ${STACK}_db_root_password -
yq '.db_user_password' "$STACK_DIR/secrets.yaml" | docker secret create ${STACK}_db_user_password -

echo "🚀 Deploy stack..."
docker stack deploy -c "$STACK_DIR/docker-stack.yml" $STACK

rm "$STACK_DIR/secrets.yaml"

echo "✅ Done"