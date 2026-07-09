---
aliases: Neovim (LazyVim) Cheatsheet
dateCreated: 2026-05-13 23:20:46
dateModified: 2026-05-25 21:59:39
linter-yaml-title-alias: Neovim (LazyVim) Cheatsheet
tags: 42
title: Neovim (LazyVim) Cheatsheet
---

# Neovim (LazyVim) Cheatsheet

Leader key = Space

## Modes

| Key      | Action                                |
| -------- | ------------------------------------- |
| `i`      | Insert mode (type text)               |
| `Esc`    | Back to Normal mode                   |
| `v`      | Visual mode (select text)             |
| `V`      | Visual Line mode (select whole lines) |
| `Ctrl+v` | Visual Block mode (select columns)    |
| `:`      | Command mode                          |
| `R`      | Replace mode                          |

## Moving Around

| Key         | Action                          |
| ----------- | ------------------------------- |
| `h j k l`   | Left, Down, Up, Right           |
| `w`         | Jump forward one word           |
| `b`         | Jump backward one word          |
| `e`         | Jump to end of word             |
| `0`         | Start. of. line                 |
| `$`         | End of line                     |
| `^`         | First non-blank character       |
| `gg`        | Top of file                     |
| `G`         | Bottom of file                  |
| `{`         | Previous paragraph/block        |
| `}`         | Next paragraph/block            |
| `Ctrl+d`    | Half page down                  |
| `Ctrl+u`    | Half page up                    |
| `%`         | Jump to matching bracket        |
| `f{char}`   | Jump to next {char} on line     |
| `F{char}`   | Jump to previous {char} on line |
| `:{number}` | Go to line number               |

## Editing

| Key | Action |
|---|---|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |
| `x` | Delete character |
| `dd` | Delete line |
| `dw` | Delete word |
| `d$` or `D` | Delete to end of line |
| `cc` | Change (delete) line and enter insert |
| `cw` | Change word |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ci{` | Change inside braces |
| `yy` | Copy (yank) line |
| `yw` | Copy word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last action |
| `>>` | Indent line |
| `<<` | Unindent line |
| `~` | Toggle case |
| `J` | Join line below to current |

## The "Verb + Noun" Pattern

Combine an action with a motion. Once you get this, you get nvim.

| Action | Meaning |
|---|---|
| `d` | Delete |
| `c` | Change (delete + insert mode) |
| `y` | Yank (copy) |
| `v` | Select |

| Target | Meaning |
|---|---|
| `w` | Word |
| `iw` | Inner word |
| `i"` | Inside quotes |
| `i(` | Inside parentheses |
| `i{` | Inside braces |
| `it` | Inside HTML tag |
| `ap` | A paragraph |
| `$` | To end of line |
| `gg` | To top of file |
| `G` | To bottom of file |

Examples: `diw` = delete inner word, `ci"` = change inside quotes, `yap` = yank a paragraph, `dG` = delete to end of file, `vit` = select inside HTML tag.

## Search and Replace

| Key | Action |
|---|---|
| `/text` | Search forward |
| `?text` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |

## Splits and Windows

| Key | Action |
|---|---|
| `:vs` | Vertical split |
| `:sp` | Horizontal split |
| `Ctrl+w h/j/k/l` | Move between splits |
| `Ctrl+w =` | Equal split sizes |
| `Ctrl+w >/<` | Resize width |
| `Ctrl+w +/-` | Resize height |
| `:q` | Close current split |

## LazyVim Specific (Space = Leader)

### File Navigation

| Key | Action |
|---|---|
| `Space Space` | Find files |
| `Space ff` | Find files |
| `Space fr` | Recent files |
| `Space fg` | Find in git files |
| `Space sg` | Live grep (search text in project) |
| `Space sw` | Search current word |
| `Space e` | File explorer (neo-tree) |
| `Space ,` | Switch buffers |

### Buffers

| Key | Action |
|---|---|
| `Space bb` | Switch buffer |
| `Space bd` | Delete buffer |
| `Space bo` | Close other buffers |
| `H` | Previous buffer |
| `L` | Next buffer |

### Code/LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `Space ca` | Code action |
| `Space cr` | Rename symbol |
| `Space cd` | Line diagnostics |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `Space cf` | Format file |

### Git (LazyVim)

| Key | Action |
|---|---|
| `Space gg` | Open lazygit |
| `Space gf` | Git file history |
| `Space gb` | Git blame |
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `Space ghp` | Preview hunk |
| `Space ghr` | Reset hunk |
| `Space ghs` | Stage hunk |

### UI and Toggles

| Key | Action |
|---|---|
| `Space ul` | Toggle line numbers |
| `Space uw` | Toggle word wrap |
| `Space ud` | Toggle diagnostics |
| `Space uf` | Toggle format on save |
| `Space us` | Toggle spelling |

### Terminal

| Key | Action |
|---|---|
| `:terminal` | Open terminal in buffer |
| `Ctrl+\ Ctrl+n` | Exit terminal mode (two separate presses) |
| `Space ft` | Float terminal |

### Plugin Management

| Key | Action |
|---|---|
| `:Lazy` | Open plugin manager |
| `S` (in Lazy) | Sync plugins |
| `U` (in Lazy) | Update plugins |
| `I` (in Lazy) | Install missing |

## Saving and Quitting

| Key | Action |
|---|---|
| `:w` | Save |
| `:q` | Quit |
| `:wq` or `ZZ` | Save and quit |
| `:q!` | Quit without saving |
| `:qa!` | Quit all without saving |
| `:wa` | Save all buffers |

## Marks and Jumps

| Key | Action |
|---|---|
| `ma` | Set mark "a" at cursor |
| `'a` | Jump to mark "a" |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |

## Macros

| Key | Action |
|---|---|
| `qa` | Start recording macro into register "a" |
| `q` | Stop recording |
| `@a` | Play macro "a" |
| `@@` | Replay last macro |
| `10@a` | Play macro "a" 10 times |

## The Tools Behind LazyVim

These CLI tools power LazyVim's search features. They also work standalone in your terminal.

### Ripgrep (rg) - Searches Text inside Files

Powers `Space sg` (live grep) and `Space sw` (search word) in LazyVim.

| Command | Action |
|---|---|
| `rg "text" .` | Search all files for "text" |
| `rg "text" --type py` | Search only Python files |
| `rg "text" -i` | Case insensitive search |
| `rg "text" -l` | Only show filenames with matches |
| `rg "text" -C 3` | Show 3 lines of context around matches |
| `rg "TODO\|FIXME" .` | Search for multiple patterns |
| `rg "text" --glob "*.tsx"` | Search only in .tsx files |

### Fd -- Finds Files by name

Powers `Space Space` and `Space ff` (find files) in LazyVim.

| Command | Action |
|---|---|
| `fd "name"` | Find files matching "name" |
| `fd -e tsx` | Find all .tsx files |
| `fd -e py src/` | Find .py files in src/ |
| `fd -H` | Include hidden files |
| `fd -t d` | Find only directories |
| `fd -t f` | Find only files |
| `fd "test" --exclude node_modules` | Exclude a directory |

### Fzf - Fuzzy Finder for Anything

| Command | Action |
|---|---|
| `Ctrl+R` | Fuzzy search command history (in terminal) |
| `Ctrl+T` | Fuzzy find files (in terminal) |
| `ls \| fzf` | Pipe anything into fuzzy filter |
| `fd -e py \| fzf` | Find Python files then fuzzy filter |
| `rg -l "text" \| fzf` | Find files containing text then pick one |
| `cat file \| fzf` | Fuzzy search through file contents |
| `nvim $(fzf)` | Fuzzy find a file and open it in nvim |

### Lazygit - Full Git TUI

Opened inside nvim with `Space gg`, or run `lazygit` in terminal.

| Key (inside lazygit) | Action |
|---|---|
| `space` | Stage/unstage file |
| `c` | Commit |
| `p` | Pull |
| `P` | Push |
| `s` | Stash |
| `b` | Branches |
| `?` | Help menu |
| `q` | Quit |

### Gh - GitHub CLI

| Command | Action |
|---|---|
| `gh auth login` | Authenticate with GitHub |
| `gh repo create` | Create a new repo |
| `gh repo clone user/repo` | Clone a repo |
| `gh pr create` | Create a pull request |
| `gh pr list` | List open PRs |
| `gh pr checkout 42` | Checkout PR |
| `gh issue list` | List issues |
| `gh issue create` | Create an issue |
| `gh browse` | Open repo in browser |

## Pro Tips

1. Numbers multiply commands: `5dd` deletes 5 lines, `3w` jumps 3 words
2. `.` repeats your last change, use it constantly
3. `ciw` then `.` on other words = fast multi-replace
4. `Space sg` (live grep) is your best friend for finding anything in a project
5. `Space gg` opens lazygit which is a full git UI inside nvim
6. `gd` to jump to definition, `Ctrl+o` to jump back
7. In visual mode, `>` and `<` indent/unindent selections
8. `Ctrl+a` and `Ctrl+x` increment/decrement numbers
9. `:earlier 5m` undoes all changes from the last 5 minutes
10. `ZZ` is faster than `:wq`

---
