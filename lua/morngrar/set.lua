
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.errorbells = false

vim.opt.ignorecase = true
vim.opt.smartcase = true


-- My old sets:

--" vim-closetag config:
--let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
--let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
--let g:closetag_filetypes = 'html,js'
--let g:closetag_xhtml_filetype = 'xhtml,jsx,tsx'
--let g:closetag_emptyTags_caseSensitive = 1
--let g:closetag_regions = {
--  \ 'typescript.tsx': 'jsxRegion,tsxRegion',
--  \ 'javascript.jsx': 'jsxRegion',
--  \ }
--let g:closetag_shortcut = '>'



--" Bullets.vim
--"let g:bullets_enabled_file_types = [
--"    \ 'markdown',
--"    \ 'text',
--"    \ 'gitcommit',
--"    \ 'scratch'
--"    \]








-- Disable language provider support (lua and vimscript plugins only)
-- This is an optimization step to lower the footprint of nvim
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0


