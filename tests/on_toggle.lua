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

local calls = {}

require("tailwind-fold").setup({
  enabled = true,
  on_toggle = function(enabled) table.insert(calls, enabled) end,
})

assert_equal(calls, { true }, "setup should report the initial enabled state")

vim.cmd("TailwindFoldEnable")
assert_equal(calls, { true }, "redundant enable should not report")

vim.cmd("TailwindFoldDisable")
assert_equal(calls, { true, false }, "disable should report the disabled state")

vim.cmd("TailwindFoldDisable")
assert_equal(calls, { true, false }, "redundant disable should not report")

vim.cmd("TailwindFoldEnable")
assert_equal(calls, { true, false, true }, "enable should report the enabled state")

vim.cmd("TailwindFoldToggle")
assert_equal(calls, { true, false, true, false }, "toggle should report disable")

vim.cmd("TailwindFoldToggle")
assert_equal(calls, { true, false, true, false, true }, "toggle should report enable")
