---
aliases:
  - maximum likelihood estimation
  - maximum likelihood estimations
  - MLE
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
up:
  - "[[Likelihood]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Maximum likelihood estimation

## Summary

Choose the parameters $\theta$ that make the **observed data most probable** - i.e. maximize the [[Likelihood]] $L(\theta)$ (in practice the [[Log-likelihood]] $\ell(\theta)$, which has the same maximizer):

$$\hat\theta = \arg\max_\theta \; \ell(\theta)$$

**The MLE recipe (reusable all quarter):**

1. **Assume** a model $p(y \mid x; \theta)$ for how the data is generated.
2. **Write** the likelihood $L(\theta) = \prod_i p(y^{(i)} \mid x^{(i)}; \theta)$ (product because [[IID]]).
3. **Maximize** it - take the log, then optimize (set derivative to 0, or run gradient ascent).

**Payoff in [[CS229 Lecture 3]]:** under a [[Gaussian distribution]] noise assumption, MLE for [[Linear regression]] reduces exactly to **minimizing squared error** - the least-squares [[Cost function]] is the maximum-likelihood estimator, not an arbitrary choice. The very same recipe, applied to a Bernoulli model, produces logistic regression (Arc 3, still to come).
