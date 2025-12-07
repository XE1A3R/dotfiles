-- Set up diagnostics to show in signs and virtual text
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
})

-- Set up diagnostic signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
  -- Add debug message to confirm on_attach is called
  vim.notify("LSP client " .. client.name .. " attached to buffer " .. bufnr, vim.log.levels.DEBUG)

  local opts = {buffer = bufnr, noremap = true, silent = true}

  -- Set up keymaps with more specific options
  pcall(vim.keymap.set, "n", "gd", function() vim.lsp.buf.definition() end, opts)
  pcall(vim.keymap.set, "n", "K", function() vim.lsp.buf.hover() end, opts)
  pcall(vim.keymap.set, "n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  pcall(vim.keymap.set, "n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  pcall(vim.keymap.set, "n", "[d", function() vim.diagnostic.goto_next() end, opts)
  pcall(vim.keymap.set, "n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  pcall(vim.keymap.set, "n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  pcall(vim.keymap.set, "n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  pcall(vim.keymap.set, "n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  pcall(vim.keymap.set, "i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup servers with individual handlers for proper on_attach
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
  },
  handlers = {
    -- Individual handlers for each server to ensure on_attach is properly called
    clangd = function()
      require("lspconfig").clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    ts_ls = function()
      require("lspconfig").ts_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    rust_analyzer = function()
      require("lspconfig").rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    gopls = function()
      require("lspconfig").gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    html = function()
      require("lspconfig").html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    cssls = function()
      require("lspconfig").cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    jsonls = function()
      require("lspconfig").jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    yamlls = function()
      require("lspconfig").yamlls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
  },
})

-- Set a general mapping for gd that works when an LSP server is available
vim.keymap.set("n", "gd", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    vim.lsp.buf.definition()
  else
    -- If no LSP client is available, fallback to builtin definition search or tags
    -- This will try to find definitions using vim's built-in methods
    vim.cmd("normal! gd")
  end
end, { noremap = true, silent = true, desc = "Go to definition" })