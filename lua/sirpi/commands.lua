function VerticalAdd()
    vim.api.nvim_command('vertical resize +5')
end

function VerticalReduce()
    vim.api.nvim_command('vertical resize -5')
end

function HorizontalAdd()
    vim.api.nvim_command('resize +5')
end

function HorizontalReduce()
    vim.api.nvim_command('resize -5')
end

-- Format on-save plugin configs
function FormatAndSave()
    vim.lsp.buf.format()
    vim.api.nvim_command('write')
    if vim.bo.filetype == 'go' then
        cmd = string.format('silent !goimports -w %s', GetCurrentFile())
        vim.api.nvim_command(cmd)
    end
    return
end

function GetCurrentFile()
    return vim.api.nvim_buf_get_name(0)
end

function GetCurrentDirectory()
    currentDir = GetCurrentFile()
    slashIndex = 1
    for i = 1, #currentDir do
        local c = currentDir:sub(i, i)
        if c == '/' then
            slashIndex = i
        end
    end
    return currentDir:sub(1, slashIndex)
end

function OpenCurrentWindow()
    --print(currentDir:sub(1, slashIndex))
    local api = require('nvim-tree.api')
    api.tree.toggle({ path = GetCurrentDirectory() })
end

function NewFile()
    dir = GetCurrentDirectory()
    name = vim.fn.input("Filename: ")

    -- If the user input is nil then abort the function
    if name == '' or name == nil then
        return
    end

    filename = dir .. name
    cmd = string.format(':new %s', filename)
    vim.api.nvim_command(cmd)
end

-- gives space seperated string combine them using / and insert ~ at the front to make typing easier
function ListDirectory()
    local builtin = require('telescope.builtin')
    dir = vim.fn.input("Directory: ")

    -- If the user input is nil then abort the function
    if dir == '' or dir == nil then
        return
    end
    builtin.find_files({ cwd = dir })
end

function ColorSchemePreview()
    builtin = require('telescope.builtin')
    themes = require 'telescope.themes'
    builtin.colorscheme(themes.get_ivy { enable_preview = true })
end

function Run()
    local file_name = vim.api.nvim_buf_get_name(0)
    local dot_index = -1
    for i = 1, #file_name do
        if string.sub(file_name, i, i) == '.' then
            dot_index = i
        end
    end
    if dot_index == -1 then
        return
    end
    local command = "!" .. getExecutionCommand(string.sub(file_name, dot_index + 1, #file_name)) .. file_name
    if command == "" then
        return
    end
    vim.api.nvim_command(command)
end

function getExecutionCommand(file_type)
    local ans = ""
    if file_type == "go" then
        ans = "go run "
    elseif file_type == "lua" then
        ans = "lua "
    end
    return ans
end

function TidyRestart()
    if vim.bo.filetype == 'go' then
        vim.api.nvim_command("silent !go mod tidy")
        vim.api.nvim_command("silent !go mod verify")
        vim.api.nvim_command(":LspRestart")
    else
        print "Not a go project"
    end
end

function MoveCursor()
    text = vim.fn.input("Move:")
    direction = string.sub(text, 1, 1)
    if tonumber(direction) ~= nil then
        steps = string.sub(text, 1)
    else
        steps = string.sub(text, 2)
    end

    if direction == 'u' then
        steps = "-" .. steps
    elseif direction == 'd' then
        steps = "+" .. steps
    end
    command = string.format(":%s", steps)
    vim.fn.execute(command)
end
