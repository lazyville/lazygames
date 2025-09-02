## Lazygames

### Local Development

Run the site locally with Jekyll for quick iteration.

Prerequisites
- Ruby (2.7+ recommended; 3.x works)
- Bundler (`gem install bundler`)
- Alternatively: Docker (no Ruby required)

Setup
1) Install gems

```
bundle install
```

2) Serve locally (with live reload, drafts, future posts)

```
bundle exec jekyll serve --livereload --drafts --future --incremental --baseurl ""
```

Open: http://localhost:4000

Notes
- `--baseurl ""` ensures links work locally despite `_config.yml` using `/lazygames` for GitHub Pages.
- The site uses the remote theme `pages-themes/cayman`; the first run may fetch it.

Docker Option
If you prefer not to install Ruby locally, use the official Jekyll image:

```
docker run --rm -it \
  -p 4000:4000 \
  -v "$PWD":/srv/jekyll \
  jekyll/jekyll \
  jekyll serve --livereload --drafts --future --incremental --baseurl ""
```

Common Tasks
- Build only: `bundle exec jekyll build`
- Clean cache/site: `bundle exec jekyll clean`

### Deployment

This repo deploys via GitHub Actions (`.github/workflows/pages.yml`).
Pushing to `main` or `master` triggers build + deploy to GitHub Pages.
