# CS229 Lecture 4 Cheatsheet - Perceptron + Exponential Family + GLMs + Softmax

Condensed quick-reference for [[CS229 Lecture 4]]. For the previous lecture's material see [[CS229 Lecture 3 Cheatsheet]]; for the linear-algebra machinery see [[CS229 Math Cheatsheet]].

## [[Perceptron]]

- Hard step $g(z) = 1$ if $z \geq 0$ else $0$; $h_\theta(x) = g(\theta^T x)$.
- Error $y - h \in \{-1, 0, +1\}$: correct means no move; wrong means $\theta \pm \alpha x$.
- $\theta$ is perpendicular to the boundary; adding $x$ rotates $\theta$ toward $x$.
- No probabilistic interpretation; converges only if linearly separable (Minsky's XOR critique). Not a GLM.

## [[Exponential family]] template

$$p(y;\eta) = b(y)\exp\big(\eta T(y) - a(\eta)\big)$$

$\eta$ = [[Natural parameter]] · $T(y) = y$ (always, here) · $b(y)$ = base measure, **$y$ only** · $a(\eta)$ = [[Log partition function]], **$\eta$ only**.

**Massaging moves:** products and powers means wrap in $\exp(\log(\cdot))$, since the log flattens powers into multipliers. Already has an exp means expand and split via $e^{A+B} = e^A e^B$. Terms with only $y$ go to $b(y)$.

| | $b(y)$ | $\eta$ | $a(\eta)$ | invert $\eta$ to mean | $h_\theta(x)$ |
|---|---|---|---|---|---|
| **[[Gaussian distribution\|Gaussian]]** | $\frac{1}{\sqrt{2\pi}}e^{-y^2/2}$ | $\mu$ | $\eta^2/2$ | identity | $\theta^T x$ |
| **[[Bernoulli distribution\|Bernoulli]]** | $1$ | $\log\frac{\phi}{1-\phi}$ | $\log(1+e^{\eta})$ | [[Sigmoid function\|sigmoid]] | $\frac{1}{1+e^{-\theta^T x}}$ |
| **[[Poisson distribution\|Poisson]]** | $1/y!$ | $\log\lambda$ | $e^{\eta}$ | exp | $e^{\theta^T x}$ |

## Properties

- **[[Maximum likelihood estimation|MLE]] concave in $\eta$ / NLL convex** ([[Convexity]]) - one global optimum for every GLM, guaranteed.
- $E[y] = a'(\eta)$, $\text{Var}(y) = a''(\eta)$ - moments by differentiating, not integrating.
- Property 1 follows from property 2: $a''(\eta) = \text{Var}(y) \geq 0$ means convex. (PS1 Problem 4.)

## [[Generalized linear models|GLM]] - three assumptions

1. $y \mid x;\theta \sim \text{ExponentialFamily}(\eta)$ - pick from what $y$ is
2. $\eta = \theta^T x$ - design choice, the "linear"
3. $h_\theta(x) = E[y \mid x]$ - predict the mean

## Three parameterizations

$$\theta \;\xrightarrow{\;\theta^T x\;}\; \eta \;\xrightarrow{\;g\;}\; \text{canonical } (\phi, \mu, \lambda)$$

Only $\theta$ is learned. $g$ = [[Canonical response function]] ($\eta$ to mean); $g^{-1}$ = [[Canonical link function]]; $g(\eta) = a'(\eta)$.

## Universal update rule

$$\theta_j := \theta_j + \alpha\big(y^{(i)} - h_\theta(x^{(i)})\big)x_j^{(i)}$$

Identical for every GLM - plug in $h_\theta(x)$ and train, no gradient derivation needed. [[Newton's method]] is the usual practical optimizer for GLMs (few parameters, cheap [[Hessian]]).

## Distribution by task

real-valued to Gaussian · binary to Bernoulli · counts to Poisson · positive reals to Gamma/Exponential · $k$ classes to [[Multinomial distribution|Multinomial]]

## [[Softmax regression|Softmax]]

- One $\theta_{\text{class}}$ per class; labels are one-hot vectors.
- logits, then exponentiate, then normalize:

$$\hat p(y = \text{class}\mid x) = \frac{e^{\theta_{\text{class}}^T x}}{\sum_i e^{\theta_i^T x}}$$

- Loss = [[Cross-entropy]] $-\sum_y p(y)\log\hat p(y)$, which collapses to $-\log \hat p(y_{\text{true}})$ because the label is one-hot.
- $k = 2$ recovers [[Logistic regression]]. Same loss as next-token prediction over a vocabulary.

## The one idea

**Make one decision - the distribution, dictated by what $y$ is. The hypothesis, the cost, and the update rule all follow. Nothing is hand-designed.** Exponential family gives $h_\theta(x)$; MLE gives $J(\theta)$; the family's structure gives the universal update rule and convexity for free.
