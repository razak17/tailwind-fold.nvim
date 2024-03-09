local api = vim.api
local conceal_class = require("tailwind-fold.conceal").conceal_class

local M = {}

M.config = {
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
		"blade"
	}
}

M.enable = function()
	M.config.enabled = true
	vim.cmd("doautocmd TextChanged")
end

M.disable = function()
	M.config.enabled = false
	vim.opt_local.conceallevel = 0
end

M.toggle = function()
	if M.config.enabled then
		M.disable()
	else
		M.enable()
	end
end

function M.setup(config)
	vim.validate({ config = { config, "table", true } })

	M.config = vim.tbl_deep_extend("force", M.config, config or {})

	local ft_to_pattern = {}
	for _, ft in ipairs(M.config.ft) do
		table.insert(ft_to_pattern, "*." .. ft)
	end

	api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePre",
		"BufWritePost",
		"TextChanged",
		"InsertLeave",
	}, {
		pattern = ft_to_pattern,
		callback = function(args)
			if M.config.enabled then
				conceal_class(args.buf, M.config)
			end
		end,
	})

	api.nvim_create_user_command("TailwindFoldEnable", M.enable, {})
	api.nvim_create_user_command("TailwindFoldDisable", M.disable, {})
	api.nvim_create_user_command("TailwindFoldToggle", M.toggle, {})
end

return M
