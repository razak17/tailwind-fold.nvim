local M = {}

local config = require("tailwind-fold.config")
local tresitter = require("tailwind-fold.treesitter")

function M.get_ranges(bufnr)
  local results = {}
  local ft = vim.bo[bufnr].ft

  local has_queries = vim.tbl_contains(config.treesitter, ft)
  if has_queries then
    local ranges = tresitter.find_class_ranges(bufnr, ft)
    vim.list_extend(results, ranges)
  end

  return results
end

return M
