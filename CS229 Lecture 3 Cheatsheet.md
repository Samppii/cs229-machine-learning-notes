# CS229 Lecture 3 Cheatsheet - LWR + Probabilistic Interpretation

> **STATUS: INCOMPLETE (Part 1 of 2).** Logistic regression + Newton's method (Arc 3) still to be added.

Condensed quick-reference for [[CS229 Lecture 3]]. For the linear-algebra machinery see [[CS229 Math Cheatsheet]].

## Locally weighted regression (LWR)

- **What:** [[Linear regression]] + a weight per example. $J(\theta) = \sum_i w^{(i)}\left(y^{(i)} - \theta^T x^{(i)}\right)^2$
- **Weight:** $w^{(i)} = \exp\!\left(-\dfrac{(x^{(i)}-x)^2}{2\tau^2}\right)$ - near the prediction point $x \Rightarrow w \approx 1$; far $\Rightarrow w \approx 0$.
- **Per prediction:** weights computed relative to $x$; re-fit a fresh local line for every prediction. (weights = computed from distance; $\theta$ = fitted.)
- **$\tau$ ([[Bandwidth]]):** neighborhood width. Big = smoother (oversmooth risk); small = jagged (overfit risk). Tuned in PS1.
- **[[Parametric vs non-parametric]]:** LWR is non-parametric - keep **all** the data (storage grows with $m$); cannot throw data away. vs parametric LR (keep only $\theta$).
- **Caution:** the weight **looks** Gaussian but is **not** a probability density (no normalizing constant, does not integrate to 1).

## Probabilistic interpretation (why squared error)

- **Assume:** $y = \theta^T x + \varepsilon$, $\varepsilon \sim \mathcal{N}(0, \sigma^2)$, [[IID]]. ([[Gaussian distribution]] justified by the central limit theorem.)
- **So:** $p(y \mid x; \theta)$ is Gaussian, mean $\theta^T x$, variance $\sigma^2$ (this one **is** a real density).
- **[[Likelihood]]:** $L(\theta) = \prod_i p\left(y^{(i)} \mid x^{(i)}; \theta\right)$ (product because IID).
- **[[Log-likelihood]]:** log turns product into sum; maximizing it = minimizing $\sum\left(y^{(i)} - \theta^T x^{(i)}\right)^2$.
- **Punchline:** maximize likelihood under Gaussian IID noise = minimize squared error = $J(\theta)$. The squared-error [[Cost function]] is the MLE under Gaussian noise, not arbitrary.
- **[[Maximum likelihood estimation]] recipe:** (1) assume $p(y \mid x; \theta)$, (2) write the likelihood, (3) maximize via the log. (Reused for logistic regression.)

## Logistic regression + Newton's method

**TO BE ADDED** - Arc 3 not yet covered (classification, sigmoid $g(z) = 1/(1+e^{-z})$, Bernoulli likelihood + MLE, gradient ascent, Newton's method).
