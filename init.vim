" Initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Plugin: Autocomplete (nvim-cmp) and Language Server Protocol (LSP)
Plug 'neovim/nvim-lspconfig'       " LSP configurations
Plug 'hrsh7th/nvim-cmp'            " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'        " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'          " Buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'            " Path source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip'    " Snippet source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'            " Snippet engine

" Plugin: Templates (UltiSnips)
Plug 'honza/vim-snippets'          " Snippets repository
Plug 'SirVer/ultisnips'            " Snippet plugin

" Tree-sitter for enhanced syntax highlighting and language features
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope for fuzzy finding
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.0'}
Plug 'nvim-lua/plenary.nvim'  " Telescope's dependencies

" NvimTree file explorer
Plug 'kyazdani42/nvim-tree.lua'

" LSP for Python (Pyright as an example)
Plug 'neovim/nvim-lspconfig'

" Copilot 
Plug 'github/copilot.vim'

" Nice status line
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons' 

" Colorscheme
Plug 'catppuccin/nvim'

call plug#end()

" Configure nvim-cmp for autocompletion
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})
EOF

" Tree-sitter Configuration
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",  -- Install parsers for all languages
  highlight = {
    enable = true,           -- Enable syntax highlighting
    additional_vim_regex_highlighting = false,  -- Disable Vim's native highlighting
  },
  indent = {
    enable = true,           -- Enable automatic indentation
  },
  autopairs = {
    enable = true,           -- Enable auto-pairs like brackets
  },
  rainbow = {
    enable = true,           -- Enable rainbow parentheses
    extended_mode = true,    -- Enable for multi-line comments
  },
}
EOF

" Telescope Setup
lua << EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    file_ignore_patterns = {"node_modules", ".git/"},
  },
  pickers = {
    find_files = {
      theme = "dropdown",  -- A nice dropdown for file search
    },
    live_grep = {
      theme = "ivy",       -- Use the ivy theme for live grep
    },
  },
}
EOF

" NvimTree Setup
lua << EOF
require'nvim-tree'.setup {
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    width = 30,
    side = 'left',
  },
}
EOF

" Install LSP servers for C, C++, Go, Vue, HTML, and CSS
lua << EOF
local lspconfig = require'lspconfig'

-- C and C++ (clangd)
lspconfig.clangd.setup{}

-- Go (gopls)
lspconfig.gopls.setup{}

-- Vue (vls)
lspconfig.vls.setup{}

-- CSS (cssls)
lspconfig.cssls.setup{}

-- HTML (html-ls)
lspconfig.html.setup{}
EOF

lua << EOF
require('lualine').setup {
  options = {
    theme = 'catppuccin',  -- Matches your preferred purplish theme
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
EOF

" Enable GitHub Copilot
let g:copilot_no_tab_map = v:true  " Disable Copilot's default Tab mapping

" Use <C-J> and <C-K> for accepting or cycling through suggestions
inoremap <silent><expr> <C-J> copilot#Accept("\<CR>")
inoremap <silent><expr> <C-K> copilot#CycleSuggestions()

" Enable autocompletion with nvim-cmp
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Enable syntax highlighting
syntax enable

" Use spaces instead of tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" Set colorscheme (can be changed as per your choice)
colorscheme catppuccin
let g:catppuccin_flavour = "mocha"  " Use the mocha variant

