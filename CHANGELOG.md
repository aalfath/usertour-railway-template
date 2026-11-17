# Changelog

## 0.9.8 (2026-11-17)

First release of this template.

- Usertour 0.9.8, official image `usertour/usertour:0.9.8@sha256:445e039d380d9eda3d72014f33f068a39df202787e246c2d9062396c325298a7`.
- Railway PostgreSQL and Redis, both on volumes.
- Generated `JWT_SECRET` and `ENCRYPTION_KEY`; the start script refuses to boot without them.
- Health check on `/api/health/ready` (database and Redis reachable).
