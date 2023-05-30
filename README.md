# Tailwind-fold.nvim

Neovim plugin to conceal long class attributes.

# Requirements

Requires [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

# Installation

- lazy.nvim:

```lua
{
  'razak17/tailwind-fold.nvim',
  opts= {}
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact' },
},
```

# Configuration

- Make sure to install treesitter parsers for enabled languages. For example:

```bash
:TSInstall html
```

- Make sure conceallevel is set to 2.

```bash
:set conceallevel=2
```

- Set concealcursor to an empty string to expand class when on cursorline:

```bash
:set concealcursor=
```

# Showcase

![2023-05-11_202341_699860995](https://github.com/razak17/tailwind-fold.nvim/assets/52210954/7c876300-2625-48ff-9b98-8765f7dfd5e9)

# Resources

All credit goes to the author of [this](https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b) gist, which makes this plugin possible
