return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim",       opts = {} },

    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { "folke/neodev.nvim",       opts = {} },
  },
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        -- map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        vim.keymap.set(
          "i",
          "<C-h>",
          vim.lsp.buf.signature_help,
          { buffer = event.buf, desc = "LSP: Signature [H]elp" }
        )

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup =
              vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- NOTE: Unsupported since neovim 0.11
        -- https://gpanders.com/blog/whats-new-in-neovim-0-11/#improved-hover-documentation
        --
        -- customize hover windows
        -- local md_namespace = vim.api.nvim_create_namespace("morngrar/lsp_float")
        -- ---LSP handler that adds extra inline highlights, keymaps, and window options.
        -- ---Code inspired from `noice`.
        -- ---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
        -- ---@return function
        -- local function enhanced_float_handler(handler)
        --   return function(err, result, ctx, config)
        --     local buf, win = handler(
        --       err,
        --       result,
        --       ctx,
        --       vim.tbl_deep_extend("force", config or {}, {
        --         border = "rounded",
        --         max_height = math.floor(vim.o.lines * 0.5),
        --         max_width = math.floor(vim.o.columns * 0.4),
        --       })
        --     )
        --
        --     if not buf or not win then
        --       return
        --     end
        --
        --     -- Conceal everything.
        --     vim.wo[win].concealcursor = "n"
        --
        --     -- Extra highlights.
        --     for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        --       for pattern, hl_group in pairs({
        --         ["|%S-|"] = "@text.reference",
        --         ["@%S+"] = "@parameter",
        --         ["^%s*(Parameters:)"] = "@text.title",
        --         ["^%s*(Return:)"] = "@text.title",
        --         ["^%s*(See also:)"] = "@text.title",
        --         ["{%S-}"] = "@parameter",
        --       }) do
        --         local from = 1 ---@type integer?
        --         while from do
        --           local to
        --           from, to = line:find(pattern, from)
        --           if from then
        --             vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
        --               end_col = to,
        --               hl_group = hl_group,
        --             })
        --           end
        --           from = to and to + 1 or nil
        --         end
        --       end
        --     end
        --
        --     -- Add keymaps for opening links.
        --     if not vim.b[buf].markdown_keys then
        --       vim.keymap.set("n", "K", function()
        --         -- Vim help links.
        --         local url = (vim.fn.expand("<cWORD>") --[[@as string]]):match("|(%S-)|")
        --         if url then
        --           return vim.cmd.help(url)
        --         end
        --
        --         -- Markdown links.
        --         local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        --         local from, to
        --         from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
        --         if from and col >= from and col <= to then
        --           vim.system({ "open", url }, nil, function(res)
        --             if res.code ~= 0 then
        --               vim.notify("Failed to open URL" .. url, vim.log.levels.ERROR)
        --             end
        --           end)
        --         end
        --       end, { buffer = buf, silent = true })
        --       vim.b[buf].markdown_keys = true
        --     end
        --   end
        -- end
        --
        -- vim.lsp.handlers["textDocument/hover"] = enhanced_float_handler(vim.lsp.handlers.hover)
        -- vim.lsp.handlers["textDocument/signatureHelp"] =
        --     enhanced_float_handler(vim.lsp.handlers.signature_help)

        -- NOTE: at least getting rounded corners back:
        -- see https://neovim.io/doc/user/options.html#'winborder' for any other possibilities
        vim.o.winborder = 'rounded'

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      -- tsserver = {},
      --

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("java").setup()
    require("lspconfig").jdtls.setup({})

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 expandtab
