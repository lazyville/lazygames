source "https://rubygems.org"

# Core site tooling
gem "jekyll", "~> 4.3"
gem "webrick", "~> 1.8" # Needed for Ruby 3+ when serving locally

# Plugins used by this site
gem "jekyll-remote-theme", "~> 0.4.3"

group :jekyll_plugins do
  # Keep plugin gems in this group so `bundle exec jekyll` loads them
  gem "jekyll-remote-theme", "~> 0.4.3"
end

# To match the GitHub Actions build exactly, you can alternatively use:
# gem "github-pages", group: :jekyll_plugins
# ...but since the repo builds via actions/jekyll-build, Jekyll 4.x locally is fine.

