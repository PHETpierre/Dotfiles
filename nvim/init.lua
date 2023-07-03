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
require("mason").setup()
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

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
    autocmd BufEnter * silent! lcd %:p:h

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

	noremap <C-x>          :Tabularize /=<CR>

	set directory^=$HOME/.vim/tmp//
	map! <C-v> <C-S-r>" 

	hi Normal guibg=NONE ctermbg=NONE
	hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan
	hi Search cterm=none ctermbg=darkgrey
	hi IncSearch cterm=none ctermbg=darkgrey

    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
]])

-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'gruvbox',
--     component_separators = { left = '' },
--     section_separators = { left = '' },
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }

-- set noexpandtab tabstop=4 shiftwidth=4

-- nmap("<silent> <C-S>", ":update<CR>")
-- vmap("<silent> <C-S>", "<C-C>:update<CR>")
-- imap("<silent> <C-S>", "<C-O>:update<CR>")
nmap("<C-p>", ":Buffers<Cr>")
nmap("<C-l>", ":Files<Cr>")
nmap("<leader>fa", ":Ag<Cr>")
-- nmap("<leader>fb", ":BLines<Cr>")

-- vmap("<C-y>", "\"+y")

-- hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan

imap("(", "()<left>")
imap("[", "[]<left>")

imap("<F9>", "<C-O>za")
nmap("<F9>", "za")
vmap("<F9>", "zf")
-- onoremap <F9> <C-C>za

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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fl', builtin.loclist, {})
-- vim.keymap.set('n', '<leader>fr', builtin.lsp_reference, {})
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_definitions, {})

local actions = require "telescope.actions"
local telescope = require "telescope"

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
            },
        },
    },
}

-- nmap{"<C-f>", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<CR>"}
-- nmap{"<leader>dl", "<cmd>Telescope diagnostics<cr>"}
