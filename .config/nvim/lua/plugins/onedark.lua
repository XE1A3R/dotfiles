-- Setup onedark theme
require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background - setting to true will allow our custom bg color to show
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {
        bg = '#000000',  -- Pure black background
        bg_dark = '#000000',  -- Pure black for darker areas
        bg_alt = '#000000',  -- Pure black for alternate backgrounds
    },
    highlights = {
        -- Set background to black for various elements
        Normal = { bg = '#000000' },
        NormalNC = { bg = '#000000' },
        NormalFloat = { bg = '#000000' },
        FloatBorder = { bg = '#000000', fg = '#000000' },
        Terminal = { bg = '#000000' },
        EndOfBuffer = { fg = '#000000' }, -- Make tildes at end invisible against black bg
        -- Enhance Treesitter highlights to work better with syntax
        TSFunction = { fg = '#98c379', style = 'bold' }, -- Function names in green (bold)
        TSMethod = { fg = '#98c379', style = 'bold' }, -- Method names in green (bold)
        TSParameter = { fg = '#e06c75' }, -- Parameters in red
        TSVariable = { fg = '#abb2bf' }, -- Variables in default text color
        TSKeyword = { fg = '#c678dd', style = 'bold' }, -- Keywords in purple (bold)
        TSKeywordFunction = { fg = '#c678dd', style = 'bold' }, -- Function keywords in purple (bold)
        TSKeywordOperator = { fg = '#56b6c2' }, -- Keyword operators in cyan
        TSOperator = { fg = '#56b6c2' }, -- Operators in cyan
        TSConstructor = { fg = '#e5c07b' }, -- Constructor in yellow
        TSProperty = { fg = '#d19a66' }, -- Properties in orange
        TSStructure = { fg = '#abb2bf' }, -- Structures in default text color
        TSType = { fg = '#e5c07b' }, -- Types in yellow
        TSTypeBuiltin = { fg = '#e5c07b', style = 'bold' }, -- Builtin types in yellow (bold)
        TSConstant = { fg = '#d19a66' }, -- Constants in orange
        TSConstBuiltin = { fg = '#d19a66', style = 'italic' }, -- Builtin constants in orange (italic)
        TSString = { fg = '#98c379' }, -- Strings in green
        TSStringRegex = { fg = '#98c379' }, -- Regex strings in green
        TSNumber = { fg = '#d19a66' }, -- Numbers in orange
        TSPunctBracket = { fg = '#abb2bf' }, -- Brackets in default text color
        TSPunctDelimiter = { fg = '#abb2bf' }, -- Delimiters in default text color
        TSComment = { fg = '#5c6370', style = 'italic' }, -- Comments in gray (italic)
        TSLiteral = { fg = '#98c379' }, -- Literals in green
        TSAttribute = { fg = '#e5c07b' }, -- Attributes in yellow
        TSTag = { fg = '#e06c75' }, -- HTML/XML tags in red
        TSTagDelimiter = { fg = '#828997' }, -- HTML/XML tag delimiters in gray
    },

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

-- Load the theme
require('onedark').load()

require('lualine').setup {
    options = {
        theme = 'onedark'
    }
}
