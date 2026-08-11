---
dateCreated: 2026-08-11 00:00:00
dateModified: 2026-08-11 00:00:00
tags: index
title: CS229 Lecture 4
status: complete
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 Lecture 4

Four parts. First the [[Perceptron]] - a historical detour, and the only algorithm here with no probability model. Then the [[Exponential family]], a template that a whole class of distributions fits into, which finally answers the question left hanging in [[CS229 Lecture 3]]: **why the sigmoid?** Third, [[Generalized linear models]] - the framework that has [[Linear regression]] and [[Logistic regression]] as two instances of one recipe, explaining why they shared an update rule. Fourth, [[Softmax regression]] for multi-class problems. Quick reference in [[CS229 Lecture 4 Cheatsheet]]; the linear-algebra machinery is in [[CS229 Math Cheatsheet]].

> [!info] Taught by a TA
> This lecture was given by a TA (Anand), not Andrew Ng - Andrew was in Washington DC, as flagged at the end of [[CS229 Lecture 3]]. The delivery is less polished than usual, and the **written lecture notes are the better reference** for this material (especially the GLM derivation of softmax, which lecture skips).

## Part 1 - The Perceptron

**Status:** not used in practice. Covered for historical reasons, because it is simple to analyse, and because there are homework questions on it.

**The idea.** [[Logistic regression]] with a **hard** step function instead of the smooth [[Sigmoid function]] - "the hard version of the sigmoid":

$$g(z) = \begin{cases} 1 & z \geq 0 \\ 0 & z < 0\end{cases} \qquad h_\theta(x) = g(\theta^T x)$$

**Update rule** - the same form as [[Linear regression]] and [[Logistic regression]] (deliberately flagged; it is the setup for GLMs):

$$\theta_j := \theta_j + \alpha\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

**The error term takes only three values**, since both $y$ and $h$ are exactly 0 or 1:

| situation | $y - h$ | effect |
|---|---|---|
| prediction correct | 0 | $\theta$ does not move |
| wrong, true label 1 | +1 | $\theta := \theta + \alpha x$ (pull toward $x$) |
| wrong, true label 0 | -1 | $\theta := \theta - \alpha x$ (push away from $x$) |

So the algorithm is: go example by example, ignore the ones you get right, nudge $\theta$ toward or away from each mistake.

**The geometry.** $\theta$ is normal (perpendicular) to the decision boundary $\theta^T x = 0$. A dot product is positive when two vectors point in similar directions, so you want $\theta$ pointing **toward** the class-1 examples and **away from** the class-0 ones. Adding $x$ to $\theta$ drags $\theta$ in $x$'s direction, and the perpendicular boundary rotates with it until $x$ lands on the correct side. The general technique - **adding one vector to another makes the second more similar to the first** - recurs throughout machine learning.

**Weaknesses.**

- **No probabilistic interpretation.** $h(x) = 1$ means "on the positive side of the line", not "100% confident". No distribution is assumed, and the update is a geometric heuristic rather than something derived from [[Maximum likelihood estimation]]. Geometric intuition, no probabilistic grounding - hence no confidence estimates and no principled [[Cost function]].
- **Updates are greedy and local.** Rotating $\theta$ to fix one point can knock a previously-correct point onto the wrong side; the algorithm can thrash. It converges only if the data is **linearly separable** (the perceptron convergence theorem); otherwise it cycles forever with no natural stopping criterion. Common practice is to anneal $\alpha$ downward until $\theta$ stops changing much.
- **Minsky's critique** (1960s): it cannot learn non-linearly-separable data (e.g. XOR). This killed interest in the algorithm for years.

[[Logistic regression]] is essentially the "soft" version - same skeleton, smooth $g$, plus a real probabilistic foundation. Because $h$ is a smooth probability there, the size of the correction scales with *how* wrong the prediction was, not just its direction.

## Part 2 - The Exponential Family

A distribution is in the [[Exponential family]] if its PDF (or PMF, if discrete) can be written:

$$p(y; \eta) = b(y)\exp\left(\eta^T T(y) - a(\eta)\right)$$

| piece | name | constraint |
|---|---|---|
| $y$ | the data | modelled as the **output** - no $x$ appears anywhere in this section |
| $\eta$ | [[Natural parameter]] | the knob; scalar for everything in this course |
| $T(y)$ | sufficient statistic | $T(y) = y$ for every distribution in this course |
| $b(y)$ | base measure | function of $y$ **only** - cannot contain $\eta$ |
| $a(\eta)$ | [[Log partition function]] | function of $\eta$ **only** - cannot contain $y$ |

**Dimensions:** $\eta^T T(y)$ is a dot product, so $\eta$ and $T(y)$ must have matching dimension; $b(y)$ and $a(\eta)$ are scalars.

**Why "log partition":** pulling $a(\eta)$ out gives $p(y;\eta) = \dfrac{b(y)\exp(\eta^T T(y))}{\exp(a(\eta))}$. The denominator is the normalizing constant (the "partition function") that makes the distribution integrate to 1, and $a(\eta)$ is its log.

**It is a template.** Different choices of $b$, $T$, $a$ give different *families* (Gaussian, Bernoulli, Poisson); different values of $\eta$ give different *members* of a chosen family. Not every distribution fits - the Cauchy does not. Fitting is a real structural property, and it is what buys the guarantees below.

**The method for proving membership:** write the PDF in its familiar (canonical-parameter) form, do algebraic massaging until it matches the template, then **pattern match** and read off the four pieces. Two opening moves depending on the starting form:

| starting PDF looks like | opening move | why |
|---|---|---|
| products and powers, no exp (Bernoulli, Poisson) | wrap in $\exp(\log(\cdot))$ | the log flattens powers into multipliers |
| already contains an exp (Gaussian) | expand inside, split via $e^{A+B} = e^A e^B$ | untangles $y$ from the parameter |

Sorting rule throughout: **terms involving only $y$ go to $b(y)$; terms involving the parameter stay in the exponent.**

### [[Bernoulli distribution|Bernoulli]]

$$p(y;\phi) = \phi^{y}(1-\phi)^{1-y}$$

(The exponents act as an if-else: $y = 1 \Rightarrow \phi$; $y = 0 \Rightarrow 1-\phi$.)

Wrap in $\exp(\log(\cdot))$, apply $\log(AB) = \log A + \log B$ and $\log(A^n) = n\log A$, then group the $y$ terms:

$$= \exp\Big(y\log\phi + (1-y)\log(1-\phi)\Big) = \exp\Big(\underbrace{\log\tfrac{\phi}{1-\phi}}_{\eta}\cdot y + \log(1-\phi)\Big)$$

Read off: $b(y) = 1$, $T(y) = y$, $\eta = \log\frac{\phi}{1-\phi}$, $a(\eta) = -\log(1-\phi)$.

**Inverting $\eta$ produces the sigmoid:**

$$\eta = \log\tfrac{\phi}{1-\phi} \Rightarrow e^{\eta} = \tfrac{\phi}{1-\phi} \Rightarrow \phi(1 + e^{\eta}) = e^{\eta} \Rightarrow \boxed{\phi = \frac{1}{1 + e^{-\eta}}}$$

This is the answer to "why the [[Sigmoid function|sigmoid]]?" left hanging in [[CS229 Lecture 3]] - it was *pulled out of thin air* there, and here it falls out of the algebra. Nobody chose it.

Substituting back so $a(\eta)$ contains only $\eta$: since $1 - \phi = \frac{1}{1+e^{\eta}}$, we get $a(\eta) = \log(1 + e^{\eta})$.

### [[Gaussian distribution|Gaussian]] (fixed variance $\sigma^2 = 1$)

$$p(y;\mu) = \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(y-\mu)^2}{2}\right)$$

Already has an exp, so expand the square instead: $-\frac{(y-\mu)^2}{2} = -\frac{y^2}{2} + \mu y - \frac{\mu^2}{2}$. Three terms sorted by dependence - $-y^2/2$ (only $y$), $\mu y$ (both), $-\mu^2/2$ (only $\mu$). Split off the $y$-only term:

$$p(y;\mu) = \underbrace{\frac{1}{\sqrt{2\pi}}e^{-y^2/2}}_{b(y)}\exp\Big(\underbrace{\mu}_{\eta}\, y - \underbrace{\tfrac{\mu^2}{2}}_{a(\eta)}\Big)$$

Read off: $b(y) = \frac{1}{\sqrt{2\pi}}e^{-y^2/2}$, $T(y) = y$, $\boxed{\eta = \mu}$, $a(\eta) = \frac{\eta^2}{2}$.

**No inversion needed - the natural parameter *is* the mean.** The link is the identity, which is precisely why [[Linear regression]]'s hypothesis is a bare $\theta^T x$ with no wrapper.

(Variance is fixed at 1 to keep $\eta$ scalar. With unknown variance $\eta$ becomes a 2-vector, and $T(y)$ must too - still an exponential family, just messier.)

### [[Poisson distribution|Poisson]] (for PS1 Problem 3)

$$p(y;\lambda) = \frac{e^{-\lambda}\lambda^{y}}{y!}$$

Bernoulli route: $= \frac{1}{y!}\exp(y\log\lambda - \lambda)$. Read off $b(y) = 1/y!$, $T(y) = y$, $\eta = \log\lambda$, and - after inverting $\lambda = e^{\eta}$ - $a(\eta) = e^{\eta}$. Gives $h_\theta(x) = e^{\theta^T x}$.

### The two properties

1. **[[Maximum likelihood estimation|MLE]] with respect to $\eta$ is concave** - equivalently, the negative log-likelihood (NLL) is convex. One global optimum, no local optima, for *every* member of the family. You never have to check per-algorithm.
2. **Moments are derivatives of the [[Log partition function]]:**

$$E[y;\eta] = \frac{\partial}{\partial\eta}a(\eta) \qquad \text{Var}(y;\eta) = \frac{\partial^2}{\partial\eta^2}a(\eta)$$

Computing moments normally requires an integral; here it is a derivative. (For vector $\eta$, the second becomes the [[Hessian]].)

**Property 1 follows from property 2:** $a''(\eta) = \text{Var}(y) \geq 0$, and a non-negative second derivative means convex ([[Convexity]]). The convexity guarantee for every GLM rests on "variance cannot be negative".

Verified on the two derivations:

| distribution | $a(\eta)$ | $a'(\eta)$ | $a''(\eta)$ |
|---|---|---|---|
| Gaussian | $\eta^2/2$ | $\eta = \mu$ (correct) | $1 = \sigma^2$ (correct) |
| Bernoulli | $\log(1+e^{\eta})$ | $\frac{1}{1+e^{-\eta}} = \phi$ (correct) | - |

Note the sigmoid appearing a second time, now as a derivative rather than by inverting $\eta$ - two independent routes agreeing.

These properties are proved in **PS1 Problem 4**.

## Part 3 - Generalized Linear Models

The [[Exponential family]] has no $x$ in it - it describes a distribution over $y$ and nothing else. [[Generalized linear models|GLMs]] are the extension that brings in covariates (input [[Features]]). Three assumptions:

1. **$y \mid x; \theta \sim \text{ExponentialFamily}(\eta)$** - choose the distribution based on what $y$ is
2. **$\eta = \theta^T x$**, with $\theta, x \in \mathbb{R}^n$ - the design choice; this is where $x$ enters and the "linear" in GLM
3. **$h_\theta(x) = E[y \mid x; \theta]$** - predict the mean of the resulting distribution

**Choosing the distribution** - dictated by the task, not by judgement:

| $y$ is | distribution |
|---|---|
| real-valued | [[Gaussian distribution\|Gaussian]] |
| binary | [[Bernoulli distribution\|Bernoulli]] |
| counts (non-negative integers) | [[Poisson distribution\|Poisson]] |
| positive reals (durations, volumes) | Gamma / Exponential |
| one of $k$ classes | [[Multinomial distribution\|Multinomial]] |
| a probability distribution | Beta / Dirichlet (Bayesian settings) |

(Note: the *exponential family* and the *exponential distribution* are different things; the latter is one member of the former.)

**The mental picture:** a linear model and a distribution stacked. $x$ goes into the linear model, $\theta^T x$ produces $\eta$, and $\eta$ is the parameter of the exponential-family distribution sitting on top. The distribution's mean is the prediction.

### The three parameterizations

The main source of confusion, because "parameter" means three different things:

| name | symbol | status |
|---|---|---|
| **model parameters** | $\theta$ | **the only thing learned** |
| [[Natural parameter]] | $\eta$ | computed as $\theta^T x$ |
| **canonical parameters** | $\phi$ (Bernoulli), $\mu, \sigma^2$ (Gaussian), $\lambda$ (Poisson) | computed from $\eta$ via the link |

$$\theta \;\xrightarrow{\;\theta^T x\;}\; \eta \;\xrightarrow{\;g\;}\; \text{canonical}$$

[[Gradient descent]] touches $\theta$ and nothing else - $\eta$ and the canonical parameters are recomputed downstream for every $x$. The first arrow is a design choice; the second is determined by the distribution.

- $g$ = [[Canonical response function]], $\eta \to$ mean
- $g^{-1}$ = [[Canonical link function]], mean $\to \eta$
- and $g(\eta) = \frac{\partial}{\partial\eta}a(\eta)$ - the response function *is* the derivative of the log partition function

### Training and the universal update rule

Training is [[Maximum likelihood estimation]] on $\theta$: $\max_\theta \sum_i \log p(y^{(i)} \mid x^{(i)}; \theta)$.

The incidental benefit: **you never derive gradients again.** For *any* GLM, whatever distribution you chose, the update is

$$\theta_j := \theta_j + \alpha\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

(stochastic form; the batch version sums over all examples - see [[Stochastic gradient descent]] and [[Batch gradient descent]].) Plug in the appropriate $h_\theta(x)$ and start training.

**Why it is always the same.** Two structural facts, neither depending on the distribution: $\eta = \theta^T x$ gives $\partial\eta/\partial\theta_j = x_j$; and differentiating the exponential-family log-likelihood with respect to $\eta$ gives $y - a'(\eta) = y - h$. Chain them: $(y - h)x_j$.

This answers the [[CS229 Lecture 3]] observation that linear and logistic regression shared an update rule despite different hypotheses - every GLM shares it. Note the $x_j$ factor is essential: it assigns blame proportionally to how much feature $j$ participated. Without it every weight would shift identically.

**Optimizer note:** [[Newton's method]] is the usual practical choice for GLMs, since GLM parameter counts are typically small enough (under a few thousand) that inverting the [[Hessian]] is cheap.

### Cranking the handle

| | distribution | $E[y]$ | $h_\theta(x)$ |
|---|---|---|---|
| [[Linear regression]] | Gaussian | $\mu = \eta$ | $\theta^T x$ |
| [[Logistic regression]] | Bernoulli | $\phi = \frac{1}{1+e^{-\eta}}$ | $\frac{1}{1+e^{-\theta^T x}}$ |
| Poisson regression | Poisson | $\lambda = e^{\eta}$ | $e^{\theta^T x}$ |

Same three steps every time; only assumption 1 changes. The TA on logistic regression: the logistic function was pulled out of thin air in [[CS229 Lecture 3]], but here "it just pops out".

### What the assumptions mean geometrically

**Regression.** For every $x$, $\theta^T x$ traces a line; that value is $\eta = \mu$. So a Gaussian bell curve stands at every point along that line, and the observed $y$ was **sampled from the bell sitting there** - not read off the line. Training runs backwards: find the line making the observed points the most likely draws.

**Classification.** For every $x$, $\theta^T x$ gives $\eta$; the sigmoid maps it to $\phi$. So a biased coin sits at every $x$, with bias equal to the height of the sigmoid there, and the observed $y \in \{0,1\}$ was a flip of that coin. Training runs backwards the same way.

Unified: **a distribution is parked at every $x$, parameterized by $\theta^T x$, and the data was a draw from it.** MLE finds the $\theta$ making those draws most plausible. This is the generative story the three assumptions are claiming - and seeing it makes it possible to notice when it fails (e.g. variance varying per example, which is what [[CS229 PS1 - Problem 5 LWR|PS1 5(a)(iii)]] addresses).

### Scope

GLMs cover **discriminative, probabilistic models where $\eta$ is linear in $x$**. Outside the family: [[Locally weighted regression]] (weighted linear regression, [[Parametric vs non-parametric|non-parametric]]), the [[Perceptron]] (no probabilistic interpretation), GDA and Naive Bayes (generative - they model $p(x \mid y)$), SVMs (no probability model), neural networks ($\eta$ nonlinear in $\theta$, which is what destroys the [[Convexity]] guarantee).

Within that scope, a new problem type is a lookup rather than a research problem: find a distribution matching your $y$, massage it, invert $\eta$, plug $h_\theta(x)$ into the universal update rule.

## Part 4 - Softmax Regression (multi-class)

The written lecture notes derive [[Softmax regression]] as another GLM member ([[Multinomial distribution|Multinomial]]). In lecture the TA takes a **non-GLM route** via [[Cross-entropy]] minimization instead, since the GLM derivation is messy on a whiteboard. Same final equations.

**Setup.** $k$ classes, $x^{(i)} \in \mathbb{R}^n$, and labels are **one-hot vectors** $y \in \{0,1\}^k$ - all zeros except a single 1 marking the class.

**One $\theta$ per class.** Where [[Logistic regression]] had a single $\theta$ doing a binary split, softmax has $\theta_{\text{class}} \in \mathbb{R}^n$ for each class (optionally stacked as an $n \times k$ matrix). Each defines its own hyperplane $\theta_{\text{class}}^T x = 0$, so $k$ classes carve the input space with $k$ linear boundaries. This is what makes softmax a **linear** model - the nonlinearity sits outside, in the softmax function.

**The pipeline.** Given a new $x$:

1. **Logits** - compute $\theta_{\text{class}}^T x$ for each class. Real numbers in $(-\infty, \infty)$; this is "logit space", not probabilities.
2. **Exponentiate** - $e^{\theta_{\text{class}}^T x}$, making everything positive.
3. **Normalize** - divide by the sum so the values add to 1:

$$\hat{p}(y = \text{class} \mid x) = \frac{e^{\theta_{\text{class}}^T x}}{\sum_{i} e^{\theta_i^T x}}$$

Note the hypothesis now outputs a **whole probability distribution** over classes, not a scalar.

**Training - minimize [[Cross-entropy]].** Two distributions are in play: $\hat p$ (the softmax output) and $p$ (the one-hot label, read as a distribution with 1 on the correct class). The goal is to make $\hat p$ resemble $p$, measured by

$$\text{CrossEnt}(p, \hat p) = -\sum_{y} p(y)\log \hat p(y)$$

Because $p$ is one-hot, every term vanishes except the correct class, and this collapses to $-\log \hat p(y_{\text{true}})$ - the negative log probability of the correct class. Substituting the softmax expression gives the loss, and you run [[Gradient descent]] on the $\theta$'s.

**Reading the loss:** push up the correct class's score *relative to the others*. Correct class near probability 1 gives loss near 0; near 0 and the loss blows up. The denominator makes it competitive - raising the correct score helps, and so does lowering the others, since they sit in the denominator.

**Connections.** With $k = 2$, softmax collapses to the [[Sigmoid function|sigmoid]] and cross-entropy becomes [[Logistic regression]]'s cost - softmax is logistic regression generalized. This is also the loss used for next-token prediction over a vocabulary (a softmax over roughly 50,000 classes).

## The one idea

**Make one decision - the distribution, dictated by what $y$ is. The hypothesis, the cost, and the update rule all follow. Nothing is hand-designed.** The [[Exponential family]] gives $h_\theta(x)$; [[Maximum likelihood estimation]] gives $J(\theta)$; the family's structure gives the universal update rule and [[Convexity]] for free.

## Problem set

This lecture unlocks **PS1 Problem 3 (Poisson regression)** - crank the GLM handle on the [[Poisson distribution]] and derive the update rule for $h_\theta(x) = e^{\theta^T x}$ - and **PS1 Problem 4 (convexity of GLMs)**, which proves the two exponential-family properties above ($a'(\eta) = E[y]$, $a''(\eta) = \text{Var}(y)$, hence a convex NLL). Both are now doable. The already-written PS1 work is in [[CS229 PS1 - Problem 5 LWR]]; the matrix calculus those proofs need is in [[CS229 Math Cheatsheet]] and [[CS229 PS0 - Solutions]].

## Threads to later lectures

- **Generative learning algorithms** (GDA, Naive Bayes) - the other side of the discriminative/generative split flagged in the scope section.
- **SVMs** - classification with no probability model at all, the opposite design choice from GLMs.
- **Neural networks** - $\eta$ becomes nonlinear in $\theta$, and the convexity guarantee that every GLM enjoys disappears.

## Notes in this lecture

![[Unit Preview.base]]
