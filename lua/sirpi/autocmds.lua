local go_augroup = vim.api.nvim_create_augroup("gocommands", { clear = true })

vim.api.nvim_create_autocmd({ "FileReadPre", "BufWritePre" }, {
    group = go_augroup,
    pattern = "*.go",
    callback = function()
        vim.schedule(function()
            file = GetCurrentFile()
            cmd = string.format('silent !goimports -w %s', file)
            vim.api.nvim_command(cmd)
        end)
    end
})

function isTerm(path)
    return string.sub(path, string.len(path) - 8 + 1, string.len(path)) == "/usr/bin"
end

-- Change crrent directory
require("sirpi.commands")
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = "*",
    callback = function()
        vim.schedule(function()
            ChangeCurrentDirectory()
            -- vim.cmd("message clear")
        end)
    end
})
