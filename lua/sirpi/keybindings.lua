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

map('n', '<leader>y', ':lua vim.lsp.buf.format()<CR>')
-- map('n', '<C-c>', ':lua vim.lsp.buf.implementation()<CR>')
map('n', '<C-c>', ':lua vim.lsp.buf.references()<CR>')

-- go mod tidy (Go specific)
map("n", "<C-t>", ":lua TidyRestart()<CR>")

-- Execute make command
map('n', 'mm', ':lua Makefile()<CR>')
map('n', 'mr', ':make run<CR>')

-- Toggle wrap
map('n', '<C-w>', ':lua ToggleWrap()<CR>')

-- close the current buffer
map('n', '<C-q>', ':bd!<CR>')
-- close instance
-- Ctrl+i is equl to Tab, whenever i press Tab in 'n' mode, it quits the instance
-- map('n', '<C-i>', ':qa<CR>')
-- open the recently opened buffer
map('n', '<C-p>', ':b#<CR>')



-- Window Reisizing
map('n', "<leader>=", ":lua VerticalAdd()<CR>")
map('n', "<leader>-", ":lua VerticalReduce()<CR>")
map('n', 'ga', ':lua HorizontalAdd()<CR>')
map('n', 'ge', ':lua HorizontalReduce()<CR>')
-- make windows size equal
map('n', '=', '<C-w>=')
-- format the current buffer and save
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

-- Shortcut to open NvimTree
map('n', '<leader>d', ':lua OpenCurrentWindow()<CR>')

-- Telescope keymaps
local builtin = require('telescope.builtin')
local themes = require "telescope.themes"
-- Find the files in the current working directory
vim.keymap.set('n', '<leader>ff', function()
    path = vim.fn.getcwd()
    print(path)
    builtin.find_files(themes.get_dropdown({ cwd = path }))
end)
-- grep for the current file/buffer
vim.keymap.set('n', '<leader>gr', function()
    -- builtin.live_grep({ prompt_title = 'find string: ', grep_open_files = true })
    builtin.live_grep(themes.get_dropdown({ prompt_title = 'Find', grep_open_files = true }))
    -- builtin.live_grep({ prompt_title = 'find string: ', grep_open_files = true })
end)
-- Find the vim help tags
vim.keymap.set('n', '<leader>cc', function()
    builtin.help_tags(themes.get_dropdown())
end)

-- Find the currently active buffers
vim.keymap.set('n', '<leader>bb', function()
    builtin.buffers(themes.get_dropdown())
end)

-- Find the diagnostics for the current buffer
vim.keymap.set('n', '<leader>j', function()
    builtin.diagnostics(themes.get_dropdown({ bufnr = 0 }))
end)

-- Git status (Fugitive plugin)
map('n', '<leader>gs', ':G<CR>')

---map('n', '<C-f>', ':LspZeroFormat<CR>')

-- Cursor movement (Ex: u20 move the cursor 20 lines up, d20 move 20 lines down, 20 move the 20th line)
map('n', 'M', ':lua MoveCursor()<CR>')
map('v', 'M', '<cmd>lua MoveCursor()<CR>')

map('t', '<Esc>', '<C-\\><C-n>')


-- ColorSchemePreview
vim.api.nvim_create_user_command('Preview', ":lua ColorSchemePreview()<cr>", {})

-- Live server keybindings
vim.api.nvim_create_user_command('Ls', 'LiveServerToggle', {})
vim.keymap.set('n', '<leader>k', ':lua vim.diagnostic.open_float()<CR>')
