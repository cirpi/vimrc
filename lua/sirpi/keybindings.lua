require('sirpi.commands')
-- Leader mapping
vim.g.mapleader = " "

local g = vim.g

vim.g.user_emmet_leader_key = '<C-y>'

local function map(m, k, v)
    vim.api.nvim_set_keymap(m, k, v, { noremap = true, silent = true })
end


-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

map("n", "<C-t>", ":lua TidyRestart()<CR>")

map('n', '<C-q>', ':bd<CR>')



-- Window Reisizing
map('n', "<leader>=", ":lua VerticalAdd()<CR>")
map('n', "<leader>-", ":lua VerticalReduce()<CR>")
map('n', 'ga', ':lua HorizontalAdd()<CR>')
map('n', 'ge', ':lua HorizontalReduce()<CR>')
map('n', '=', '<C-w>=')
map('n', '<leader><leader>', ':lua FormatAndSave()<CR>')




-- Shortcuts for splits
map('n', '<C-s>v', ':vsplit<CR>')
map('n', '<C-s>h', ':split<CR>')


-- Buffer navigation
map('n', ']b', ':bn<CR>')
map('n', '[b', ':bp<CR>')

-- Tab shortcuts
map('n', ']t', ':tabnext<CR>')
map('n', '[t', ':tabprevious<CR>')

-- Buffer swithching between the recent two
map('n', 'bn', ':e #<CR>')

-- ExplorepZeroFormat
--
map('n', '<leader>d', ':lua OpenCurrentWindow()<CR>')
--map('n', '<C-n>', ':new<CR>')

-- Telescope keymaps
local builtin = require('telescope.builtin')
local themes = require "telescope.themes"
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files(themes.get_dropdown())
end)

vim.keymap.set('n', '<leader>gr', function()
    -- builtin.live_grep({ prompt_title = 'find string: ', grep_open_files = true })
    builtin.live_grep(themes.get_dropdown({ prompt_title = 'Find', grep_open_files = true }))
    -- builtin.live_grep({ prompt_title = 'find string: ', grep_open_files = true })
end)
-- vim.keymap.set('n', '<leader>cc', builtin.help_tags)
vim.keymap.set('n', '<leader>cc', function()
    builtin.help_tags(themes.get_dropdown())
end)

-- vim.keymap.set('n', '<leader>bb', builtin.buffers)
vim.keymap.set('n', '<leader>bb', function()
    builtin.buffers(themes.get_dropdown())
end)

-- vim.keymap.set('n', '<leader>dd', builtin.diagnostics)
vim.keymap.set('n', '<leader>j', function()
    builtin.diagnostics(themes.get_dropdown({ bufnr = 0 }))
end)

map('n', '<leader>gs', ':G<CR>')

map('n', '<C-f>', ':LspZeroFormat<CR>')

-- Create new file
--map('n', '<C-n>', ':lua NewFile()<CR>')

vim.api.nvim_create_user_command('Preview', ':lua ColorSchemePreview()<CR>', {})

-- Live server keybindings
vim.api.nvim_create_user_command('Ls', 'LiveServerToggle', {})
vim.keymap.set('n', '<leader>k', ':lua vim.diagnostic.open_float()<CR>')
map('n', "<Esc>", "<Esc>", {})
