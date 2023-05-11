local api = vim.api

local conceal_class = function(bufnr)
	local ft = "html"
	if not vim.tbl_contains({ "html", "svelte", "astro", "vue" }, vim.bo.ft) then
		ft = "tsx"
	end

	local namespace = api.nvim_create_namespace("ConcealClassName")
	local language_tree = vim.treesitter.get_parser(bufnr, ft)
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()

	local query = [[
    ((attribute
      (attribute_name) @att_name (#eq? @att_name "class")
      (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
    ]]

	if ft == "tsx" then
		query = [[
      ((jsx_attribute
        (property_identifier) @att_name (#eq? @att_name "className")
        (string (string_fragment) @class_value) (#set! @class_value conceal "…")))
      ]]
	end

	local ts_query = vim.treesitter.query.parse(ft, query)

	for _, captures, metadata in ts_query:iter_matches(root, bufnr, root:start(), root:end_()) do
		local start_row, start_col, end_row, end_col = captures[2]:range()
		if end_row - start_row == 0 then
			api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
				end_line = end_row,
				end_col = end_col,
				conceal = metadata[2].conceal,
			})
		end
	end
end

api.nvim_create_autocmd({
	"BufEnter",
	"BufWritePost",
	"TextChanged",
	"InsertLeave",
}, {
	pattern = { "*.html", "*.svelte", "*.astro", "*.vue", "*.tsx" },
	callback = function()
		conceal_class(api.nvim_get_current_buf())
	end,
})
