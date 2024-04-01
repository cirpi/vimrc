function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'violet' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'violet' })
end

LineNumberColors()
