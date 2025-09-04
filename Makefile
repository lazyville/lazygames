SHELL := /bin/bash

.PHONY: serve build clean docker-serve docker-serve-open docker-build docker-clean

# Docker-first workflow (preferred)
docker-serve:
	docker run --rm \
	  -p 4000:4000 -p 35729:35729 \
	  -e PAGES_REPO_NWO=lazyville/lazygames \
	  -v "$(PWD)":/srv/jekyll \
	  jekyll/jekyll \
	  jekyll serve --livereload --drafts --future --config _config.yml,_config.local.yml

docker-serve-open:
	@echo "[site] Serving via Docker and will open browser when ready..."
	@(
	  (
	    for i in $$(seq 1 120); do \
	      if command -v curl >/dev/null 2>&1; then \
	        curl -fsS "http://localhost:4000" >/dev/null 2>&1 && { open "http://localhost:4000" 2>/dev/null || xdg-open "http://localhost:4000" 2>/dev/null || true; break; }; \
	      elif command -v nc >/dev/null 2>&1; then \
	        nc -z localhost 4000 >/dev/null 2>&1 && { open "http://localhost:4000" 2>/dev/null || xdg-open "http://localhost:4000" 2>/dev/null || true; break; }; \
	      fi; \
	      sleep 1; \
	    done \
	  ) & \
	  docker run --rm \
	    -p 4000:4000 -p 35729:35729 \
	    -e PAGES_REPO_NWO=lazyville/lazygames \
	    -v "$(PWD)":/srv/jekyll \
	    jekyll/jekyll \
	    jekyll serve --livereload --drafts --future --config _config.yml,_config.local.yml \
	)

docker-build:
	docker run --rm \
	  -e PAGES_REPO_NWO=lazyville/lazygames \
	  -v "$(PWD)":/srv/jekyll \
	  jekyll/jekyll \
	  jekyll build --config _config.yml,_config.local.yml --destination ./_site

docker-clean:
	docker run --rm \
	  -e PAGES_REPO_NWO=lazyville/lazygames \
	  -v "$(PWD)":/srv/jekyll \
	  jekyll/jekyll \
	  jekyll clean || true
	rm -rf _site

# Fallback (local Ruby) if you prefer
serve:
	bundle install
	bundle exec jekyll serve --livereload --drafts --future --incremental --baseurl ""

build:
	bundle install
	bundle exec jekyll build --baseurl "" --destination ./_site

clean:
	bundle exec jekyll clean || true
	rm -rf _site
