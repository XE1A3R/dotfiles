require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "c",
    "cpp",
    "python",
    "javascript",
    "typescript",
    "rust",
    "go",
    "java",
    "html",
    "css",
    "json",
    "yaml",
    "bash",
    "markdown",
    "markdown_inline",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

-- Disable rainbow for now to avoid potential issues
-- require('ts_rainbow').setup() is not needed since we removed the dependency
