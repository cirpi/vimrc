require('sirpi.keybindings')
require('sirpi.plugins')
require('sirpi.colors')
require('sirpi.autocmds')
require('sirpi.commands')
require('sirpi.settings')

require('Comment').setup()
require('live-server').setup {
    args = {}

}
local lsp = require('lsp-zero')
lsp.extend_lspconfig()
-- require('lspconfig').gopls.setup {
--
--     go = { formatTool = 'goimports', }
-- }
--
local nvim_lsp = require 'lspconfig'
nvim_lsp.gopls.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>',
            { noremap = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>r', '<cmd>lua vim.lsp.buf.references()<CR>',
            { noremap = true })
    end,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                unreachable = true
            },
            --gofumpt = true,
            linkTarget = "pkg.go.dev",
            ["local"] = "github.com/cirpi",
            allowModfileModifications = true,
            codelenses = {
                gc_details = true,
            },
            usePlaceholders = false,
        }
    }
}
--nvim_lsp.typescript.setup {}
nvim_lsp.biome.setup {}
nvim_lsp.quick_lint_js.setup {}
nvim_lsp.jdtls.setup {
    single_file_support = true
}
nvim_lsp.lua_ls.setup {}
nvim_lsp.lemminx.setup {}



--vim.g.go_fmt_commad = 'goimports'
--vim.g.go_fmt_autosave = true
-- lualine customization
function CurrMode()
    local mode_map = {
        n = "Normal",
        i = "Insert",
        v = "Visual",
        V = "Visual Line",
        ['\x16'] = "Visual Block",
        c = "Command",
        R = "Replace",
        Rv = "Virtual Replace",
        s = "Select",
        S = "Select Line",
        ["\x13"] = "Select Block",
        nt = "Terminal",
    }
    local curr_mode = vim.api.nvim_get_mode().mode
    local mode = mode_map[curr_mode]
    return mode
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        --always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { CurrMode },
        lualine_b = { 'branch', 'diff' },
        --lualine_b = { 'buffers' },
        lualine_c = { 'filetype' },
        lualine_x = { 'location' },
        lualine_y = { 'diagnostics' },
        lualine_z = { 'progress' }
    },
    tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "searchcount" },
        lualine_z = { "%F" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

--require('lspconfig').gopls.setup {
--    formatTool = 'goimports',
--}

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('autoclose').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'gopls', 'lua_ls' },
    handlers = {
        lsp.default_setup,
    }
})
--local cmp = require('cmp')
--local cmp_select = {behaviour = cmp.SelectBehavior.Select}
--local cmp_mappings = lsp.defaults.cmp_mappings({
--    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--    ['<C-tab>'] = cmp.mapping.confirm({select=true}),
--    ['<C-Space>'] = cmp.mapping.complete(),
--})


local cmp = require 'cmp'
local cmp_select_opts = { behavior = cmp.SelectBehavior }

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        ['<tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),
        ['<C-d>'] = cmp.mapping.scroll_docs(5),
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 20,
            max_width = 60,
        }
    },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
            local short_name = {
                nvim_lsp = 'LSP',
                nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
        end,
    },
})


-- *********************************** --

-- Treesitter
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "go", "gomod", "gowork", "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        --disable = function(lang, buf)
        --    local max_filesize = 100 * 1024 -- 100 KB
        --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --    if ok and stats and stats.size > max_filesize then
        --        return true
        --    end
        --end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        --additional_vim_regex_highlighting = false,
    },
}

-- disable netrw at the very start of your init.lua
--

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})




-- local client = vim.lsp.start_client {
--     name = "sirpi's lsp",
--     cmd = { "/home/sirpi/projects/go/edu_lsp/edu_lsp" },
-- }
--
-- if not client then
--     print "client not started"
--     return
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "go",
--     callback = function()
--         vim.lsp.buf_attach_client(0, client)
--     end
-- })
--
