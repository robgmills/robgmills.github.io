---
layout: post
title: "TIL how to override a git-commit date"
date: 2020-05-15
categories: development
link: https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---dateltdategt
---

```sh
GIT_COMMITTER_DATE="Mon 11 May 2020 20:19:19 CDT" git commit --date "Mon 11 May 2020 20:19:19 CDT"
```

I forgot to commit and publish [my post on Monday, _TIL what thromb- means_]({% post_url 2020-05-11-til-what-thromb--means  %}).
So I cheated.

You can override or rewrite the date of your git commits.
[`git-scm` actually tracks two dates: one for when the change was _authored_ and another when the change was _committed_.](https://git-scm.com/docs/git-commit#_date_formats)
I overrode both when committing and publishing my change.

The important one, for my case, was the _author_ date.
That means supplying the `--date` option when executing the commit. 
By default, this value is pulled from system time.

To override the _committer_ date, one needs to set the `GIT_COMMITTTER_DATE` environment variable when executing the commit.
This value is also pulled from system time by default.

[Both settings accept either RFC 2822 or ISO 8601 formatted datetime strings.](https://git-scm.com/docs/git-commit#_date_formats)

And so, I kept my streak alive...sort of.
