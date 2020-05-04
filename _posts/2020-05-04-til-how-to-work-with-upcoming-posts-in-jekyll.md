---
layout: post
title: "TIL how to work with upcoming posts in Jekyll"
date: 2020-05-04
categories: development
link: http://www.fizerkhan.com/blog/posts/Working-with-upcoming-posts-in-Jekyll.html
---

```sh
jekyll server --unpublished --future --drafts --watch --force_polling -H 0.0.0.0 -P 4000
```

I learned of a bunch of new options for running my development instance of the Jekyll static site generator.
These settings let me start to pre-write posts - which, now that I think about it, might kind of undermine the _today_ in _TIL_:

* `--unpublished` will show posts that have a metadata attribute of `published: false`
* `--future` will show posts that have a date in the future
* `--drafts` will show posts that are currently in the `_drafts/` directory
