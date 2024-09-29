local config = require("tailwind-fold.config")
local classes = require("tailwind-fold.classes")

local M = {}

local function set_conceal(bufnr)
	local ft = vim.bo.ft

	if vim.tbl_contains({ "php", "blade", "eruby", "htmldjango" }, ft) then
		classes.html_conceal_class(bufnr)
	else
		classes.conceal_class(bufnr)
	end
end

function M.enable()
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = vim.g.tailwind_fold.conceal_au,
		pattern = vim.g.tailwind_fold.ft_to_pattern,
		callback = function(args)
			if config.state.enabled then
				set_conceal(args.buf)
			end
		end,
	})
	-- Workaround to reset conceallevel per buffer
	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.g.tailwind_fold.conceal_au,
		pattern = vim.g.tailwind_fold.ft_to_pattern,
		callback = function(args)
			vim.wo.conceallevel = vim.opt.conceallevel:get()
			if config.state.enabled then
				set_conceal(args.buf)
			end
		end,
	})

	for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			set_conceal(bufnr)
		end
	end

	config.state.enabled = true
end

function M.disable()
	vim.wo.conceallevel = 0
	vim.api.nvim_clear_autocmds({
		group = vim.g.tailwind_fold.conceal_au,
		event = { "TextChanged", "TextChangedI" },
	})

	for bufnr, _ in pairs(config.state.active_buffers) do
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.api.nvim_buf_clear_namespace(bufnr, vim.g.tailwind_fold.conceal_ns, 0, -1)
		end
	end

	config.state.active_buffers = {}
	config.state.enabled = false
end

M.toggle = function()
	if config.state.enabled then
		M.disable()
	else
		M.enable()
	end
end

return M
