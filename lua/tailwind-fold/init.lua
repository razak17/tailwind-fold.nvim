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
		local extension = config.filetype_to_extension[ft] or ft
		table.insert(ft_to_pattern, "*." .. extension)
	end

	vim.g.tailwind_fold = {
		conceal_ns = vim.api.nvim_create_namespace("conceal_class_name"),
		conceal_au = vim.api.nvim_create_augroup("conceal_class_name", {}),
		ft_to_pattern = ft_to_pattern,
	}

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.g.tailwind_fold.conceal_au,
		pattern = vim.g.tailwind_fold.ft_to_pattern,
		callback = function()
			local ft = vim.bo.ft

			if not vim.tbl_contains(config.supported_filetypes, ft) then
				vim.notify(ft .. " is not supported.", vim.log.levels.INFO, { title = "tailwind-fold" })
				return
			end
			conceal.enable()
		end,
	})

	vim.api.nvim_set_hl(0, "TailwindFold", config.options.highlight)
	api.nvim_create_user_command("TailwindFoldEnable", M.enable, {})
	api.nvim_create_user_command("TailwindFoldDisable", M.disable, {})
	api.nvim_create_user_command("TailwindFoldToggle", M.toggle, {})
end

return M
