---
layout: post
title: "TIL about neural networks"
date: 2020-05-12
categories: machine-learning
link: https://en.wikipedia.org/wiki/Artificial_neural_network
---

![A 4-layer neural network](/images/2020/05/12/neural-network.png)

_Neural networks_ were a lot easier to understand than I thought - at least those used for classification that I've learned about so far.
They're essentially a network of binary switches that outputs a final classification.
It reminds me of a multi-pole light switch set up.

These types of neural networks can be created to form any logical operations: _OR_, _AND_, _NOT AND (NAND)_, _EXCLUSIVE OR (XOR)_.

Each layer uses the same [_Sigmoid function_ from logistic regression classification]({% post_url 2020-05-05-til-about-logistic-regression %}).
Each target in the network represents an _activation function_ that takes the previous layer node outputs as inputs weighted by a separate matrix of parameters, \\(\ \Theta \\) (with a capital _T_).

Each layer also adds a bias node, \\( a_{0}^{(i)} = 1 \\) where \\(\ i \\) is the layer of the network.

The neural network is comprised of three **types** of layers: an _input layer_ comprised of your input variables, an _output layer_ comprised of your final activation function and which outputs the value of your hypothesis, and an unlimited number of _hidden layers_ between them.
