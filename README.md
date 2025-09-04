## Lazygames

### Local Development

Run the site locally with Docker (recommended) or Jekyll.

Docker-first (recommended)
- No local Ruby required.
- Uses `jekyll/jekyll` image with `--rm` and current folder mounted as a volume.

Quick start (Docker)
1) From this folder: `make docker-serve` (or `make docker-serve-open`)
2) Open: http://localhost:4000

Common Docker tasks
- Serve: `make docker-serve` (live reload, drafts, future posts)
- Serve and auto-open: `make docker-serve-open`
- Build static site: `make docker-build`
- Clean cache/site: `make docker-clean`

Notes
- `--rm` removes the container when stopped; no leftover containers.
- Mounts current folder as volume so you edit files locally.

Local Ruby (optional)
- If you prefer local Ruby, use: `make serve`, `make build`, `make clean`

Makefile Shortcuts (from this folder)
- Serve: `make serve`
- Build: `make build`
- Clean: `make clean`
- Docker serve: `make docker-serve`

### Deployment

This repo deploys via GitHub Actions (`.github/workflows/pages.yml`).
Pushing to `main` or `master` triggers build + deploy to GitHub Pages.
