```tikz
\usepackage{circuitikz}
\usetikzlibrary{positioning}

\begin{document}

\newcommand{\height}{9}
\newcommand{\gatespace}{3}

\newcommand{\inputline}[1]{
	\draw (inputs) node[above](#1){$#1$}
		-- +(0,-\height) coordinate(#1 end)
		++(0,-1) to[s out] ++(1,0)
		-- ++(0,-1) node[in not](not #1){}
		(not #1.out) -- (not #1.out |- #1 end)
		(not #1.out |- 0,0) +(1,0) coordinate(inputs)
		(not #1.out) +(\gatespace,-1) coordinate(gatestart)
}
\newcommand{\inputlinesolo}[1]{
	\draw (inputs) node[above](#1){$#1$}
		-- +(0,-\height) coordinate(#1 end)
		(#1 |- 0,0) +(1,0) coordinate(inputs)
		(#1) +(\gatespace,-4) coordinate(gatestart)
}
\newcommand{\gateinput}[2]{
	(#1 |- #2) to [s out] (#2)
}

\begin{circuitikz}[
	s out/.style={short,*-},
	in not/.style={not port,anchor=in,rotate=-90}
]
    \coordinate (inputs) at (0,0);
\end{circuitikz}

\end{document}
```
