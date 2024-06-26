local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- use 'akinsho/bufferline.nvim'

    -- Color schemes
    use 'jacoborus/tender.vim'
    use 'morhetz/gruvbox'
    use 'rebelot/kanagawa.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'rose-pine/neovim'
    use 'sainnhe/everforest'
    use 'Abstract-IDE/Abstract-cs'
    use 'mgechev/stylish'
    use 'AlexvZyl/nordic.nvim'
    use 'loctvl842/monokai-pro.nvim'
    use 'olimorris/onedarkpro.nvim'
    use {
        'mcchrish/zenbones.nvim',
        requires = "rktjmp/lush.nvim"
    }
    use 'savq/melange'

    -- Easy motion
    -- use 'easymotion/vim-easymotion'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    --use {
    --    'neoclide/coc.nvim',
    --    branch = 'release'
    --}

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
    }
    use 'nvim-treesitter/playground'
    -- use 'nvim-treesitter/nvim-treesitter'
    --run = ':TSUpdate'
    -- use 'nvim-treesitter/playground'
    use 'tpope/vim-fugitive'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x', requires = {
        -- Uncomment these if you want to manage LSP servers from neovim
        -- { 'williamboman/mason.nvim' },
        -- { 'williamboman/mason-lspconfig.nvim' },

        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    }
    }
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- use 'neovim/nvim-lspconfig'

    -- Live server
    use 'barrett-ruth/live-server.nvim'

    -- File tree
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    -- Auto close brackets
    use 'm4xshen/autoclose.nvim'

    use 'mattn/emmet-vim'


    -- use 'powerline/powerline'
    -- My plugins here
    -- use 'foo1/bar1.nvim'
    -- use 'foo2/bar2.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins

    if packer_bootstrap then
        require('packer').sync()
    end
end)
