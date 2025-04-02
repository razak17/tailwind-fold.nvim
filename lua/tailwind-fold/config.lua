local M = {}

M.supported_filetypes = {
  "astro",
  "blade",
  "clojure",
  "cshtml",
  "eruby",
  "html",
  "htmlangular",
  "htmldjango",
  "javascriptreact",
  "php",
  "razor",
  "svelte",
  "templ",
  "typescriptreact",
  "vue",
}

M.filetype_to_extension = {
  astro = "astro",
  blade = "blade.php",
  clojure = "cljs",
  cshtml = "cshtml",
  edge = "edge",
  eruby = "erb",
  html = "html",
  htmlangular = "html",
  htmldjango = "html",
  javascriptreact = "jsx",
  php = "php",
  razor = "razor",
  svelte = "svelte",
  templ = "templ",
  typescriptreact = "tsx",
  vue = "vue",
}

M.treesitter = {
  "astro",
  "blade",
  "clojure",
  "cshtml",
  "css",
  "eelixir",
  "elixir",
  "heex",
  "html",
  "htmlangular",
  "htmldjango",
  "javascript",
  "javascriptreact",
  "php",
  "razor",
  "svelte",
  "templ",
  "twig",
  "typescript",
  "typescriptreact",
  "vue",
}

M.options = {
  enabled = true,
  -- Only fold when class string char count is more than min_chars. Folds everything by default.
  min_chars = 0,
  ft = {
    "astro",
    "blade",
    "clojure",
    "cshtml",
    "edge",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "php",
    "razor",
    "svelte",
    "templ",
    "typescriptreact",
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
