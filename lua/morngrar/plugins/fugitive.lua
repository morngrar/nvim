return { "tpope/vim-fugitive",
  vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "[G]it" })
}

-- vim: ts=2 sts=2 sw=2 expandtab
