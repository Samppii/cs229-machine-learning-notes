" Yank/paste through the system clipboard
set clipboard=unnamed

" Quick escape from insert mode
imap jj <Esc>

" ===================== Leader = <Space>, LazyVim-style =====================
" Placed FIRST so nothing below can block them if a later line errors.

" <Space><Space> / <Space>ff  -> quick switcher = find & switch notes
exmap quickSwitch obcommand switcher:open
nmap <Space><Space> :quickSwitch<CR>
nmap <Space>ff :quickSwitch<CR>

" <Space>e  -> toggle the left sidebar / file explorer
exmap toggleExplorer obcommand app:toggle-left-sidebar
nmap <Space>e :toggleExplorer<CR>

" <Space>/ / <Space>sg  -> search across all notes
exmap globalSearch obcommand global-search:open
nmap <Space>/ :globalSearch<CR>
nmap <Space>sg :globalSearch<CR>

" <Space>fr  -> reveal current file in the explorer tree
exmap revealFile obcommand file-explorer:reveal-active-file
nmap <Space>fr :revealFile<CR>

" ===================== Visual-line nav (kept last, harmless) ================
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj
