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

-- lua require('plugins')
require("plugins")

vim.opt.background = 'dark'
vim.cmd([[
    runtime! debian.vim
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    colorscheme gruvbox
]])

-- better key bindings for UltiSnipsExpandTrigger
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

vim.cmd([[
	set nocompatible
	filetype off

	filetype plugin indent on
	let g:sneak#s_next = 1

	set statusline+=%{ObsessionStatus()}
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%%', 'linenr', ':%3v', ' %L'])

	autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
	autocmd BufReadPost *.php set filetype=html.php.css
	autocmd BufReadPost *.php set syntax=php

	set wrap
	set linebreak
	set number relativenumber 
	set breakindent
	set autoindent

	set shiftwidth=4
	set tabstop=4
	set expandtab
	set clipboard+=unnamedplus

	set list
	set lcs=tab:»_,trail:·

	noremap <silent> <C-S>          :update<CR>
	vnoremap <silent> <C-S>         <C-C>:update<CR>
	inoremap <silent> <C-S>         <C-O>:update<CR>
	nnoremap <C-p> :Buffers<Cr>

	set directory^=$HOME/.vim/tmp//
	map! <C-v> <C-S-r>" 

	hi Normal guibg=NONE ctermbg=NONE
	hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan
]])

-- set noexpandtab tabstop=4 shiftwidth=4

-- nmap("<silent> <C-S>", ":update<CR>")
-- vmap("<silent> <C-S>", "<C-C>:update<CR>")
-- imap("<silent> <C-S>", "<C-O>:update<CR>")
nmap("<C-p>", ":Buffers<Cr>")
nmap("<C-l>", ":Files<Cr>")

-- vmap("<C-y>", "\"+y")

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

nmap("<2-LeftMouse>", "viw")

nmap("[[", "?{<CR>w98[{")
nmap("]]", "j0[[%/{<CR>")
nmap("][", "/}<CR>b99]}")
nmap("[]", "k$][%?}<CR>")

nmap("f", "<Plug>Sneak_s")
nmap("F", "<Plug>Sneak_S")

vim.mapleader = "\\"
vim.cmd([[
	set wildmenu
	set wildmode=full
]])

-- Session management
sessions_dir = "~/vim-session"

vim.cmd([[
	let &t_SI = "\e[6 q"
	let &t_EI = "\e[2 q"
]])

-- Remaps for Sessions
nmap("<Leader>ss", ":Ob" .. sessions_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>")
nmap("<Leader>so", ":so" .. sessions_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>")

vim.cmd([[
	vmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)
	command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
]])
