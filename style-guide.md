---
layout: page
title: Page/Post Title
permalink: /style-guide/
---

This page is used to lay out all know page elements to make it apparent the style consistency.
Since this uses the `gh-pages` flavor of markdown rendered to HTML via jekyll, most of the [standard markdown syntax](https://daringfireball.net/projects/markdown/syntax) applies.

Paragraphs are pretty simple.
Just add an extra line break between them.
No extra line breaks are treated like a non-breaking whitespace character (aka "a space").
I prefer the more [`asciidoc`-style format](https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/) of one sentence per line and not breaking the line until sentence end.

I'm going to lead off with `pre-formatted <span></span>` since I need to use them to explain things as we go.
Simply wrap the span of text you'd like to be pre-formatted in backticks (\`).
And, as a tip since I just had to figure it out for the previous sentence, [to escape backticks and get them to render](https://meta.stackexchange.com/questions/55437/how-can-the-backtick-character-be-included-in-code), you can either use a backslash (\\) or add an extra backtick to the open and close of the span and pad the contents with a space in code spans (`` ` ``)!

_Italics_ are supported by wrapping characters in underscores (`_this is italicised_`) or asterisks (`*as is this*`).

**Boldening** is achieved by doubling up the wrapping symbols.
This works with both underscores (`__EMPHASIS!!!!__`) or asterisks (`**WHY ARE WE YELLING?!**`).
But please don't mix wrapping characters.

Lists are easy as well by prepending lines with a hyphen (`-`) followed by a space for unordered lists:

- First top-level item
- Second top-level item

Or a `0.` followed by a space for ordered lists:

0. First top-level item
0. Second top-level item

To nest items in a list, pad the line with four spaces but use the same list syntax:

- First top-level item
    - First child item
    - Second child item
- Second top-level item

And, of course, this works for ordered lists as well:

0. First top-level item
    0. First child item
    0. Second child item
0. Second top-level item

One can add links in-line by wrapping the link text in [square brackets] followed by a the uniform resource identifier, _URI_, in (parentheses).
For example, `[link text](https://robgmills.com)` will render as [link text](https://robgmills.com).

Alternatively, there are two types of reference-style links supported.
Reference-style links still wrap the link text in square brackets, but follow the link text with another pair of square brackets.
They work by looking up the link that is defined elsewhere in the document.
As convention, I prefer to put them in a big block at the end.

```
[]: /first-reference-link
[]: https://robgmills.com/second-reference-link
[link-name]: /named-reference-link
```

The links are then looked up or referenced when the document is compiled to HTML.
Reference-style links can be unnamed (`[link text][]`) or named (`[link text][link-name]`).
Unnamed reference links are matched by order.
The first unnamed reference link in the document references the first defined link found in the document.
The second link then uses the next defined link, and so on.
Named reference links find the defined links by name.  

Embedding various forms of multimedia is also supported.

Images are the most popular form of embeds.
They work very similar to links.
The only differences are that the sequence must be prepended by an exclamation point (`!`) and the text in the square brackets is the image alternative text.
For example, the sequence `![img alt text](/images/waldo.jpg)` will render as 

![img alt text](/images/waldo.jpg)

Reference URIs will also work for embedded images.

# Headers are prepended by a octothorpe/hash/hashtag/pound/number symbol.
## The number of octothorpes determines the number character in the header tag.
### For example, three octothorpes results in an `<h3></h3>` tag.
#### I totally forget how many header levels I've defined, but if I have to go much beyond four, I should probably break things out into smaller posts.

Code blocks are rendered by opening and closing the block with three backticks (`` ` ``).

```
echo "Hello world! I'm $(whoami)" > /dev/null
```

Code blocks also support syntax highlighting by postfixing the syntax code at the end of the opening series of backticks.

```sh
echo "Hello world! I'm $(whoami)" > /dev/null
```

Supported languages/formats include:

- POSIX Shell (`sh`) 
- Java (`java`)
- Javascript (`javascript` or `js`)
- HTML (`html`)
- XML (`xml`)
