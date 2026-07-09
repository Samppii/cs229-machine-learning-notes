---
prev: "[[
<%_
app.vault
    .getMarkdownFiles()
    .map(f => f.basename)
    .filter(basename => /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test(basename))
    .toSorted((a, b) => new Date(b) - new Date(a))
    [1]
_%>
]]"
tags: daily
title: <% tp.file.title %>
---

# <% tp.file.title %>

## Notepad

---

## Tasks

![[task-view]]
