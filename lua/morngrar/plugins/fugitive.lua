return { "tpope/vim-fugitive",
  vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "[G]it" }),
  vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git [b]lame" }),
}

-- vim: ts=2 sts=2 sw=2 expandtab
