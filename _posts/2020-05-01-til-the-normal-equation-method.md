---
layout: post
title: "TIL the normal equation method"
date: 2020-05-01
categories: machine-learning
link: https://www.geeksforgeeks.org/ml-normal-equation-in-linear-regression/
---

\\[\ {\theta} = (X^{\intercal} X)^{-1} (X^{\intercal} y) \\]

The **normal equation** is another function you can use to derive the optimal parameters \\(\ {\theta} \\) for your hypothesis as defined by your cost function.
This is an alternative method to [_gradient descent_ that I learned about a few days ago]({% post_url 2020-04-21-til-gradient-descent %}).

The normal equation method has a number of advantages over gradient descent: 

* It's faster than gradient descent because you can solve for theta in one calculation rather than iterating
* Because it solves for \\(\ {\theta} \\) in one iteration, it doesn't require [_feature scaling_ or _mean normalization_]({% post_url 2020-04-28-til-about-multivariate-linear-regression %}) to make iterations efficient
* Ditto for needing to use a learning rate \\(\ {\alpha} \\) (and potentially getting it wrong)

But it has two big downsides: 

First, it's slower than gradient descrent when the number of features is high - `n >= 10,000`.  That's because inverting an `10,000 x 10,000` matrix is computationally expensive!

Second, sometimes \\(\ X^{\intercal} X \\) is non-invertible! 
This usually happens for one of two reasons:

0. You have redundant features that are linearly dependent (e.g. \\(\ x_1 \\) = size in feet^2, \\(\ x_2 \\) = size in m^2 )
0. You have too many features and, in particular, the size of your training set is less than or equal to the number of features you're trying to use - \\(\ m {\leq} n \\)

In both cases, delete some features to make the matrix invertible!
