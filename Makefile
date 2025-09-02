SHELL := /bin/bash

.PHONY: help setup serve build clean docker-serve

help:
	@echo "Targets: setup, serve, build, clean, docker-serve"

setup:
	bundle install

serve:
	bundle exec jekyll serve --livereload --drafts --future --incremental --baseurl ""

build:
	bundle exec jekyll build

clean:
	bundle exec jekyll clean

docker-serve:
	docker run --rm -it -p 4000:4000 -v "$(PWD)":/srv/jekyll jekyll/jekyll jekyll serve --livereload --drafts --future --incremental --baseurl ""

