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
  enabled = false,
  on_toggle = function(enabled) table.insert(calls, enabled) end,
})

assert_equal(calls, { false }, "setup should report the initial disabled state")

vim.cmd("TailwindFoldDisable")
assert_equal(calls, { false }, "redundant disable before initialization should not report")

vim.cmd("edit README.md")
assert_equal(calls, { false }, "unsupported buffers should not change callback state")

vim.cmd("edit tests/course-card.tsx")
assert_equal(calls, { false }, "supported buffers should stay silent while disabled")

vim.cmd("TailwindFoldEnable")
assert_equal(calls, { false, true }, "enable before initialization should report once")
