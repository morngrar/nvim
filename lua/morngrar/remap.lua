vim.g.mapleader = " "

-- show file browser "Project View"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- highlighted moving of lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place on J'ing
vim.keymap.set("n", "J", "mzJ`z")

-- Vertically center cursor when navigating up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center search jumps
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Overwrite-P
vim.keymap.set("x", "<leader>p", "\"_dP")

-- System clipboard yanking (believe it only works in neovim)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- deleting to void register in normal and visual mode
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- For later, if adopting theprimeagen's tmux-session workflow
-- https://youtu.be/w7i4amO_zaE?t=1699
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- have the LSP format the current buffer (?)
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "lnext")
vim.keymap.set("n", "<leader>j", "lprev")

-- Replace all occurrences of current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


-- TODO: Examples of autocmd's in lua: 
-- https://github.com/ThePrimeagen/init.lua/commit/cb210006356b4b613b71c345cb2b02eefa961fc0
-- https://github.com/ThePrimeagen/init.lua/commit/4a96e6457b0a0241ca7361ce62177aa6b9a33a38

-- OLD REMAPS

-- nnoremap <leader>wv :vsp % :wincmd l<CR>
-- nnoremap <leader>ws :split % :wincmd j<CR>
-- nnoremap <leader>wq :close<CR>
--
-- nnoremap <silent> <Leader>+ :vertical resize +5<CR>
-- nnoremap <silent> <Leader>- :vertical resize -5<CR>
-- nnoremap <silent> <Leader>d+ :resize +5<CR>
-- nnoremap <silent> <Leader>d- :resize -5<CR>
--
-- nnoremap <F2> :set tw=0 nowrap nolinebreak cc=0<cr>
-- nnoremap <F3> :set tw=79 wrap linebreak cc=80<cr>
-- nnoremap <F4> :set spell<cr>
-- nnoremap <F5> :set nospell<cr>
--
--
--
--
--
-- " Remap ø and æ to [ ] for spelling stuff
-- nnoremap øs [s
-- nnoremap øS [S
-- nnoremap æs ]s
-- nnoremap æS ]S
--
-- " general fugitive remaps
-- nnoremap <leader>gg :Git<cr>
-- nnoremap <leader>gp :Git push<cr>
-- nnoremap <leader>gl :Git log<cr>
-- nnoremap <leader>gL :Git log --graph<cr>
--
--
-- --" Easier pasting (snagged from https://github.com/tpope/vim-unimpaired)
-- --function! s:setup_paste() abort
-- --  let s:paste = &paste
-- --  set paste
-- --endfunction
-- --
-- --nnoremap <silent> yp  :call <SID>setup_paste()<CR>a
-- --nnoremap <silent> yP  :call <SID>setup_paste()<CR>i
-- --nnoremap <silent> yo  :call <SID>setup_paste()<CR>o
-- --nnoremap <silent> yO  :call <SID>setup_paste()<CR>O
-- --nnoremap <silent> yA  :call <SID>setup_paste()<CR>A
-- --nnoremap <silent> yI  :call <SID>setup_paste()<CR>I
-- --nnoremap <silent> ygi :call <SID>setup_paste()<CR>gi
-- --nnoremap <silent> ygI :call <SID>setup_paste()<CR>gI
-- --
-- --augroup unimpaired_paste
-- --  autocmd!
-- --  autocmd InsertLeave *
-- --        \ if exists('s:paste') |
-- --        \   let &paste = s:paste |
-- --        \   unlet s:paste |
-- --        \ endif
-- --augroup END
--
--
--
--
-- "
-- " filetype specific configs (autocmd)
-- "
--
-- " go
-- autocmd FileType go nmap <leader>t  <Plug>(go-test)
-- autocmd FileType go nmap <leader>b  <Plug>(go-build)
-- autocmd FileType go nmap <leader>r  <Plug>(go-run)
-- autocmd FileType go nmap <leader>L  <Plug>(go-lint)
-- autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
-- autocmd FileType go set noexpandtab
-- autocmd FileType go set autowrite
-- " commenting and uncommenting
-- autocmd FileType go vmap <leader>, :norm i//<cr>
-- autocmd FileType go vmap <leader>. :s/\/\///<cr> :noh<cr>
--
-- " snippets
-- autocmd FileType go imap ifr<Tab> <Esc>:.!snip go if-err-not-nil<CR>jA<Tab>
--
-- " python
-- autocmd FileType python nmap <leader>r :w<cr> :!python %<cr>
-- " type check current file with mypy
-- autocmd FileType python nmap <leader>c :!mypy %<cr>
-- " commenting and uncommenting
-- autocmd FileType python vmap <leader>, :norm i#<cr>
-- autocmd FileType python vmap <leader>. :s/#//<cr> :noh<cr>
--
-- let g:go_highlight_types = 1
-- let g:go_highlight_fields = 1
-- let g:go_highlight_functions = 1
--
--
--
-- " commenting and uncommenting in .js and .jsx files
-- autocmd FileType javascript vmap <leader>, :norm i//<cr>
-- autocmd FileType javascript vmap <leader>. :s/\/\///<cr> :noh<cr>
-- autocmd FileType javascriptreact vmap <leader>, :norm i//<cr>
-- autocmd FileType javascriptreact vmap <leader>. :s/\/\///<cr> :noh<cr>
-- autocmd FileType jsx vmap <leader>, :norm i//<cr>
-- autocmd FileType jsx vmap <leader>. :s/\/\///<cr> :noh<cr>
--
--
--
-- " markdown
-- autocmd FileType markdown set wrap
-- autocmd FileType markdown set linebreak
-- autocmd FileType markdown set cc=0
-- autocmd FileType markdown nmap <leader>b :w<cr>:!pandoc -V geometry:a4paper -o out.pdf %<cr>:!xdg-open out.pdf<cr>
-- autocmd FileType markdown vnoremap <leader>ze :!zetextract %<cr>:w<cr>
-- autocmd FileType markdown vnoremap <leader>l :!proselint %<cr>
-- autocmd FileType markdown nnoremap gf :w<cr>:e $HOME/zettel/<cfile>.md<cr>
-- autocmd FileType markdown nnoremap gl /[[<cr>w:noh<cr>
-- autocmd FileType markdown nnoremap <leader>zb !!zetbranch %<cr>:w<cr>j/[[<cr>w:noh<cr>:e $HOME/zettel/<cfile>.md<cr>4jA
-- autocmd FileType markdown nnoremap <leader>zc :!cat %<cr>
-- autocmd FileType markdown nnoremap <leader>zt o- [ ]
-- autocmd FileType markdown nnoremap <silent><leader>zl :!zetlink %<cr><cr>
-- " open zettel under cursor in new window
-- autocmd FileType markdown nnoremap <leader>zo :w<cr>:!zetopen -p <cfile><cr><cr>
-- " open current zettel in new window
-- autocmd FileType markdown nnoremap <leader>zO :w<cr>:!zetopen -f -p %<cr><cr>
--
--
-- " latex
-- autocmd FileType tex set wrap
-- autocmd FileType tex set tw=79
-- autocmd FileType tex set linebreak
-- autocmd FileType tex nmap <leader>b :w<cr>:!make<cr> :!make view<cr>
-- autocmd FileType tex nmap <leader>m :w<cr>:!make<cr>
-- autocmd FileType tex nmap <leader>c :w<cr>:!make clean<cr>
-- " commenting and uncommenting
-- autocmd FileType tex vmap <leader>, :norm i%<cr>
-- autocmd FileType tex vmap <leader>. :s/%//<cr> :noh<cr>
--
--
-- " bash
-- autocmd FileType bash nmap <leader>r :w<cr> :!./%<cr>
-- autocmd FileType bash nnoremap <leader>c :w<cr> :!shellcheck %<cr>
--
