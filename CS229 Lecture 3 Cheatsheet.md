# CS229 Lecture 3 Cheatsheet - LWR + Probabilistic Interpretation + Logistic Regression

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

## [[Logistic regression]] (classification, $y \in \{0, 1\}$)

- **Why not linear regression:** outliers swing the boundary; outputs go outside $[0, 1]$.
- **[[Sigmoid function|Sigmoid]]:** $g(z) = 1/(1 + e^{-z})$, output in $(0, 1)$. Derivative: $g'(z) = g(z)(1 - g(z))$.
- **Hypothesis:** $h_\theta(x) = g(\theta^T x)$ = probability that $y = 1$.
- **[[Bernoulli distribution|Bernoulli]]:** $p(y \mid x; \theta) = h^{y}(1 - h)^{1-y}$ (exponents switch on/off for $y = 1$ / $y = 0$).
- **Cost (from MLE):** $\ell(\theta) = \sum_i \left[ y^{(i)}\log h + (1 - y^{(i)})\log(1 - h)\right]$ = [[Cross-entropy]].
- **Optimizer:** [[Gradient ascent]] (maximize likelihood -> **plus** sign): $\theta_j := \theta_j + \alpha\sum_i (y^{(i)} - h)\,x_j^{(i)}$.
- **Note:** update has the same (error) x (feature) form as [[Linear regression]] (preview of GLMs). No closed-form / [[Normal equations|normal equation]].

## [[Newton's method]] (fast optimizer)

- **Idea:** find where $\ell'(\theta) = 0$ (the maximum) using tangent-line jumps.
- **Scalar:** $\theta := \theta - \ell'(\theta)/\ell''(\theta)$ (first deriv / second deriv).
- **Vector:** $\theta := \theta + H^{-1}\nabla_\theta\ell$, where $H$ = [[Hessian]] (from [[CS229 PS0 - Solutions]]).
- **[[Quadratic convergence]]:** correct digits roughly double each step (~10 iterations).
- **Tradeoff:** few iterations but each is expensive (invert the Hessian). Use for FEW params (~10-50); use [[Gradient descent]] for MANY params (thousands+).
