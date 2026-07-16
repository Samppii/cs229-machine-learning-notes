---
aliases:
  - log-likelihood
  - log-likelihoods
  - log likelihood
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
up:
  - "[[Likelihood]]"
units:
  - "[[CS229 Lecture 3]]"
---

# Log-likelihood

## Summary

The natural log of the [[Likelihood]], $\ell(\theta) = \log L(\theta)$. Maximizing it is equivalent to maximizing $L$ (log is monotonic, so it has the **same maximizer**), but it is far easier to work with because **log turns the product into a sum**:

$$\ell(\theta) = \log \prod_{i=1}^{m} p\left(y^{(i)} \mid x^{(i)}; \theta\right) = \sum_{i=1}^{m} \log p\left(y^{(i)} \mid x^{(i)}; \theta\right)$$

For [[Linear regression]] with Gaussian IID noise this expands to

$$\ell(\theta) = m\log\frac{1}{\sqrt{2\pi}\,\sigma} - \frac{1}{2\sigma^2}\sum_{i=1}^{m}\left(y^{(i)} - \theta^T x^{(i)}\right)^2$$

- The first term is **constant** in $\theta$; the second carries a **minus sign**. So maximizing $\ell$ = **minimizing** $\sum (y^{(i)} - \theta^T x^{(i)})^2$, i.e. the squared-error [[Cost function]].
- This is the practical form of [[Maximum likelihood estimation]] - you almost always maximize the log-likelihood, never the raw product (sums differentiate cleanly and avoid numerical underflow).
