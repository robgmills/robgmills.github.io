---
layout: post
title: "TIL the difference between KB and KiB"
date: 2020-05-30
categories: development
link: https://superuser.com/a/287513
---

I remember feeling disappointed when, Back in the day when I used to build my own computers, I'd plug in a brand new _100 GB_ hard drive and see in whatever disk tool I was using that it reported the size as _93.13 GiB_.
I always assumed it had to do with using 1000 vs 1024 as the base unit, but I never really dug in further than that - until now!

Everyone's used to the prefixes _kilo-_, _mega-_, _giga-_, _tera-_, and _peta-_.
These prefixes are the most common when talking about computer disk and memory, but are used for all metric system unit size notations - e.g. _kilogram_, _millimeter_, etc.
They're rooted in the _decimal_ base unit of 10 and are called [metric prefixes](https://en.wikipedia.org/wiki/Metric_prefix).

So what's _KiB_, _MiB_ and _GiB_?
These denote multiples of units indicating a multiplication by a power of 2.
This comes from the binary system of measurement, most common in computing.
And the [binary prefixes](https://en.wikipedia.org/wiki/Binary_prefix) written in full are actually _kibi-_, _mebi-_, _gibi-_, _tebi-_, and _pebi-_.  
