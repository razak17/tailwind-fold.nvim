vim.opt.shada = ""
vim.opt.runtimepath:append(vim.fn.getcwd())

local function assert_equal(actual, expected, message)
  if vim.deep_equal(actual, expected) then return end

  error(
    string.format(
      "%s\nexpected: %s\nactual: %s",
      message,
      vim.inspect(expected),
      vim.inspect(actual)
    )
  )
end

vim.cmd("filetype on")

local calls = {}

require("tailwind-fold").setup({
  enabled = true,
  on_toggle = function(enabled) table.insert(calls, enabled) end,
})

assert_equal(calls, { true }, "setup should report the initial enabled state")

vim.cmd("edit tests/course-card.tsx")
assert_equal(calls, { true }, "first supported BufEnter should not report a duplicate enable")
