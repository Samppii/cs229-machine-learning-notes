---
aliases:
  - exponential family
  - exponential families
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: atom
title: Exponential family
units:
  - "[[CS229 Lecture 4]]"
---

# Exponential family

## Summary

A class of probability distributions whose density (or mass function, if discrete) can be written in one common template:

$$p(y; \eta) = b(y)\exp\left(\eta^T T(y) - a(\eta)\right)$$

| piece | name | constraint |
|---|---|---|
| $y$ | the data | modelled as the **output**; no $x$ appears anywhere in the template |
| $\eta$ | [[Natural parameter]] | the knob; scalar for everything in CS229 |
| $T(y)$ | sufficient statistic | $T(y) = y$ for every distribution in this course |
| $b(y)$ | base measure | function of $y$ **only** - cannot contain $\eta$ |
| $a(\eta)$ | [[Log partition function]] | function of $\eta$ **only** - cannot contain $y$ |

$\eta^T T(y)$ is a dot product, so $\eta$ and $T(y)$ must have matching dimension; $b(y)$ and $a(\eta)$ are scalars.

**It is a template.** Different choices of $b$, $T$, $a$ give different *families* ([[Gaussian distribution|Gaussian]], [[Bernoulli distribution|Bernoulli]], [[Poisson distribution|Poisson]], [[Multinomial distribution|multinomial]]); different values of $\eta$ give different *members* of a chosen family. Not every distribution fits - the Cauchy does not. Fitting is a real structural property, and it is what buys the two guarantees below.

**Proving membership.** Write the density in its familiar (canonical-parameter) form, massage it algebraically until it matches the template, then **pattern match** and read off the four pieces. Two opening moves:

| starting density looks like | opening move | why |
|---|---|---|
| products and powers, no exp (Bernoulli, Poisson) | wrap in $\exp(\log(\cdot))$ | the log flattens powers into multipliers |
| already contains an exp (Gaussian) | expand inside, split via $e^{A+B} = e^A e^B$ | untangles $y$ from the parameter |

Sorting rule throughout: **terms involving only $y$ go to $b(y)$; terms involving the parameter stay in the exponent.**

**The two properties.**

1. **[[Maximum likelihood estimation|MLE]] with respect to $\eta$ is concave** - equivalently the negative log-likelihood is convex. One global optimum, no local optima, for *every* member of the family ([[Convexity]] for free, no per-algorithm check).
2. **Moments are derivatives of the log partition function:** $E[y; \eta] = a'(\eta)$ and $\text{Var}(y; \eta) = a''(\eta)$. Computing moments normally requires an integral; here it is a derivative.

Property 1 follows from property 2: $a''(\eta) = \text{Var}(y) \geq 0$, and a non-negative second derivative means convex. The convexity guarantee for every [[Generalized linear models|GLM]] rests on "variance cannot be negative". Both are proved in PS1 Problem 4.

(The *exponential family* and the *exponential distribution* are different things; the latter is one member of the former.)
