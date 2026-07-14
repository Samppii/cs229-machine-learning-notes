---
aliases:
  - cost function
  - cost functions
dateCreated: 2026-07-08 00:00:00
dateModified: 2026-07-08 00:00:00
tags: atom
title: Cost function
up:
  - "[[Linear regression]]"
units:
  - "[[CS229 Lecture 2]]"
---

# Cost function

## Summary

The **objective** $J(\theta)$ - a single number measuring how wrong the [[Hypothesis]] is across the whole training set. Minimizing it (via [[Gradient descent]]) is what "learning" means. For [[Linear regression]] the choice is **ordinary least squares** - the sum of squared errors:

$$J(\theta) = \frac{1}{2}\sum_{i=1}^{m}\left(h_\theta(x^{(i)}) - y^{(i)}\right)^2$$

- The $\tfrac{1}{2}$ is pure convention - it cancels the $2$ that drops out when you differentiate the square (see [[Gradient descent]]).
- **Squaring matters**: without it, positive and negative errors would cancel when summed, and a badly-wrong-in-both-directions fit could score $0$. See the [[Loss function]] ladder.
- Why *squared* error (not absolute value, not 4th power)? Justified next lecture via a Gaussian noise assumption + GLMs - it's not arbitrary.
