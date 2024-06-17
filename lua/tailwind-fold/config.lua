local M = {}

M.filetype_to_extension = {
	html = "html",
	svelte = "svelte",
	astro = "astro",
	vue = "vue",
	tsx = "tsx",
	php = "php",
	blade = "blade",
	eruby = "erb",
}

M.class_filetypes = {
	"html",
	"php",
	"blade",
	"eruby",
	"vue",
	"svelte",
	"astro",
}

M.classname_filetypes = {
	"tsx",
	"jsx",
}

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
		"eruby",
	},
	symbol = "…", -- 󱏿
	highlight = {
		fg = "#38BDF8",
	},
}

return M
