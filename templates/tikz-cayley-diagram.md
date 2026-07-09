```tikz
\begin{document}

\usetikzlibrary{graphs}
\usetikzlibrary{arrows.meta}

\begin{tikzpicture}[
    scale=2.0,
    every node/.style={font=\large},
    every >/.style={stealth},
    op1/.style={>violet},
]
    \graph[no placement,math nodes]{
        e <-> g [x=1,op1]
    };
\end{tikzpicture}

\end{document}
```
