---
layout: default
title: Lazygames
---

<style>
/* Scoped styling for the homepage only (Cayman-friendly) */

.section-title { margin: 0 0 0.75rem 0; }
.grid { display: grid; grid-template-columns: repeat(1, 1fr); gap: 1rem; }
@media (min-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); } }
@media (min-width: 960px) { .grid { grid-template-columns: repeat(3, 1fr); } }

.card { background: #fff; border: 1px solid #e1e4e8; border-radius: 6px; overflow: hidden; display: flex; flex-direction: column; transition: transform 120ms ease, box-shadow 120ms ease; }
.card:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(0,0,0,0.08); }
.card-header { padding: 0.9rem 1rem 0.25rem 1rem; }
.card-title { margin: 0; font-weight: 700; font-size: 1.05rem; }
.card-meta { color: #6a737d; font-size: 0.9em; margin: 0.1rem 0 0.5rem 0; }
.card-body { padding: 0 1rem 1rem 1rem; color: #24292e; }
.card-footer { margin-top: auto; padding: 0.75rem 1rem; background: #f6f8fa; border-top: 1px solid #e1e4e8; display: flex; align-items: center; justify-content: space-between; gap: 0.5rem; flex-wrap: wrap; }
.card-link { text-decoration: none; color: #155799; font-weight: 600; }
/* Tag chips to match post page */
.tags { display: inline; }
.tag { display:inline-block;background:#f1f8ff;border:1px solid #e1e4e8;color:#0366d6;border-radius:999px;padding:0.15rem 0.55rem;margin:0 0.25rem 0.25rem 0;font-size:0.85em; }

.archive {
  margin-top: 2rem; padding-top: 1rem; border-top: 1px dashed #e1e4e8;
}
.archive ul { list-style: none; padding-left: 0; margin: 0; }
.archive li { margin: 0.35rem 0; }
.archive a { color: #0366d6; }
</style>

<!-- Home subtitle moved back into header hero via header.html; remove external copy. -->

{% assign posts = site.posts %}
{% if posts and posts != empty %}
  <h2 class="section-title" id="latest">Latest Concepts
    <a href="{{ '/feed.xml' | relative_url }}" type="application/rss+xml" aria-label="Subscribe to RSS" style="margin-left:8px;display:inline-flex;align-items:center;gap:6px;text-decoration:none;vertical-align:middle">
      <svg style="width:14px;height:14px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
        <circle cx="6.18" cy="17.82" r="2.18" fill="#f26522"/>
        <path d="M4 11a9 9 0 0 1 9 9h3A12 12 0 0 0 4 8v3z" fill="#f26522"/>
        <path d="M4 6c9.39 0 17 7.61 17 17h3C24 11.85 12.15 0 4 0v6z" fill="#f26522"/>
      </svg>
      RSS
    </a>
  </h2>
  <div class="grid">
    {% for post in posts limit:6 %}
    <article class="card">
      <div class="card-header">
        <h3 class="card-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p class="card-meta">{{ post.date | date: "%Y-%m-%d" }}</p>
      </div>
      <div class="card-body">
        <p>{{ post.excerpt | strip_html | normalize_whitespace | truncate: 160 }}</p>
      </div>
      <div class="card-footer">
        {% assign tags = post.tags %}
        {% if tags == nil or tags == empty %}
          {% assign tags = post.categories %}
        {% endif %}
        <div>
        {% if tags and tags != empty %}
          <span class="tags">
            {% for tag in tags limit:5 %}
              <span class="tag">{{ tag }}</span>
            {% endfor %}
          </span>
        {% endif %}
        </div>
        <a class="card-link" href="{{ post.url | relative_url }}">Read concept →</a>
      </div>
    </article>
    {% endfor %}
  </div>

  {% if posts.size > 6 %}
  <div class="archive">
    <h3>All Posts</h3>
    <ul>
    {% for post in posts offset:6 %}
      <li> <a href="{{ post.url | relative_url }}">{{ post.title }}</a> · <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span> </li>
    {% endfor %}
    </ul>
  </div>
  {% endif %}
{% else %}
  <p>No posts yet.</p>
{% endif %}

{% include rss-footer.html %}
