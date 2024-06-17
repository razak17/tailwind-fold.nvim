local api = vim.api
local conceal = require("tailwind-fold.conceal")
local config = require("tailwind-fold.config")

local M = {}

M.enable = function()
	config.options.enabled = true
	vim.cmd("doautocmd TextChanged")
end

M.disable = function()
	config.options.enabled = false
	vim.opt_local.conceallevel = 0
end

M.toggle = function()
	if config.options.enabled then
		M.disable()
	else
		M.enable()
	end
end

function M.setup(options)
	vim.validate({ options = { options, "table", true } })

	config.options = vim.tbl_deep_extend("force", config.options, options or {})

	local ft_to_pattern = {}
	for _, ft in ipairs(config.options.ft) do
		local extension = config.filetype_to_extension[ft]
		table.insert(ft_to_pattern, "*." .. extension)
	end

	api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePre",
		"BufWritePost",
		"TextChanged",
		"TextChangedI",
		"InsertLeave",
	}, {
		pattern = ft_to_pattern,
		callback = function(args)
			if config.options.enabled then
				local ft = vim.bo.ft
				if vim.tbl_contains({ "php", "blade", "eruby" }, ft) then
					conceal.html_conceal_class(args.buf)
				else
					conceal.conceal_class(args.buf)
				end
			end
		end,
	})

	vim.api.nvim_set_hl(0, "TailwindFold", config.options.highlight)
	api.nvim_create_user_command("TailwindFoldEnable", M.enable, {})
	api.nvim_create_user_command("TailwindFoldDisable", M.disable, {})
	api.nvim_create_user_command("TailwindFoldToggle", M.toggle, {})
end

return M
