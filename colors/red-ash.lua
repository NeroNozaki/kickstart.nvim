-- Red Ash colorscheme
-- ~/.config/nvim/colors/red-ash.lua

vim.cmd("highlight clear")
vim.g.colors_name = "red-ash"
vim.o.background = "dark"
local transparent = vim.g.red_ash_transparent == true

local c = {
  bg          = "#1c1c1c",
  surface     = "#262626",
  highlight   = "#2A2A2A",
  selection   = "#484848",
  border      = "#484848",
  muted       = "#757575",
  fg          = "#D4D4D4",
  white       = "#e4e6e7",
  white_bright = "#F0F0F0",

  red         = "#df5b61",
  red_dark    = "#B83A48",
  red_bright  = "#B85C68",
  green       = "#55C878",
  green_bright = "#7BE495",
  yellow      = "#E6B800",
  yellow_bright = "#ffd700",
  blue        = "#82aaff",
  blue_bright = "#128aed",
  purple      = "#B18ADB",
  purple_bright = "#C9A8EB",
  cyan        = "#36C9B0",
  cyan_bright = "#4DD9E8",
  orange      = "#E87545",
}

local groups = {
  -- Editor
  Normal       = { fg = c.fg, bg = transparent and "NONE" or c.bg, },
  NormalNC     = { bg = transparent and "NONE" or c.bg, },
  NormalFloat  = { fg = c.fg, bg = c.surface },
  FloatBorder  = { fg = c.border, bg = c.surface },
  EndOfBuffer  = { fg = c.surface, bg = transparent and "NONE" or c.bg, },
  SignColumn   = { bg = transparent and "NONE" or c.bg, },
  LineNr       = { fg = c.muted, bg = transparent and "NONE" or c.bg, },
  Cursor       = { fg = c.bg, },
  CursorLineNr = { fg = c.yellow, bold = true },
  CursorLine   = { bg = c.highlight, },
  ColorColumn  = { bg = c.surface },
  Visual       = { bg = c.selection, },
  Search       = { fg = c.fg, bg = c.red_bright },
  IncSearch    = { fg = c.bg, bg = c.yellow },
  MatchParen   = { fg = c.red, bold = true },
  Pmenu        = { fg = c.fg, bg = c.surface },
  PmenuSel     = { fg = c.white_bright, bg = c.selection, },
  StatusLine   = { fg = c.fg, bg = c.surface },
  StatusLineNC = { fg = c.muted, bg = c.bg },
  VertSplit    = { fg = c.border },
  WinSeparator = { fg = c.border },
  Yank         = { bg = c.yellow, fg = c.bg },

  -- MiniStatusLine
  MiniStatuslineModeNormal  = { fg = c.bg, bg = c.red,    bold = true },
  MiniStatuslineModeInsert  = { fg = c.bg, bg = c.green,  bold = true },
  MiniStatuslineModeCommand = { fg = c.bg, bg = c.orange, bold = true },
  MiniStatuslineModeVisual  = { fg = c.bg, bg = c.purple, bold = true },

  -- Syntax
  Comment      = { fg = c.muted, italic = true },
  Constant     = { fg = c.purple },
  String       = { fg = c.green_bright },
  Character    = { fg = c.green_bright },
  Number       = { fg = c.orange },
  Boolean      = { fg = c.orange },
  Identifier   = { fg = c.fg },
  Function     = { fg = c.blue },
  Statement    = { fg = c.red },
  Conditional  = { fg = c.red },
  Repeat       = { fg = c.red },
  Operator     = { fg = c.white },
  Keyword      = { fg = c.red },
  Exception    = { fg = c.red_dark },
  PreProc      = { fg = c.purple },
  Type         = { fg = c.cyan },
  Special      = { fg = c.yellow },
  Delimiter    = { fg = c.white },
  Underlined   = { fg = c.blue, underline = true },
  Todo         = { fg = c.bg, bg = c.yellow, bold = true },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn  = { fg = c.yellow },
  DiagnosticInfo  = { fg = c.blue },
  DiagnosticHint  = { fg = c.cyan },

  -- Diff
  DiffAdd    = { fg = c.green_bright, bg = "#14251A" },
  DiffChange = { fg = c.yellow, bg = "#292510" },
  DiffDelete = { fg = c.red, bg = "#2D1518" },
  DiffText   = { fg = c.white_bright, bg = "#483036" },

  -- Git signs
  GitSignsAdd    = { fg = c.green },
  GitSignsChange = { fg = c.yellow },
  GitSignsDelete = { fg = c.red },

  -- Telescope
  TelescopeMatching = { fg = c.yellow, bold = true, },
  TelescopeSelection = { bg = c.surface, },
  TelescopeSelectionCaret = { fg = c.red, bg = c.surface, },
}

for group, opts in pairs(groups) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- Tree-sitter captures
local treesitter = {
  ["@comment"]           = { link = "Comment" },
  ["@string"]            = { link = "String" },
  ["@string.escape"]     = { fg = c.cyan_bright },
  ["@constant"]          = { link = "Constant" },
  ["@number"]            = { link = "Number" },
  ["@boolean"]           = { link = "Boolean" },
  ["@function"]          = { link = "Function" },
  ["@function.call"]     = { link = "Function" },
  ["@method"]            = { link = "Function" },
  ["@keyword"]           = { link = "Keyword" },
  ["@keyword.function"]  = { fg = c.purple },
  ["@type"]              = { link = "Type" },
  ["@variable"]          = { fg = c.fg },
  ["@variable.builtin"]  = { fg = c.red },
  ["@property"]          = { fg = c.cyan },
  ["@operator"]          = { link = "Operator" },
  ["@punctuation"]       = { link = "Delimiter" },
  ["@attribute"]         = { fg = c.yellow },
}

for group, opts in pairs(treesitter) do
  vim.api.nvim_set_hl(0, group, opts)
end
