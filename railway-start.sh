#!/bin/sh
# Railway wrapper for the official Usertour image: fixed defaults that the
# template doesn't need to expose as variables, then the upstream start script.
set -e

# nginx (the public entry point) listens on PORT; the Nest server stays on 3000.
export PORT="${PORT:-8080}"
export NEST_SERVER_PORT="${NEST_SERVER_PORT:-3000}"

# Email + password sign-in is the only provider that needs no extra setup.
export EMAIL_AUTH_ENABLED="${EMAIL_AUTH_ENABLED:-true}"
# Railway serves every domain over HTTPS, so session cookies can be Secure.
export USERTOUR_COOKIE_SECURE="${USERTOUR_COOKIE_SECURE:-true}"

# Without DATABASE_DIRECT_URL, Prisma migrations use the same connection.
export DATABASE_DIRECT_URL="${DATABASE_DIRECT_URL:-$DATABASE_URL}"

if [ -z "$ENCRYPTION_KEY" ]; then
  echo "ERROR: ENCRYPTION_KEY is not set. Usertour would fall back to an insecure all-zero key." >&2
  echo "Set it to 64 hex characters (openssl rand -hex 32)." >&2
  exit 1
fi
if [ -z "$JWT_SECRET" ]; then
  echo "ERROR: JWT_SECRET is not set. Usertour would sign sessions with the default 'test' secret." >&2
  exit 1
fi

exec /app/scripts/start.sh
