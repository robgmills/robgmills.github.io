---
layout: post
title: "TIL a better way to link Jekyll posts"
date: 2020-05-02
categories: development
link: https://jekyllrb.com/docs/liquid/tags/#linking-to-posts
---
```
{{ "{% post_url 2020-04-25-til-how-to-add-math-typesetting-to-github-pages-with-katex " }}%}
```

This is a much better way of linking to posts from other posts or pages in [Jekyll](https://jekyllrb.com/) site.
It will preserve the link even if my URL structure changes due to change in my template or something.

I can't believe it took me this long to find this, but looking through my posts, the only place I might have been able to use it is in [_TIL how to add math typesetting to Github Pages with KaTeX_]({% post_url 2020-04-25-til-how-to-add-math-typesetting-to-github-pages-with-katex %}).
