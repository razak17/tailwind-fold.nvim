local M = {}

M.options = {
	enabled = true,
	-- Only fold when class string char count is more than 30. Folds everything by default.
	min_chars = 0,
	ft = {
		"html",
		"svelte",
		"astro",
		"vue",
		"tsx",
		"php",
		"blade",
	},
	symbol = "…", -- 󱏿
	highlight = {
		fg = "#38BDF8",
	},
}

return M
