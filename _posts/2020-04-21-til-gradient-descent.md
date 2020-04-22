---
layout: post
title: "TIL Gradient Descent"
date: 2020-04-21
categories: machine-learning
link: https://www.coursera.org/learn/machine-learning/
---

Today I learned about a technique called _gradient descent_ that's used to determine optimum algorithm parameters for machine learning.

Gradient descent is a derivative of the cost function used to measure an algorithm's accuracy.
The larger the value of the cost function, the less accurate the algorithm.
Since the cost function itself can be plotted, we can calculate the tangent of the cost function to determine which direction the algorithm parameters should be adjusted in and how much they should be adjusted.
If the tangent has a positive slope, it moves in one direction.
If it has a negative slope, it moves in the other.
This can be calculated across many parameters.  

As the parameters of the algorithm are adjusted, they move closer to the local optima in decreasing increments because the cost (the output of the cost function) for those parameters will decrease.

The gradient descent is dependent on a new variable, _alpha_, which defines how big of a step to take when adjusting the parameters.
If the value for alpha (how big of a step to take when adjusting the parameters) is too large, it can miss (and cause divergence from) the local optima.
If it is too small, it can take too long to find the local optima.

However, if the initial parameters happen to be at a local optima, the slope of the tangent of the cost function will be 0, or completely horizontal, resulting in no change to the parameter values.

For some types of linear regression, the local optima is the global optima.
