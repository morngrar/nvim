local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Fix Undefined global 'vim' (from primeagen's config)
-- https://github.com/ThePrimeagen/init.lua/blob/master/after/plugin/lsp.lua
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({select = true}),
	["<C-Space>"] = cmp.mapping.complete(),
})

local capabilities = require("cmp_nvim_lsp")
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())


--lsp.set_preferences({
--	sign_icons = { }
--})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vcf", function() vim.lsp.buf.format() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lspconfig = require("lspconfig")

lspconfig.pylsp.setup {
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
capabilities = capabilities,
}

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/sk/.local/share/nvim/mason/packages/omnisharp/omnisharp"
lspconfig.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid), },
    -- more configuration?
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    capabilities = capabilities
}

lsp.setup()

-- The following bit is to supress the `vim` global undefined warnings of the lua lsp
-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- EDIT: not needed after adding `lsp.nvim_workspace()` above?
--require'lspconfig'.lua_ls.setup {
--  settings = {
--    Lua = {
--      runtime = {
--        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--        version = 'LuaJIT',
--      },
--      diagnostics = {
--        -- Get the language server to recognize the `vim` global
--        globals = {'vim'},
--      },
--      workspace = {
--        -- Make the server aware of Neovim runtime files
--        library = vim.api.nvim_get_runtime_file("", true),
--      },
--      -- Do not send telemetry data containing a randomized but unique identifier
--      telemetry = {
--        enable = false,
--      },
--    },
--  },
--}
