-- Ref: https://github.com/luckasRanarison/tailwind-tools.nvim/blob/2a23bc6/lua/tailwind-tools/conceal.lua

local config = require("tailwind-fold.config")
local utils = require("tailwind-fold.utils")

local M = {}

function M.conceal_class(bufnr)
	local class_nodes = utils.get_class_nodes(bufnr)

	if not class_nodes then
		-- vim.notify(vim.bo.ft .. " is not supported.", vim.log.levels.INFO, { title = "tailwind-fold" })
		return
	end

	vim.wo.conceallevel = 2
	vim.api.nvim_buf_clear_namespace(bufnr, vim.g.tailwind_fold.conceal_ns, 0, -1)
	config.state.active_buffers[bufnr] = true

	for _, node in pairs(class_nodes) do
		local start_row, start_col, end_row, end_col = utils.get_class_range(node, bufnr)

		local row_diff = end_row - start_row
		local col_diff = end_col - start_col
		if row_diff == 0 and col_diff > config.options.min_chars then
			vim.api.nvim_buf_set_extmark(bufnr, vim.g.tailwind_fold.conceal_ns, start_row, start_col, {
				end_line = end_row,
				end_col = end_col,
				conceal = config.options.symbol,
				hl_group = "TailwindFold",
				priority = 0, -- To ignore conceal hl_group when focused
			})
		end
	end
end

-- NOTE: use this for just php, blade and eruby files. New implementation causes issues with those files.
function M.html_conceal_class(bufnr)
	vim.opt_local.conceallevel = 2

	local ft
	if vim.tbl_contains(config.class_filetypes, vim.bo.ft) then
		ft = "html"
	end

	if vim.tbl_contains(config.classname_filetypes, vim.bo.ft) then
		ft = "tsx"
	end

	if not ft then
		vim.notify(vim.bo.ft .. " is not supported.", vim.log.levels.INFO, { title = "tailwind-fold" })
		return
	end

	local namespace = vim.api.nvim_create_namespace("ConcealClassName")
	local language_tree = vim.treesitter.get_parser(bufnr, ft)
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()

	local query = string.format(
		[[
    ((attribute
      (attribute_name) @att_name (#eq? @att_name "class")
      (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "%s")))
    ]],
		config.options.symbol
	)

	if ft == "tsx" then
		query = string.format(
			[[
      ((jsx_attribute
        (property_identifier) @att_name (#any-of? @att_name "className" "class")
        (string (string_fragment) @class_value) (#set! @class_value conceal "%s")))
      ]],
			config.options.symbol
		)
	end

	local ts_query = vim.treesitter.query.parse(ft, query)

	for _, captures, metadata in ts_query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
		local start_row, start_col, end_row, end_col = captures[2]:range()
		local row_diff = end_row - start_row
		local col_diff = end_col - start_col
		if row_diff == 0 and col_diff > config.options.min_chars then
			vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
				end_line = end_row,
				end_col = end_col,
				conceal = metadata[2].conceal,
			})
		end
	end
end

return M
