---
layout: post
title: "TIL about Multivariate Linear Regression"
date: 2020-04-28
categories: machine-learning
link: https://en.wikipedia.org/wiki/Polynomial_regression
---

\\[\ h_{\theta}(x) = {\theta}_0 + {\theta}_1 x_1 + {\theta}_2 x_2 + {\cdots} + {\theta}_n x_n \\]

Today, in Andrew Ng's _Machine Learning_, I learned about **multivariate linear regression** for quadratic, cubic, or square root hypotheses. 

Really multivariate linear regression is not much different than univariate linear regression.
Just like with a univariate linear hypothesis, you can use matrix multiplication to simplify the hypothesis.
The equation above can be rewritten after introducing a new synthetic feature \\(\x_0\\) that is always equal to \\(\ 1 \\):

\\[\ h_{\theta}(x) = {\theta}_0 x_0 + {\theta}_1 x_1 + {\theta}_2 x_2 + {\cdots} + {\theta}_n x_n \\]

That simplifies using a parameter vector of \\(\ \theta \\) values transposed and a feature vector of \\(\ x \): 

\\[\ h_{\theta}(x) = \begin{bmatrix}{\theta}_0 & {\theta}_1 & {\theta}_2 & {\cdots} & {\theta}_n \end{bmatrix}\begin{bmatrix} x_0 \\\ x_1 \\\ x_2 \\\ {\vdots} \\\ x_n \end{bmatrix}
\\]

\\[\ h_{\theta} = {\theta}^{\intercal} x \\]

You can also apply an expanded use of gradient descent for multiple variables to identify the optimal parameters by repeating the gradient descent algorithm until parameter convergence.

To make gradient descent more efficient, you can apply _feature scaling_ and _mean normalization_ to make the input feature value ranges more similar and have a mean value of approximately 0.
To apply feature scaling, divide the input value by the range (maximum minus minimum)  of all input values, represented by \\(\ s_i \\).
To apply mean normalization, subtract the average feature value, \\(\\mu_i\\) from the input feature value.

\\[\ x_i:=\frac{x_i - \mu_i}{s_i} \\]

Choosing an incorrect learning rate \\(\{\alpha}\\) can result in an inefficient (too small) or runaway (too large) learning iteration.
You can debug your learning rate by plotting the output of the cost function \\(\ J({\theta}) \\) over the number of learning iterations.

Alternatively, you can apply an _automatic convergence test_ to declare learning complete when \\(\ J({\theta}) \\) decreases by less than some set threshold \\(\ E \\) such as \\(\ 10^-3 \\).

Finally, a linear algebra hypothesis results in a straight line.
That line might not be a good _fit_ for your data.
You can change the behavior or curve of the hypethesis function by making it a quadratic, cubic, or square root function.
Quadratic hypotheses form a parabula.
Cubic hypothesis form a "squiggly line." (I don't know what the term is and I'm too tired to look it up.)
And square root hypotheses form a curve that approaches an asymptote (aka "levels off").

Maybe tomorrow I should learn how to either form complex KaTeX formulas or render graphs from equation examples to provide visuals for what I'm talking about...
