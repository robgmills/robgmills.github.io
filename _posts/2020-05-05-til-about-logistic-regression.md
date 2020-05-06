---
layout: post
title: "TIL about Logistic Regression"
date: 2020-05-05
categories: machine-learning
link: https://en.wikipedia.org/wiki/Logistic_regression
---

\\[\ h_{\theta}(x) = \frac{1}{ 1 + e^{ -{\theta}^{\intercal}x } } \\]

_Logistic regression_ is a form of machine learning used to determine a discrete, non-continuous value.
Today, I started learning abaut _binary classification_ which has two cases - negative (0) and positive (1) - that your prediction can result in.
This is accomplished using a Sigmoid function; otherwise known as a logistic function - hence the name, logistic regression.

Examples include:

* flagging an email as _spam_ or _not spam_ 
* determining if a tumor is _benign_ or _malignant_
* determining if a series of application metrics is an _outage_ 

Like linear regression, logistic regression also has a cost function used to fit parameters to the algorithm based on training data:

\\[\ J({\theta}) = \frac{1}{m} \cdot -y^{\intercal}log(h) - (1 - y)^{\intercal} log(1-h) \\]

And since the cost function is convex, we can use a slightly modified version of gradient descent to learn the parameters:

\\[\ \theta := \theta - \frac{\alpha}{m}X^{\intercal}( \frac{1}{1 + e^{ -{\theta}^{\intercal}x }} - \overset{\rarr}{y}) \\]

There is a form of _multiclass classification_ in which the prediction has more than two cases, but I get to learn that tomorrow!
