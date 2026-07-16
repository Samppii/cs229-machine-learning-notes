---
aliases:
  - gaussian distribution
  - gaussian distributions
  - gaussian
  - normal distribution
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: atom
units:
  - "[[CS229 Lecture 3]]"
---

# Gaussian distribution

## Summary

The bell-curve density, $\mathcal{N}(\mu, \sigma^2)$, with mean $\mu$ and variance $\sigma^2$:

$$p(z) = \frac{1}{\sqrt{2\pi}\,\sigma}\exp\left(-\frac{(z - \mu)^2}{2\sigma^2}\right)$$

- The $\dfrac{1}{\sqrt{2\pi}\,\sigma}$ is the **normalizing constant** that makes it integrate to 1 - i.e. it is a genuine probability density.
- **Why it shows up in [[CS229 Lecture 3]]:** the noise in linear regression, $\varepsilon^{(i)} \sim \mathcal{N}(0, \sigma^2)$, is assumed Gaussian. Justified by the **central limit theorem** - an error made of many small, uncorrelated sources tends to a Gaussian regardless of the sources' own shapes.
- This drives the probabilistic story: $y^{(i)} \mid x^{(i)}; \theta$ is Gaussian with mean $\theta^T x^{(i)}$, which under [[Maximum likelihood estimation]] reproduces the squared-error [[Cost function]].

> [!note] Contrast with the LWR weight
> The [[Locally weighted regression]] weight $w^{(i)} = \exp(-(x^{(i)}-x)^2 / 2\tau^2)$ has the same bell **shape** but **no** normalizing constant, so it is **not** a Gaussian density - it does not integrate to 1. Same curve, different object.
