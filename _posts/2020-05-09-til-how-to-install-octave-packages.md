---
layout: post
title: "TIL how to install Octave packages"
date: 2020-05-09
categories: machine-learning
link: https://octave.org/doc/v4.2.2/Installing-and-Removing-Packages.html
---


```sh
pkg install -forge io
pkg install -forge statistics
```

I wanted to use the [Statistics package from Octave Forge](https://wiki.octave.org/Statistics_package) to [randomly select samples from my training set](https://octave.sourceforge.io/statistics/function/randsample.html) to test functions I was writing.

Installation proved to be a little tricky.

I tried the following:

* downloading the gzipped tarball to my local disk and installing the file
* installing directly from Octave Forge using the `-forge` flag
* restarting Octave and retrying installing from Octave Forge

I couldn't tell you why installing from Octave Forge didn't work the first time.
And, when it didn't work that first time, I went about my classwork without it just fine.
When I finished it though, I had to come back and try to figure it out.

[Octave Forge has some other interesting packages](https://octave.sourceforge.io/packages.php) like:

* [`data-smoothing`](https://octave.sourceforge.io/data-smoothing/index.html)
* [`database`](https://octave.sourceforge.io/database/index.html)
* [`dataframe`](https://octave.sourceforge.io/dataframe/index.html)
* [`queueing`](https://octave.sourceforge.io/queueing/index.html)
* [`parallel`](https://octave.sourceforge.io/parallel/index.html)

I probably won't invest a bunch of time learning this though.
I think the value is in the python version of these libraries.
