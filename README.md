# CS229 Machine Learning Notes

My personal notes for Stanford's CS229 (Machine Learning, taught by Andrew Ng), kept as an [Obsidian](https://obsidian.md) vault. I write them as a Zettelkasten: one idea per note, connected by links and tags instead of folders.

## What's inside

Each lecture is broken down into small atomic notes (one concept each) plus a lecture hub that ties them together.

- **Lecture 1, Introduction:** what machine learning is, the main paradigms (supervised, unsupervised, and reinforcement learning, learning theory, deep learning), and the core vocabulary (regression, classification, clustering, features).
- **Lecture 2, Linear Regression:** the hypothesis, the least squares cost function, gradient descent (batch, stochastic, and mini-batch), convexity, and the normal equations closed form solution. Also implemented from scratch in numpy (see below).

More lectures will be added as I work through the course.

## Code practice

Alongside the notes, I implement each lecture's algorithms from scratch in numpy to connect the math to code. These live in the `CodePractice/` folder as Jupyter notebooks, each paired with a math-to-code cheat sheet.

- **Lecture 2, Linear Regression:** `CodePractice/Lecture_2_Linear_Regression_Code_Practice.ipynb` builds toy data, the cost function, batch and stochastic gradient descent, and the normal equation, all recovering the known parameters. The companion `CS229 Lecture 2 Code Cheatsheet.md` maps each formula to its numpy line, with a shape reference for tracking array dimensions.

## How it's organized

- **Atoms** (`#atom`): one idea per note, kept short.
- **Hubs** (`#index`): maps of content that link the atoms for a topic or lecture.
- **Links, not folders:** notes reference each other with `[[wikilinks]]`; the `units` and `up` properties record which hub or parent a note belongs to.

The vault is flat, so the folders are just light tidiness (attachments, templates, scripts, and code practice).

## Using it

Open the folder as a vault in Obsidian. The notes are plain Markdown with LaTeX math (MathJax), so they also read fine on GitHub or in any Markdown viewer.

Some interactive features (Dataview queries, the `.base` dashboards, Templater templates) rely on community plugins. The enabled list lives in `.obsidian/community-plugins.json`; install those from Obsidian's community browser for full rendering. Plugin binaries are not committed.

## License

The notes (the Markdown content I wrote) are licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](LICENSE). You are free to share and adapt them, with attribution.

Obsidian configuration, templates, and helper scripts are tooling and are not covered by that license.

## Disclaimer

These are my own study notes based on Stanford's publicly available CS229 course. They are not official course material and are not affiliated with or endorsed by Stanford University or the instructors. Any mistakes are mine.
