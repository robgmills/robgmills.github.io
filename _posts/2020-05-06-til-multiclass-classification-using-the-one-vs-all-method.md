---
layout: post
title: "TIL Multiclass Classification using the One-vs-all method"
date: 2020-05-06
categories: machine-learning
link: https://utkuufuk.com/2018/06/03/one-vs-all-classification/
---

<img src="/images/2020/05/06/multiclass-classification.png" height="50%" width="50%" alt="Multiclass classification with three target classes plotted on x1 and x2 dimensions" />

Multiclass classification can be achieved by breaking the problem up into multiple binary classification problems.
This is called the _one-vs-all_ or _one-vs-rest_ method.
You try to predict the probability that each individual discrete case is the correct, "positive" case for your given inputs, treating the rest of the cases as one combined "negative" case.
Then pick the case that has the highest probablity.

The number of binary classification sub-problems you'd break your multiclass classification problem into depends on the number of cases you're trying to predict.
If you have 3 target cases, you'd solve for 3 different binary classification problems with positive cases for each of your three target cases.

I'm wondering how important choosing truly _discrete_ cases is in this type of problem.
For example, let's say I'm trying to predict the weather and have the cases: _Sunny_, _Cloudy_, _Rainy_, _Snowy_, and _Windy_.
As a Chicagoan, I know it can be both _Sunny_ and _Windy_.
It can also be both _Cloudy_ and _Snowy_.
I suspect that choosing the right target cases is as important as the math behind this type of prediction.
