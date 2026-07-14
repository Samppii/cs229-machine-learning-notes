---
dateCreated: 2026-05-25 21:35:50
dateModified: 2026-05-25 23:02:34
tags: index
title: Home
---

# Home

The Vault's front door. This is a Map of Content (MOC) - a hand-curated index note that links out to your topics. In a Zettelkasten you navigate by *links*, not folders.

## How This Vault Works

- **One idea = one note.** Make a short atomic note for each concept and tag it `atom`. Connect notes with `[[wikilinks]]`.
- **`up:` and `units:` properties** define hierarchy. `up:` points to a parent note; `units:` points to the topic/index a note belongs to. The **Breadcrumbs** plugin turns these into navigation.
- **Folders are only for special stuff**: `assets/` (images/attachments), `archive/` (old notes), `calendar/` (daily notes), `templates/`, `scripts/`.
- **Templates**: press `Cmd+Shift+T` to insert one. The `concept` template auto-fills aliases (including plurals).

## Maps of Content

Every topic hub (any note tagged `#index`) shows up here automatically.

```dataview
TABLE WITHOUT ID
  file.link AS "Topic",
  length(file.inlinks) AS "Notes",
  file.mtime AS "Updated"
FROM #index
WHERE file.name != this.file.name
SORT file.name ASC
```

## Recently Edited

```dataview
TABLE WITHOUT ID file.link AS "Note", dateModified AS "Modified"
WHERE file.name != this.file.name AND !contains(file.folder, "templates")
SORT dateModified DESC
LIMIT 10
```

## All Atomic Notes

```dataview
LIST
FROM #atom
SORT file.name ASC
```

## Open Tasks

```tasks
not done
sort by due
limit 15
```
