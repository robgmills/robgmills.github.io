---
layout: post
title: "TIL Octave Function Handle"
date: 2020-05-08
categories: machine-learning
link: https://octave.org/doc/v4.2.2/Function-Handles.html
---

```
[optTheta, functionVal, exitFlag] = fminunc(@costFunction, initialTheta, options);
```

So, I learned today that Octave supports passing functions to another function as arguments.
This is particularly helpful to build resuable, extensible cost functions and theta-determining algorithms.
Simply prefix your function name with the _at sign_ in the list of arguments like so: `@costFunction`.

I think this makes it easier to translate what I learn to a more modern, performant language.
I'm looking forward to tranlating what I learn in this class to something like [TensorFlow](https://www.tensorflow.org/), [scikit-learn](https://scikit-learn.org/), or [Apache Spark MLlib](https://spark.apache.org/mllib/).
