---
layout: post
title: "TIL how to add math typesetting to Github Pages with KaTeX"
date: 2020-04-25
categories: machine-learning
link: https://stackoverflow.com/a/57370526
---

Since I've started Andrew Ng's _Machine Learning_ on Coursera, I've found myself with a new need on this blog: the ability to elegantly render formulas.
This really showed in [my last post on the _identity matrix_](/machine-learning/2020/04/24/til-of-the-identity-matrix.html) when I had to hack through displaying a simple matrix using code blocks and space-aligned columns and rows of characters.
So, my quick win this morning is to find a way to work in LaTeX-like formula rendering for future blog posts and _this_ post is going to serve as my testing ground for adding this capability!

I chose [KaTex](https://katex.org/) for no particular reason.
I suppose I might have been influenced by the anecdotes and the Katex website claims of speed.
I didn't do any particular benchmarking though. 

Adding this in seemed easy enough based on some StackOverflow posts I saw.

I needed to update my Jekyll `_config.yml` to add a `math_engine` to the Kramdown Markdown engine:

```yaml
kramdown:
  math_engine: katex
```

(See the update below!)

And add some Jaascript and CSS to my Jekyll template:
```
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css" integrity="sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq" crossorigin="anonymous">

<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js" integrity="sha384-y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz" crossorigin="anonymous"></script>

<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous" onload="renderMathInElement(document.body);"></script>
```

KaTex recommended putting all of that in your `<head></head>` block, but I split them between there and the end of my HTML for page load speed reasons.

Now let's see if this works!

\\[\ LaTeX code \\]

Look at that!
[KaTeX supports a decent set of TeX functions](https://katex.org/docs/supported.html) to try.
And they keep an [alphabetically sorted and complete list of functions](https://katex.org/docs/support_table.html) to reference too.

I want to see if [my 4x4 identity matrix example from yesterday](/machine-learning/2020/04/24/til-of-the-identity-matrix.html) is any easier first...

\\[\ 
\begin{bmatrix}
   1 & 0 & 0 & 0 \\\
   0 & 1 & 0 & 0 \\\
   0 & 0 & 1 & 0 \\\
   0 & 0 & 0 & 1 \\\
\end{bmatrix}
\\]

I like that it's actually centered in the content where my example from yesterday wasn't as responsive.
Let me do a basic formula example using a linear algebra hypothesis from my class:

\\[\ h_{\theta}(x)={\theta}_1 {\times} {\theta}_0 x \\]

That one was a litle harder to get.
It also is messing with my vim syntax highlighting for Markdown files.
I'll save writing about fixing that for another day!

______
**UPDATE:** Immediately after merging this and pushing to Github, I checked the actual running version of this and it clearly didn't work.  [It turns out](https://karas.io/blog/math-support-with-katex-on-github-pages/), [Github doesn't support the KaTeX math engine in Kramdown - only MathJax.](https://help.github.com/en/github/working-with-github-pages/about-github-pages-and-jekyll#configuring-jekyll-in-your-github-pages-site).

To make my local development server run more like what actually happens in Github pages, I actually set the following in my `_config.yaml`:

```yaml
kramdown:
  math_engine: mathjax
```

It also means that I can't use the `$$\$` delimiters for math blocks and I have to use the following: 

* `\\[\` & `\\]` for block
* `\\(\` & `\\)` for inline

And I have to escape the leading `\` in TeX newlines (`\\`) - meaning, here's what I have to put in: `\\\`.

This isn't ideal, but let's see how it goes.
