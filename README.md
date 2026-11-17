[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/usertour-2?utm_medium=integration&utm_source=button&utm_campaign=usertour)

# Usertour on Railway

A Railway template for [Usertour](https://github.com/usertour/usertour), the open-source user onboarding platform (product tours, checklists, launchers, banners and surveys).

It deploys:

| Service | Source | State |
|---|---|---|
| **Usertour** | this repo's `Dockerfile`: the official `usertour/usertour:0.9.8` image, pinned by digest, plus a small start script | none (stateless) |
| **Postgres** | Railway's PostgreSQL | volume |
| **Redis** | Railway's Redis | volume |

Version: **Usertour 0.9.8** (`usertour/usertour:0.9.8@sha256:445e039d380d9eda3d72014f33f068a39df202787e246c2d9062396c325298a7`).

## Variables

Nothing to fill in. The template sets these on the Usertour service:

| Variable | Value |
|---|---|
| `PORT` | `8080` (nginx inside the container; the Node server stays on 3000) |
| `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` |
| `Redis_HOST`, `Redis_PORT`, `Redis_PASS` | references to the Redis service |
| `JWT_SECRET` | generated secret |
| `ENCRYPTION_KEY` | generated 64-character hex key (encrypts 2FA secrets; never change it after users enrol in 2FA) |
| `APP_HOMEPAGE_URL`, `API_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |

The start script (`railway-start.sh`) also sets `EMAIL_AUTH_ENABLED=true`, `USERTOUR_COOKIE_SECURE=true` and `DATABASE_DIRECT_URL=$DATABASE_URL` unless you set them yourself, and refuses to start without `JWT_SECRET` or `ENCRYPTION_KEY` (Usertour would otherwise fall back to insecure built-in defaults).

Optional features are configured by adding variables to the Usertour service, as described in the [Usertour environment variable docs](https://docs.usertour.io/open-source/env): email (`EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_USER`, `EMAIL_PASS`, `EMAIL_SENDER`), image uploads through any S3-compatible storage (`AWS_S3_*`), GitHub or Google sign-in, and AI translation (`AI_*`).

## After deploying

Open the public URL straight away: the first visitor is asked to create the first **System Admin** account. Do this before you share the URL.

## Updates

The Usertour service builds from this repository. When a new Usertour release is pinned here, Railway shows an "update available" notice on your project, and you choose when to apply it. Database migrations run automatically on start. Read [CHANGELOG.md](CHANGELOG.md) before you update: breaking changes are listed first.

## License

The wrapper files in this repo are MIT. Usertour itself is AGPL-3.0 (with an enterprise directory under its own license); see the [upstream repository](https://github.com/usertour/usertour).
