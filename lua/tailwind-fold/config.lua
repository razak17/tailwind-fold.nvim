local M = {}

M.supported_filetypes = {
  "astro",
  "blade",
  "eruby",
  "html",
  "htmlangular",
  "htmldjango",
  "javascriptreact",
  "php",
  "razor",
  "cshtml",
  "svelte",
  "templ",
  "typescriptreact",
  "vue",
}

M.filetype_to_extension = {
  astro = "astro",
  blade = "blade.php",
  eruby = "erb",
  html = "html",
  htmlangular = "html",
  htmldjango = "html",
  javascriptreact = "jsx",
  php = "php",
  cshtml = "cshtml",
  razor = "razor",
  svelte = "svelte",
  templ = "templ",
  typescriptreact = "tsx",
  vue = "vue",
  edge = "edge",
}

M.treesitter = {
  "html",
  "css",
  "php",
  "blade",
  "twig",
  "vue",
  "heex",
  "astro",
  "templ",
  "razor",
  "cshtml",
  "svelte",
  "elixir",
  "eelixir",
  "htmlangular",
  "htmldjango",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

M.options = {
  enabled = true,
  -- Only fold when class string char count is more than min_chars. Folds everything by default.
  min_chars = 0,
  ft = {
    "astro",
    "blade",
    "edge",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "php",
    "svelte",
    "razor",
    "cshtml",
    "templ",
    "typescriptreact",
    "javascriptreact",
    "vue",
  },
  symbol = "…", -- 󱏿
  highlight = {
    fg = "#38BDF8",
  },
}

M.state = {
  enabled = false,
  active_buffers = {},
}

return M
