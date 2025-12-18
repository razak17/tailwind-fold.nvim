local conceal = require("tailwind-fold.conceal")
local config = require("tailwind-fold.config")

local M = {}

function M.setup(options)
	vim.validate("options", options, "table", true)

	config.options = vim.tbl_deep_extend("force", config.options, options or {})

	config.state.enabled = config.options.enabled

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

			if not vim.tbl_contains(config.options.ft, ft) then
        return
      end

			if not vim.tbl_contains(config.supported_filetypes, ft) then
				vim.notify(ft .. " is not supported.", vim.log.levels.INFO, { title = "tailwind-fold" })
				return
			end
			if config.state.enabled then
				conceal.enable()
			end
		end,
	})

	vim.api.nvim_set_hl(0, "TailwindFold", config.options.highlight)
	vim.api.nvim_create_user_command("TailwindFoldEnable", conceal.enable, {})
	vim.api.nvim_create_user_command("TailwindFoldDisable", conceal.disable, {})
	vim.api.nvim_create_user_command("TailwindFoldToggle", conceal.toggle, {})
end

return M
