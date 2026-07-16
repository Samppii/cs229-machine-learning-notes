---
aliases:
  - likelihood
  - likelihoods
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
units:
  - "[[CS229 Lecture 3]]"
---

# Likelihood

## Summary

The probability of the **observed data** viewed as a **function of the parameters** $\theta$. For an [[IID]] training set it is the product of the per-example densities:

$$L(\theta) = \prod_{i=1}^{m} p\left(y^{(i)} \mid x^{(i)}; \theta\right)$$

- It is the **product** precisely because the examples are IID (independent) - joint probability of independent events multiplies.
- **Likelihood vs probability:** same formula, opposite view. *Probability* holds $\theta$ fixed and lets the data vary; *likelihood* holds the **data fixed** and lets $\theta$ vary. Which is why we say "likelihood of the parameters" but "probability of the data".
- In practice you maximize its log, the [[Log-likelihood]], and the maximizer is the [[Maximum likelihood estimation]] estimate. For linear regression with a [[Gaussian distribution]] noise assumption, that maximizer is exactly the least-squares [[Cost function]] minimizer.
