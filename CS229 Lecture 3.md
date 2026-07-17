---
dateCreated: 2026-07-16 00:00:00
dateModified: 2026-07-17 00:00:00
tags: index
title: CS229 Lecture 3
status: complete
units:
  - "[[CS229]]"
up:
  - "[[CS229]]"
---

# CS229 Lecture 3

Three arcs. First, [[Locally weighted regression]] - a way to fit curved data without hand-picking features. Second, the **why** promised at the end of [[CS229 Lecture 2]]: squared error is not arbitrary, it *falls out* of assuming Gaussian noise plus [[Maximum likelihood estimation]]. Third, the same MLE recipe applied to a Bernoulli model gives our first classifier, [[Logistic regression]], optimized by [[Gradient ascent]] or [[Newton's method]]. Quick reference in [[CS229 Lecture 3 Cheatsheet]]; the linear-algebra machinery is in [[CS229 Math Cheatsheet]].

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

## Arc 3 - Logistic regression + Newton's method

**The new setting.** $y$ is no longer a continuous number - it is a **class**, $y \in \{0, 1\}$ (**binary [[Classification]]**), e.g. tumor malignant (1) vs benign (0).

**Why not [[Linear regression]] for classification?**

1. **Outliers wreck it.** Fitting a straight line and thresholding at $0.5$ gives a reasonable boundary - but one far-out example (even a clearly-correct one) can swing the line and shift the decision boundary badly. Linear regression is not robust for classification.
2. **Unnatural outputs.** For a 0/1 problem, $\theta^T x$ can output values $< 0$ or $> 1$, which is strange when the labels are only 0 or 1.

So we want a hypothesis whose output lies **between 0 and 1** - interpretable as a probability.

### The sigmoid (logistic) function

The [[Sigmoid function]] $g(z)$ (**sigmoid** and **logistic** are synonyms):

$$g(z) = \frac{1}{1 + e^{-z}}$$

S-shaped: crosses $0.5$ at $z = 0$, asymptotes to $1$ as $z \to +\infty$ and to $0$ as $z \to -\infty$; output always in $(0, 1)$. Pass $\theta^T x$ through it to bound the hypothesis:

$$h_\theta(x) = g(\theta^T x) = \frac{1}{1 + e^{-\theta^T x}}$$

Many functions map to $(0, 1)$; the sigmoid is chosen because it falls out of **generalized linear models** (GLMs), covered next lecture. Useful derivative property (used in the gradient derivation): $g'(z) = g(z)\left(1 - g(z)\right)$.

### The distribution assumption ([[Bernoulli distribution|Bernoulli]])

Model $y$ as Bernoulli with parameter $h_\theta(x)$:

$$p(y = 1 \mid x; \theta) = h_\theta(x), \qquad p(y = 0 \mid x; \theta) = 1 - h_\theta(x)$$

**Compressed into one equation** (the exponent trick):

$$p(y \mid x; \theta) = \left(h_\theta(x)\right)^{y}\left(1 - h_\theta(x)\right)^{1 - y}$$

If $y = 1$: $h^1 (1-h)^0 = h$. If $y = 0$: $h^0 (1-h)^1 = 1-h$. The exponents act as on/off switches - one term becomes 1 (anything to the power 0), leaving the right case.

### MLE -> the log-likelihood

Same [[Maximum likelihood estimation]] recipe as [[Linear regression]], now with the Bernoulli formula. Likelihood ([[IID]] -> product):

$$L(\theta) = \prod_{i=1}^{m}\left(h_\theta(x^{(i)})\right)^{y^{(i)}}\left(1 - h_\theta(x^{(i)})\right)^{1 - y^{(i)}}$$

[[Log-likelihood]] (log turns product -> sum, exponents -> multipliers):

$$\ell(\theta) = \sum_{i=1}^{m}\left[\, y^{(i)}\log h_\theta(x^{(i)}) + \left(1 - y^{(i)}\right)\log\left(1 - h_\theta(x^{(i)})\right)\right]$$

This is the [[Cross-entropy]], up to sign - the logistic regression objective. It fell out of MLE on a Bernoulli model exactly like squared error fell out of MLE on a [[Gaussian distribution]].

### Gradient ascent (the optimizer)

We **maximize** the log-likelihood, so we use [[Gradient ascent]] - note the **plus** sign (going uphill to a maximum), vs [[Linear regression]]'s minus (descent, minimizing a cost):

$$\theta_j := \theta_j + \alpha \frac{\partial}{\partial \theta_j}\ell(\theta)$$

Working out the derivative (using $g'(z) = g(z)(1-g(z))$; full derivation in Andrew's notes) gives:

$$\theta_j := \theta_j + \alpha \sum_{i=1}^{m}\left(y^{(i)} - h_\theta(x^{(i)})\right)x_j^{(i)}$$

- **Striking result:** this update looks *identical in form* to the [[Linear regression]] update - same **(error) x (feature)** shape - even though $h_\theta$ is now the sigmoid, not $\theta^T x$. Andrew flags this as a preview of **GLMs**: linear and logistic regression are both instances of one framework, which is why they share the update form. (For all algorithms in that class there are no local optima - the log-likelihood is concave, one global maximum. Another reason the sigmoid is chosen.)
- **No [[Normal equations|normal equation]]** for logistic regression - no closed-form solution. It needs an iterative optimizer ([[Gradient ascent]] or [[Newton's method]]).

### [[Newton's method]] (a faster optimizer)

Gradient ascent takes many small ("baby") steps - can need thousands of iterations. Newton's method takes bigger jumps - often ~10 iterations.

**What it solves:** finding $\theta$ where a function $f(\theta) = 0$. To *maximize* $\ell$, note the maximum is where the derivative is zero, so set $f = \ell'$ and find where $\ell'(\theta) = 0$.

**The picture (1-D):** start at $\theta^0$, take the line tangent to $f$ there, and solve for where that tangent hits the horizontal axis -> that is $\theta^1$. Repeat. Converges very fast.

**Derivation:** slope of the tangent $= f'(\theta^0) = f(\theta^0)/\Delta$, so $\Delta = f(\theta^0)/f'(\theta^0)$. One iteration:

$$\theta^{t+1} := \theta^t - \frac{f(\theta^t)}{f'(\theta^t)}$$

Setting $f = \ell'$ (find where the first derivative is zero) gives first derivative over second derivative:

$$\theta^{t+1} := \theta^t - \frac{\ell'(\theta^t)}{\ell''(\theta^t)}$$

**[[Quadratic convergence]]:** roughly, the number of correct significant digits **doubles** each iteration ($0.01 \to 0.0001 \to 0.00000001$). Extremely fast near the solution - why it needs few iterations.

**Vector version** ($\theta \in \mathbb{R}^{n+1}$): the second derivative becomes the [[Hessian]] matrix $H$ (the $(n{+}1)\times(n{+}1)$ matrix of second partial derivatives - the same Hessian from [[CS229 PS0 - Solutions]]); $\nabla_\theta \ell$ is the vector of first derivatives:

$$\theta^{t+1} := \theta^t + H^{-1}\nabla_\theta \ell(\theta)$$

**Pros/cons (rule of thumb):**

- **Pro:** very few iterations ([[Quadratic convergence]]).
- **Con:** each iteration is expensive - must compute and invert the $n \times n$ [[Hessian]]. Inverting a huge matrix is costly.
- **Use Newton's method** when the number of parameters is small (~10-50) -> cheap Hessian, fast convergence.
- **Use [[Gradient descent]] / [[Gradient ascent]]** when there are many parameters (thousands+) -> Hessian inversion too expensive.

### End-of-lecture note

Andrew: next lecture (GLMs) is given by a TA (Anand) because Andrew is in Washington DC; he returns the following week. GLMs will show that [[Linear regression]] and [[Logistic regression]] are both special cases of one broader framework (the exponential family), and will derive the sigmoid from more basic principles.

## Notes in this lecture

![[Unit Preview.base]]
