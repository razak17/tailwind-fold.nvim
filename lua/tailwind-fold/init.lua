local api = vim.api
local conceal_class = require("tailwind-fold.conceal").conceal_class

local M = {}

function M.setup(config)
	vim.validate({ config = { config, "table", true } })
	if not config then
		config = {}
	end

	local default_config = {
		-- Only fold when class string char count is more than 30. Folds everything by default.
		min_chars = 0,
	}

	config = vim.tbl_deep_extend("force", default_config, config)

	api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePost",
		"TextChanged",
		"InsertLeave",
	}, {
		pattern = { "*.html", "*.svelte", "*.astro", "*.vue", "*.tsx" },
		callback = function()
			conceal_class(api.nvim_get_current_buf(), config)
		end,
	})
end

return M
