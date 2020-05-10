---
layout: post
title: "TIL about overfitting and feature regularization"
date: 2020-05-10
categories: machine-learning
link: https://towardsdatascience.com/regularization-an-important-concept-in-machine-learning-5891628907ea
---

![Two algorithms plotted: one that's overfitted and one that's had feature regularization applied (Source: Wikipedia)](/images/2020/05/10/regularization.svg)

Overfitting is when an algorithm is too "tuned" for the training data and won't make generally accurate predictions for variables not in the training set.
This seems to be visually identifiable when plotting the algorithm.
An algorithm that's overfit will look extra "squiggly" - and yes, that's the technical term.
This is particularly prevelant when there is a high number of features, particularly when some are higher-order polynomials.

_Feature regularization_ is used to prevent overfitting parameters \\(\ \theta \\) for an algorithm.
This method brings the decreases the values of the parameters closer to zero, which diminishes the impact the features have on the algorithm.
This results in a better fit and a "smoother" appearance when plotted.

Feature regularization is accomplished by extending the cost function and gradient calculation **for all \\(\ \theta \\) except \\(\ \theta_0 \\)** as follows:

\\[\ J(\theta) = \frac{1}{2m} [ \sum_{i=1}^{m} (h_{\theta}(x^{(i)}-y^{(i)})^2 + \lambda \sum_{j=1}^{n} \theta_{j}^2 ] \\]

\\[\ \theta_j = \theta_j (1 - \alpha \frac{\lambda}{m}) - \alpha \frac{1}{m} \sum_{i=1}^{m}(h_{\theta}(x^{(i)}) - y^{(i)}) x_{j}^{(i)} \\]
