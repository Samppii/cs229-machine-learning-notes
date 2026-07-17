---
aliases:
  - newton's method
  - newtons method
  - newton's methods
dateCreated: 2026-07-17 00:00:00
dateModified: 2026-07-17 00:00:00
tags: atom
units:
  - "[[CS229 Lecture 3]]"
title: Newton's method
---

# Newton's method

## Summary

A fast iterative optimizer. Where [[Gradient ascent]] takes many small ("baby") steps, Newton's method takes big tangent-line jumps and often converges in ~10 iterations.

**What it does:** finds where a function $f(\theta) = 0$. To **maximize** the [[Log-likelihood]] $\ell$, set $f = \ell'$ and find where $\ell'(\theta) = 0$. Each step takes the tangent at the current point and jumps to where it crosses the axis:

$$\theta^{t+1} := \theta^t - \frac{f(\theta^t)}{f'(\theta^t)} \quad\xrightarrow{\; f = \ell' \;}\quad \theta^{t+1} := \theta^t - \frac{\ell'(\theta^t)}{\ell''(\theta^t)}$$

**Vector version** ($\theta \in \mathbb{R}^{n+1}$): the second derivative becomes the [[Hessian]] $H$ (from [[CS229 PS0 - Solutions]]), and $\nabla_\theta \ell$ is the gradient:

$$\theta^{t+1} := \theta^t + H^{-1}\nabla_\theta \ell(\theta)$$

**Tradeoff:** [[Quadratic convergence]] means very few iterations, but each one must compute and **invert** the $n \times n$ Hessian - expensive for many parameters. Rule of thumb: use Newton's method for **few** parameters (~10-50); use [[Gradient descent]] / [[Gradient ascent]] for **many** (thousands+).
