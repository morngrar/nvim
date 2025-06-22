return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<S-M-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<S-M-j>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<S-M-k>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<S-M-l>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<S-M-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<S-M-N>", function() harpoon:list():next() end)
  end
}
-- vim: ts=2 sts=2 sw=2 expandtab
