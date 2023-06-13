vim.cmd([[
set notimeout
set encoding=utf-8
]])

function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
function nmap(shortcut, command)
    map("n", shortcut, command)
end
function imap(shortcut, command)
    map("i", shortcut, command)
end
function vmap(shortcut, command)
    map("v", shortcut, command)
end

-- runtime! debian.vim

-- vim.&packpath = &runtimepath
-- lua require('plugins')
require("plugins")
-- vim.opt.background = "dark"
-- vim.cmd([[colorscheme gruvbox]])
-- hi Normal guibg=NONE ctermbg=NONE

-- vim.opt.runtimepath^=~/.vim runtimepath+=~/.vim/after

-- Declare the list of plugins.
-- Plug 'morhetz/gruvbox'
-- Plug 'vim-airline/vim-airline'
-- Plug 'justinmk/vim-sneak'
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
-- Plug 'junegunn/fzf.vim'
-- Plug 'SirVer/ultisnips'
-- Plug 'honza/vim-snippets'
-- call plug#end()

-- better key bindings for UltiSnipsExpandTrigger
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

-- vim.g.sneak#s_next = 1

-- vim.opt.statusline+=%{ObsessionStatus()}
-- vim.g.airline#extensions#tabline#enabled = 1
-- vim.g.airline#extensions#tabline#formatter = 'unique_tail_improved'
-- vim.g.airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%%', 'linenr', ':%3v', ' %L'])

-- autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
-- autocmd BufReadPost *.php set filetype=html.php.css
-- autocmd BufReadPost *.php set syntax=php

-- opt.linebreak = true
-- opt.breakindent = true
-- opt.expandtab = true
-- opt.relativenumber = true

vim.opt.shiftwidth=4
vim.opt.tabstop=4
-- vim.opt.clipboard+=unnamedplus
-- vim.opt.list
-- vim.opt.lcs=tab:»_,trail:·

-- set noexpandtab tabstop=4 shiftwidth=4

nmap("<silent> <C-S>", ":update<CR>")
vmap("<silent> <C-S>", "<C-C>:update<CR>")
imap("<silent> <C-S>", "<C-O>:update<CR>")
nmap("<C-p>", ":Buffers<Cr>")
nmap("<C-l>", ":Ag<Cr>")

-- vim.opt.directory^=$HOME/.vim/tmp//

vmap("<C-y>", "\"+y")
vim.opt.background=dark

-- hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan

imap("(", "()<left>")
imap("[", "[]<left>")

-- delete without yanking
nmap("<leader>d", "\"_d")
vmap("<leader>d", "\"_d")

-- replace currently selected text with default register
-- without yanking it
vmap("p", "\"_dP")

nmap("<C-e>", "5<C-e>")
nmap("<C-y>", "5<C-y>")
nmap("<F8>", ":Obsession<CR>")
nmap("<F1>", ":pwd<CR>")
nmap("<F4>", ":Tex<CR>")
nmap("<MiddleMouse>", ":tabclose<CR>")

-- map! <C-v> <C-S-r>" 
nmap("<2-LeftMouse>", "viw")

nmap("[[", "?{<CR>w98[{")
nmap("]]", "j0[[%/{<CR>")
nmap("][", "/}<CR>b99]}")
nmap("[]", "k$][%?}<CR>")

nmap("f", "<Plug>Sneak_s")
nmap("F", "<Plug>Sneak_S")

vim.mapleader = "\\"
vim.opt.wildmode=full

-- Session management
sessions_dir = "~/vim-session"

-- vim.opt.&t_SI = "\e[6 q"
-- vim.opt.&t_EI = "\e[2 q"

-- Remaps for Sessions
nmap("<Leader>ss", ":Ob" .. sessions_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>")
nmap("<Leader>so", ":so" .. sessions_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>")

