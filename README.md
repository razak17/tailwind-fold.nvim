# Tailwind-fold.nvim

Neovim plugin to conceal long class attributes.

# Requirements

Requires [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

# Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim) in lua

```lua
{
  'razak17/tailwind-fold.nvim',
  opts= {},
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
},
```

Using [vim-plug](https://github.com/junegunn/vim-plug) in vimscript

```vim
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'razak17/tailwind-fold.nvim'
(...)
call plug#end()

lua << EOF
  require("tailwind-fiold").setup {
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
  }
EOF
```

- Astronvim

```lua
return {
    'razak17/tailwind-fold.nvim',
    opts = {},
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    event = "VeryLazy",
    config = function()
        require('tailwind-fold').setup({ft = {'html', 'twig'}})
    end
}
```

# Showcase

![2023-05-11_202341_699860995](https://github.com/razak17/tailwind-fold.nvim/assets/52210954/7c876300-2625-48ff-9b98-8765f7dfd5e9)

# Default Options

```lua
{
	enabled = true,
    symbol = "…", -- 󱏿
	highlight = {
		fg = "#38BDF8", -- [[ symbol color ]]
	},
	ft = {
		"html",
		"svelte",
		"astro",
		"vue",
		"tsx",
		"php",
		"blade",
		"eruby",
	}
},
```

# Configuration

- Make sure to install treesitter parsers for enabled languages. For example:

```bash
:TSInstall html
```

- Make sure conceallevel is set to 2 in your config OR.

```bash
:set conceallevel=2
```

- Set concealcursor to an empty string to expand class when on cursorline:

```bash
:set concealcursor=
```

# Usage

The plugin is activated automatically

`:TailwindFoldDisable`, `:TailwindFoldEnable` and `:TailwindFoldToggle` are also available to change fold state.

# Development and Contributions

Feel free to open and issue or create a PR if a filetype you are using is not supported yet.

# Resources and Acknowledgements

All credit goes to the author of [this](https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b) gist, which made the initial version of this plugin possible.

You can use it if you prefer not to install a plugin
