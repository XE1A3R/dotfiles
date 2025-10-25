"  _   _                 _
" | \ | | ___  _____   _(_)_ __ ___
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|
"
" by Stephan Raabe (2023)
" Enhanced for professional development
" -----------------------------------------------------

" Plugin management with vim-plug
call plug#begin('~/.vim/plugged')

" Essential plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Syntax highlighting and treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Status line and buffer line
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" Colorscheme
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Additional development tools
Plug 'numToStr/Comment.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'folke/which-key.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Language specific
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'rust-lang/rust.vim'
Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}

call plug#end()

" Basic settings
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set relativenumber          " show relative line numbers
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set clipboard=unnamedplus   " using system clipboard
set scrolloff=8             " keep 8 lines above/below cursor
set sidescrolloff=8         " keep 8 columns left/right of cursor
set signcolumn=yes          " always show sign column
set updatetime=300          " faster completion
set timeoutlen=500          " faster key sequence completion
set completeopt=menu,menuone,noselect,noinsert
set foldmethod=syntax

set wrap
set linebreak
set tw=120
set smartindent

" File type settings
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting

" Colorscheme
colorscheme catppuccin-mocha

" Transparent background
hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None

" Key mappings
let mapleader = " "

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Nvim-tree mappings
nnoremap <leader>e <cmd>NvimTreeToggle<cr>

" Git mappings
nnoremap <leader>gs <cmd>Git<cr>
nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gp <cmd>Git push<cr>

" Buffer navigation
nnoremap <leader>bn <cmd>BufferLineCycleNext<cr>
nnoremap <leader>bp <cmd>BufferLineCyclePrev<cr>
nnoremap <leader>bd <cmd>bd<cr>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save and quit
nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>
nnoremap <leader>wq <cmd>wq<cr>

" LSP mappings
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>di <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <leader>dn <cmd>lua vim.diagnostic.goto_next()<cr>
nnoremap <leader>dp <cmd>lua vim.diagnostic.goto_prev()<cr>

" Auto-commands
augroup filetype_specific
    autocmd!
    autocmd FileType python setlocal shiftwidth=4 tabstop=4
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
    autocmd FileType json setlocal shiftwidth=2 tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType css setlocal shiftwidth=2 tabstop=2
    autocmd FileType scss setlocal shiftwidth=2 tabstop=2
augroup END

" Lua configuration for plugins
lua << EOF
-- LSP configuration with new syntax
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Загружаем конфигурации серверов из плагина
require("lspconfig")

-- Общие настройки для ВСЕХ LSP-серверов
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Ваши привязки клавиш для LSP
    local opts = { buffer = bufnr, remap = false }
    
    -- Эти настройки заменят ваши старые nnoremap для LSP
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end
})

-- Настройки для pyright
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Настройки для tsserver (TypeScript/JavaScript)
vim.lsp.config('tsserver', {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- Настройки для rust_analyzer
vim.lsp.config('rust_analyzer', {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- Настройки для gopls
vim.lsp.config('gopls', {
  cmd = {vim.fn.expand("$HOME/go/bin/gopls")},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- ВКЛЮЧАЕМ LSP-серверы (это заменяет старый .setup())
vim.lsp.enable({ 'pyright', 'tsserver', 'rust_analyzer', 'gopls' })

-- Остальная конфигурация остается БЕЗ ИЗМЕНЕНИЙ:

-- CMP configuration
local cmp = require('cmp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 750 },
        { name = 'buffer', priority = 500 },
        { name = 'path', priority = 250 },
    },
    experimental = {
        ghost_text = true,
    },
})

-- CMP for command line
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Nvim-tree configuration
require'nvim-tree'.setup {
    view = {
        width = 30,
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
}

-- Bufferline configuration
require'bufferline'.setup {
    options = {
        diagnostics = "nvim_lsp",
    },
}

-- Lualine configuration
require'lualine'.setup {
    options = {
        theme = 'catppuccin',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
    },
}

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "python", "javascript", "typescript", "rust", "go", "lua", "vim",
        "json", "yaml", "html", "css", "scss", "bash", "markdown"
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}

-- Comment configuration
require('Comment').setup()

-- Autopairs configuration
require('nvim-autopairs').setup({
    check_ts = true,
})

-- Which-key configuration
require('which-key').setup()

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
EOF
