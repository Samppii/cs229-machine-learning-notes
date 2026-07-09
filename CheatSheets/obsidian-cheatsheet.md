---
aliases:
  - Obsidian Cheatsheet
  - Obsidian Vault Cheatsheet
  - Obsidian Vault Guide
dateCreated: 2026-05-25 22:22:48
dateModified: 2026-05-25 22:53:11
linter-yaml-title-alias: Obsidian Vault Cheatsheet
tags:
  - 1
  - reference
title: Obsidian Vault Cheatsheet
TQ_explain: true
TQ_extra_instructions:
TQ_short_mode:
TQ_show_backlink:
TQ_show_cancelled_date:
TQ_show_created_date:
TQ_show_depends_on:
TQ_show_done_date:
TQ_show_due_date:
TQ_show_edit_button:
TQ_show_id:
TQ_show_on_completion:
TQ_show_postpone_button:
TQ_show_priority:
TQ_show_recurrence_rule:
TQ_show_scheduled_date:
TQ_show_start_date:
TQ_show_tags:
TQ_show_task_count:
TQ_show_tree:
TQ_show_urgency:
---

# Obsidian Vault Cheatsheet

How to actually use this vault — getting around, linking, tagging, and organizing topics into folders. (Vim mode is OFF in Obsidian, so just click into a note and type.)

## The Mental Model (read This first)

Three independent things connect your notes. **None of them depend on folders.**

| Thing | What it's for | Example |
|---|---|---|
| **Links** | Direct connection between two notes | `[[Group]]` |
| **Tags** | Categories / filters across many notes | `#school/math/110a` |
| **Properties** | Structured metadata at the top of a note | `title:`, `aliases:`, `up:` |
| **Folders** | *Just* for your own browsing convenience | `School/Math 110A/` |

Key idea: a link from note A to note B works **no matter what folders they live in**. So you can organize topics into folders *and* link everything together freely — they don't fight each other.

## Essential Keys (the 8 You'll Use constantly)

| Key | Action |
|---|---|
| `Cmd+O` | **Quick switcher** — jump to any note by typing its name. Your tool. |
| `Cmd+P` | Command palette — run *any* command by name |
| `Cmd+Shift+F` | Search text across all notes |
| `Cmd+N` | New note |
| `Cmd+Click` | Open a link in a new pane (split) |
| `Cmd+E` | Toggle Editing / Reading view |
| `Cmd+Shift+T` | Insert a template |
| `Cmd+Enter` | Toggle a task done / off |

## Creating Notes & Templates

1. `Cmd+N` makes a new note — name it (the file name *is* the title).
2. `Cmd+Shift+T` → pick a template (`concept`, `daily-note`, `session`, …).
3. The **concept** template auto-fills the `title`, `aliases` (including plural forms), and the `# Heading` for you.

> Templates only run inside the Obsidian app (they use Templater). If you edit a note in Neovim, the template code won't execute — so create templated notes in Obsidian, edit prose anywhere.

## Linking between Notes

Type `[[` and Obsidian autocompletes note names.

| Syntax | Result |
|---|---|
| `[[Group]]` | Link to the note "Group" |
| `[[Group\|groups]]` | Link, but display the text "groups" |
| `[[Group#Axioms]]` | Link straight to the "Axioms" heading |
| `[[Group^a1b2]]` | Link to a specific block (type `^` to pick one) |
| `![[Group]]` | **Embed** the whole note inline |
| `![[Group#Summary]]` | Embed just one section |
| `![[diagram.excalidraw]]` | Embed a drawing/image |

- **Backlinks**: every note shows "what links here" at the bottom (and in the Backlinks pane). This is how related notes find each other automatically.
- **Aliases** (in frontmatter) let a note be linked by other names — e.g. with `aliases: [groups]`, typing `[[groups]]` still links to `Group`.
- **Rename freely**: rename a note and every link to it updates automatically (this vault has "always update links" on).

## Tags

Write `#tag` anywhere in a note, or list them in frontmatter under `tags:`.

| Pattern | Use |
|---|---|
| `#networking` | A simple topic tag |
| `#school/csc/151` | **Nested** tag — groups like a tree in the Tag pane |
| `#atom` | This vault's marker for a single-concept note |
| `#index` | Marks a hub / Map-of-Content note (see below) |

- Click any tag (or open the **Tag pane**) to see every note that has it.
- Search `tag:#school/math` in search to filter.
- **Rename a tag everywhere**: right-click it in the Tag pane → Rename (the Tag Wrangler plugin does this safely across all notes).

**Tags vs links**: tags group *many* notes loosely (a category); links connect *two* notes directly. Use tags for "what kind of thing is this," links for "this relates to that."

## Properties (the `---` Block at the top)

| Property | Meaning |
|---|---|
| `title` | Display title (shown as the `# Heading`) |
| `aliases` | Other names this note can be linked/searched by |
| `tags` | Its categories |
| `dateCreated` / `dateModified` | Maintained automatically by the Linter |
| `up` | The "parent" note of this one |
| `units` | The topic/index this note belongs to |

> `up:` and `units:` are navigated by the **Breadcrumbs** plugin, which is currently **disabled**. If you want clickable parent/child trails, re-enable it: Settings → Community plugins → Breadcrumbs. Otherwise they're just metadata.

## Organizing Topics into Folders + Linking Them

The friend's original setup is **flat** (every note in the root, connected only by links/tags). You wanted **folders per topic** — totally fine. Here's a clean structure:

```
School/
  Math 110A/
    Group.md
    Subgroup.md
    Math 110A.md        <- the topic's INDEX note (#index)
  CSC 151/
    Compiler.md
    Backend.md
    CSC 151.md          <- index note
DnD/
  Campaign/
  NPCs/
calendar/              <- daily notes land here
assets/                <- images & attachments (automatic)
archive/               <- old notes you want out of the way
templates/             <- template files (don't edit notes here)
```

**Making/using folders**
- New folder: right-click in the file explorer → New folder.
- Move a note: drag it in, or right-click → Move file to… (links auto-update).

**How to tie a topic together (the important part):**
Each topic folder gets **one index note** (a "Map of Content"), tagged `#index`, that links to everything in that topic. It's the hub. Two ways to fill it:

- **Manually** — just list links:

  ```
  ## Group Theory
  - [[Group]]
  - [[Subgroup]]
  - [[Cyclic Group]]
  ```

- **Automatically with Dataview** — list every note in the folder:

  ````
  ```dataview
  LIST
  FROM "School/Math 110A"
  WHERE file.name != this.file.name
  SORT file.name ASC
  ```
  ````

Then inside each concept note, link to its index (`units: "[[Math 110A]]"`) and to related concepts (`[[Subgroup]]`). Now the topic is a connected web: the index links out, each note links to siblings, and backlinks tie it all back.

## Dashboards & Queries

- **`Home.md`** — your front page: recent notes, all `#atom` notes, and open tasks (built with Dataview).
- **`Atoms.base`** — a sortable/filterable **table** of all `#atom` notes (the Bases feature). Open it like any note.
- **Dataview** — drop a query into any note to auto-generate lists/tables. Example "all notes tagged networking":

  ````
  ```dataview
  LIST
  FROM #networking
  ```
  ````

## Tasks

- Write one: `- [ ] Finish lab 3 📅 2026-06-01` (the 📅 sets a due date).
- Toggle done: `Cmd+Enter` on the line.
- Easier date entry: `Cmd+P` → **Tasks: Create or edit task** (a form with date pickers).
- Your **daily note** embeds a live view of all tasks grouped by due date.

## Daily Notes

- Open the **Calendar** in the right sidebar and click a day — or `Cmd+P` → "Open today's daily note".
- Uses the `daily-note` template; files land in `calendar/`.

## Math Notes

| Syntax | Result |
|---|---|
| `$a^2 + b^2 = c^2$` | Inline math |
| `$$ \int_0^1 x^2\,dx $$` | Block (centered) math |
| ` ```tikz ` block | TikZ diagrams (TikZJax) |

- **Math Booster** auto-numbers and lets you reference theorems/equations.
- **LaTeX Suite** has fast snippets — e.g. typing `dm` expands to `$$ $$`, fractions auto-format. (See its settings for the snippet list.)

## Drawings & Attachments

- **Excalidraw**: `Cmd+P` → "Excalidraw: Create new drawing", then embed with `![[drawing]]`.
- **Images**: paste or drag into a note — it's saved to `assets/` automatically and embedded.

## D&D Tools (when You Run a game)

- **Dice Roller**: write `` `dice: 1d20+5` `` to get a clickable roll.
- **Initiative Tracker**: `Cmd+P` → Initiative Tracker commands to manage combat turn order.
- **Leaflet** (maps) and **Calendarium** (in-world calendars) for worldbuilding.

## A Worked Example — Starting a New Class

1. Make a folder `School/Networking`.
2. New note `Networking` inside it, tag it `#index` — this is the class hub.
3. As you learn concepts, make a note each (`Packet`, `Latency`, …) with the `concept` template, tag `#atom` + `#school/networking`, drop them in the folder.
4. In each concept set `units: "[[Networking]]"` and link related ones (`[[Packet]]` mentions `[[Latency]]`).
5. In the `Networking` index note, add a Dataview block to auto-list everything in the folder.
6. Use `Cmd+O` to jump around, `Cmd+Shift+F` to search, and the backlinks pane to see how concepts connect.

## Pro Tips

1. `Cmd+O` (quick switcher) is faster than hunting the file tree — learn it first.
2. Don't agonize over folders. Links and tags do the real organizing; folders are just tidy drawers.
3. One concept = one short note. Small notes link better than big ones.
4. Give important notes `aliases` so you can link them by natural phrasing.
5. Make an `#index` note per topic — it's the map that keeps a subject from scattering.
6. `Cmd+Click` a link to open it beside the current note (great for comparing).
7. Rename fearlessly — links follow.
8. The Linter auto-tidies frontmatter/formatting when you save; let it.

---
