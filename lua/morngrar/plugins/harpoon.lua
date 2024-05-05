return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: [A]dd file" })
    vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, { desc = "Harpoon: [E]dit list" })
    vim.keymap.set("n", "<S-M-h>", function()
      ui.nav_file(1)
    end, { desc = "Harpoon: Go to file 1" })
    vim.keymap.set("n", "<S-M-j>", function()
      ui.nav_file(2)
    end, { desc = "Harpoon: Go to file 2" })
    vim.keymap.set("n", "<S-M-k>", function()
      ui.nav_file(3)
    end, { desc = "Harpoon: Go to file 3" })
    vim.keymap.set("n", "<S-M-l>", function()
      ui.nav_file(4)
    end, { desc = "Harpoon: Go to file 4" })
  end
}
-- vim: ts=2 sts=2 sw=2 expandtab
