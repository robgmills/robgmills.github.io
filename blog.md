---
layout: default
title: Blog
permalink: /blog/
---

{% for post in site.posts %}
<article>
  <h1><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></h1>
  <!--p class="post-meta">{{ post.date | date: "%b %-d, %Y" }}{% if post.meta %} • {{ post.meta }}{% endif %}</p-->
  {{ post.content }}
  <hr />
</article>
{% endfor %}


{% include footer.html %}