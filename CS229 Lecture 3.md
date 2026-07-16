---
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-16 00:00:00
tags: index
title: CS229 Lecture 3
status: draft
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 Lecture 3

> [!warning] Draft - in progress (Part 1 of 2)
> This note covers only the **first part** of Lecture 3: **locally weighted regression** (Arc 1) and the **probabilistic interpretation** of linear regression (Arc 2). **Logistic regression and Newton's method (Arc 3) are not yet written** - see `## ▶ Part 2 to come` at the bottom. The next pass appends to this same note.

Two threads. First, [[Locally weighted regression]] - a way to fit curved data without hand-picking features. Second, the **why** promised at the end of [[CS229 Lecture 2]]: squared error is not arbitrary, it *falls out* of assuming Gaussian noise plus [[Maximum likelihood estimation]]. Quick reference in [[CS229 Lecture 3 Cheatsheet]]; the linear-algebra machinery is in [[CS229 Math Cheatsheet]].

## Arc 1 - Locally weighted regression (LWR)

**The problem.** Real data often is not a straight line. Two options: (1) engineer features (add $x^2$, $\sqrt{x}$, etc. - still linear in $\theta$, this is polynomial regression), or (2) use [[Locally weighted regression]], which sidesteps hand-picking features. (Andrew notes **feature selection** - choosing *which* features to use - comes later in the course.)

**Core idea.** LWR = [[Linear regression]] with a **weight** on each training example:

$$J(\theta) = \sum_{i=1}^{m} w^{(i)}\left(y^{(i)} - \theta^T x^{(i)}\right)^2$$

The only change from plain LR is the $w^{(i)}$ multiplied onto each squared-error term.

**The weight function:**

$$w^{(i)} = \exp\left(-\frac{(x^{(i)} - x)^2}{2\tau^2}\right)$$

- $x$ = the point where you want to predict (the reference point); $x^{(i)}$ = a training example's input.
- $|x^{(i)} - x|$ **small** (example near the prediction point) $\Rightarrow w^{(i)} \approx 1$ (counts fully).
- $|x^{(i)} - x|$ **large** (example far) $\Rightarrow w^{(i)} \approx 0$ (ignored).
- So the fit only pays attention to the **local** neighborhood around $x$. Far examples get multiplied by $\approx 0$ and drop out of the sum.

**Per prediction.** Weights are computed *relative to the prediction point* $x$, so you **re-compute the weights and re-fit the local line for every new prediction point**. Weights are **computed** from distance (not fitted); $\theta$ is **fitted** by weighted least squares. Many local straight lines strung together follow a curve.

**[[Bandwidth]] ($\tau$).** The hyperparameter setting how wide the bell/neighborhood is. Big $\tau$ = wide neighborhood = smoother (risk of oversmoothing/underfitting); small $\tau$ = narrow = jagged (risk of overfitting). Tuned in PS1.

**[[Parametric vs non-parametric]].** Linear regression is **parametric** - fit a fixed set of parameters $\theta$, then throw the data away. LWR is **non-parametric** - you must keep all the data, since every prediction re-uses nearby examples; storage grows with the training set. Good for low-dimensional data with many examples; expensive for millions.

> [!caution] The weight is not a Gaussian
> $w^{(i)}$ **looks like** a bell curve but is **not** a Gaussian probability density - it has no normalizing constant and does **not** integrate to 1. It only borrows the bell shape (peak in the middle, decay on the sides) because that shape is convenient for weighting. Do not confuse it with the real Gaussian in Arc 2.

## Arc 2 - Probabilistic interpretation (why squared error)

**The question from Lecture 2.** Why squared error, and not absolute value or 4th power? Answer: squared error **falls out** of assuming Gaussian noise plus [[Maximum likelihood estimation]].

1. **Model the data.** $y^{(i)} = \theta^T x^{(i)} + \varepsilon^{(i)}$, where $\varepsilon^{(i)}$ is an error term (unmodeled effects + random noise).
2. **Assume the noise is Gaussian and IID.** $\varepsilon^{(i)} \sim \mathcal{N}(0, \sigma^2)$, justified by the **central limit theorem** (an error made of many small uncorrelated sources tends to a [[Gaussian distribution]]). [[IID]] = independently and identically distributed - each example's error independent of the others (an approximation, but good enough).
3. **So the target is Gaussian around the prediction** (this one **is** a real density - it integrates to 1):
   $$p(y^{(i)} \mid x^{(i)}; \theta) = \frac{1}{\sqrt{2\pi}\,\sigma}\exp\left(-\frac{(y^{(i)} - \theta^T x^{(i)})^2}{2\sigma^2}\right)$$
   Mean $= \theta^T x^{(i)}$ (the prediction), variance $= \sigma^2$. The **semicolon** reads "parameterized by $\theta$" - $\theta$ is a fixed parameter, not a random variable. Note the exponent already contains $(y - \theta^T x)^2$: squared error is hiding inside.
4. **[[Likelihood]]** - the probability of *all* the data. Because the errors are IID (independent), multiply:
   $$L(\theta) = \prod_{i=1}^{m} p(y^{(i)} \mid x^{(i)}; \theta)$$
   Likelihood = a function of $\theta$ with the data held fixed. Probability = data varying, params fixed. Same formula, different view.
5. **[[Log-likelihood]]** - log turns the product into a sum and is monotonic, so it has the same maximizer:
   $$\ell(\theta) = m\log\frac{1}{\sqrt{2\pi}\,\sigma} - \frac{1}{2\sigma^2}\sum_{i=1}^{m}\left(y^{(i)} - \theta^T x^{(i)}\right)^2$$
6. **[[Maximum likelihood estimation]]** - choose $\theta$ to maximize $\ell(\theta)$, i.e. the $\theta$ that makes the observed data most probable.
   - First term is a **constant** (no $\theta$) $\to$ ignore.
   - Second term carries a **minus sign** $\to$ maximizing it = **minimizing** $\sum (y^{(i)} - \theta^T x^{(i)})^2$.
   - The $\tfrac{1}{2\sigma^2}$ is a positive constant $\to$ does not move the minimizer.

**Punchline:**

$$\text{maximize } \ell(\theta) \iff \text{minimize } \tfrac{1}{2}\sum_{i=1}^{m}\left(y^{(i)} - \theta^T x^{(i)}\right)^2 = J(\theta)$$

**Maximizing likelihood under Gaussian IID noise = minimizing squared error.** So the [[Cost function]] $J(\theta)$ is not arbitrary - it is the maximum-likelihood estimator under Gaussian noise. This also teaches the reusable **MLE recipe**: (1) assume $p(y \mid x; \theta)$, (2) write the likelihood, (3) maximize (via the log). The same recipe generates the next algorithm (logistic regression).

## ▶ Part 2 to come

Arc 3 - **Logistic regression + Newton's method** - not yet covered. Next pass will add:

- Classification setup ($y \in \{0, 1\}$) and why linear regression is wrong for it.
- The sigmoid/logistic function $g(z) = \dfrac{1}{1 + e^{-z}}$ and the hypothesis $h(x) = g(\theta^T x)$.
- The Bernoulli likelihood + MLE derivation, and gradient **ascent** (the "+" update).
- **Newton's method** - a fast optimizer using the [[Hessian]], with quadratic convergence.

## Notes in this lecture

![[Unit Preview.base]]
