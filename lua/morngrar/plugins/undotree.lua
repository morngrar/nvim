return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, { desc = "[T]oggle [U]ndotree" })
  end
}
-- vim: ts=2 sts=2 sw=2 expandtab
