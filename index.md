---
layout: default
title: Home
---

# Posts

<style>
/* Light, scoped styling for the index only */
.post-list { list-style: none; padding-left: 0; }
.post-item { margin: 0 0 1.25rem 0; }
.post-title { font-weight: 600; }
.post-date { color: #6a737d; font-size: 0.9em; }
.post-excerpt { margin: 0.25rem 0 0 0; color: #24292e; }
</style>

{% if site.posts and site.posts != empty %}
<ul class="post-list">
{% for post in site.posts %}
  <li class="post-item">
    <div class="post-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <span class="post-date">— {{ post.date | date: "%Y-%m-%d" }}</span></div>
    <p class="post-excerpt">{{ post.excerpt | strip_html | normalize_whitespace | truncate: 180 }}</p>
  </li>
{% endfor %}
</ul>
{% else %}
<p>No posts yet.</p>
{% endif %}
