vim.g.mapleader=" "

vim.keymap.set("n", "<leader>e", ":Neotree float focus<CR>")
vim.keymap.set("n", "<leader>o", ":Neotree float git_status<CR>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Git signs mappings
local gitsigns_avail, gitsigns = pcall(require, 'gitsigns')
if gitsigns_avail then
  -- Navigation
  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gitsigns.next_hunk() end)
    return '<Ignore>'
  end, {expr=true, desc='Next git hunk'})

  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gitsigns.prev_hunk() end)
    return '<Ignore>'
  end, {expr=true, desc='Previous git hunk'})

  -- Actions
  vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
  vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
  vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
  vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
  vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
  vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
  vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
  vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
  vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Blame line' })
  vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
  vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Diff this (~)' })
  vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

  -- Text object
  vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
end

-- Hop mappings will be set up after the plugin is loaded
-- This will be handled in the plugin configuration


