local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    { "hadronized/hop.nvim",
      event = "VeryLazy",
      config = function()
        require("hop").setup({
          keys = 'etovxqpdygfblzhckisuran',
          char2_fallback_key = '<CR>',
          multiline = true,
          uppercase_labels = false,
          terminal_blacklist = { 'lazygit', 'neotree' },
          persist_across_buffers = false,
        })

        -- Set up hop mappings after plugin is loaded
        local hop = require('hop')
        vim.keymap.set('', 'f', function()
          hop.hint_char1 { current_line_only = true, direction = 0 } -- 0 = AFTER_CURSOR
        end, { remap=true, desc = 'Hop to character (forward)' })

        vim.keymap.set('', 'F', function()
          hop.hint_char1 { current_line_only = true, direction = 1 } -- 1 = BEFORE_CURSOR
        end, { remap=true, desc = 'Hop to character (backward)' })

        vim.keymap.set('', 't', function()
          hop.hint_char1 { current_line_only = true, hint_offset = -1, direction = 0 } -- 0 = AFTER_CURSOR
        end, { remap=true, desc = 'Hop to before character (forward)' })

        vim.keymap.set('', 'T', function()
          hop.hint_char1 { current_line_only = true, hint_offset = 1, direction = 1 } -- 1 = BEFORE_CURSOR
        end, { remap=true, desc = 'Hop to before character (backward)' })

        -- Leader mappings for hop
        vim.keymap.set('n', '<leader>h', function() hop.hint_char1() end, { remap = true, desc = 'Hop to any character' })
        vim.keymap.set('n', '<leader>hl', function() hop.hint_lines() end, { remap = true, desc = 'Hop to line' })
        vim.keymap.set('n', '<leader>hw', function() hop.hint_words() end, { remap = true, desc = 'Hop to word' })
      end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "p00f/nvim-ts-rainbow",
        },
        build = ":TSUpdate",
    },
    { "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
    },
    {
        "nvim-lualine/lualine.nvim", config = true
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "folke/lazy.nvim" },
        opts = {
            -- configuration options
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "saadparwaiz1/cmp_luasnip",
          "L3MON4D3/LuaSnip",
          "rafamadriz/friendly-snippets",
        },
    },
    {
        "nvim-tree/nvim-web-devicons", -- for trouble.nvim
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "stevearc/dressing.nvim", -- for better dropdowns in trouble.nvim
        opts = {},
    },
})
