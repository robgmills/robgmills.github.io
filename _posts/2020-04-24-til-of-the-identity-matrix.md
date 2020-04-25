---
layout: post
title: "TIL of the Identity Matrix"
date: 2020-04-24
categories: machine-learning
link: https://en.wikipedia.org/wiki/Identity_matrix
---

Today I learned of the _identity matrix_ in Andrew Ng's _Machine Learning_ class on Coursera!
Identity matrices are a class of matrix that have special properties:

* they are square - meaning, they're always `n x n` where `n` is both the count of rows and the count of columns (e.g. 1x1, 2x2, 3x3)
* they have all `1`s across the diagonal of the matrix
* they have all `0`s everywhere else

For example:

```
1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1
```

(I need to figure out if Github Pages supports LaTeX or other math syntax!)

When multiplied against other matrices, they act in the same way as multiplying a number (`z`) times `1`:

```
z * 1 = 1 * z = z
```

Substituting our matrix:

```
A * I = I * A = A
```

This does not mean the multiplication is commutative.
If `A = R^3x2` that means, depending on matrix order, `I = R^2x2` or `I = R^3x3`.
