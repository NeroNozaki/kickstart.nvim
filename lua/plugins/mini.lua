-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup {
  -- Custom surroundings to be used on top of builtin ones.
  -- For more information with examples, see `:h MiniSurround.config`.
  custom_surroundings = {},

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'sa', -- Add surrounding in Normal and Visual modes
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after
  -- idle time if user input is required.
  silent = false,
}

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end

-- ... and there is more!
--  Check out: https://github.com/nvim-mini/mini.nvim

require('mini.pairs').setup {
  -- In which modes mappings from this `config` should be created
  modes = { insert = true, command = false, terminal = false },

  -- Global mappings. Each right hand side should be a pair information, a
  -- table with at least these fields (see more in |MiniPairs.map|):
  -- - <action> - one of 'open', 'close', 'closeopen'.
  -- - <pair> - two character string for pair to be used.
  -- By default pair is not inserted after `\`, quotes are not recognized by
  -- <CR>, `'` does not insert the pair after a letter.
  -- Only parts of tables can be tweaked (others will use these defaults).
  mappings = {
    ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\][^%w]' },
    ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\][^%w]' },
    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\][^%w]' },

    [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\][^%w]' },
    [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\][^%w]' },
    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\][^%w]' },

    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\][^%w]', register = { cr = false } },
    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%a\\][^%w]', register = { cr = false } },
    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^\\][^%w]', register = { cr = false } },
  },
}

require('mini.align').setup {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start = 'ga',
    start_with_preview = 'gA',
  },

  -- Modifiers changing alignment steps and/or options
  modifiers = {
    -- Main option modifiers
    -- ['s'] = --<function: enter split pattern>,
    -- ['j'] = --<function: choose justify side>,
    -- ['m'] = --<function: enter merge delimiter>,

    -- Modifiers adding pre-steps
    -- ['f'] = --<function: filter parts by entering Lua expression>,
    -- ['i'] = --<function: ignore some split matches>,
    -- ['p'] = --<function: pair parts>,
    -- ['t'] = --<function: trim parts>,

    -- Delete some last pre-step
    -- ['<BS>'] = --<function: delete some last pre-step>,

    -- Special configurations for common splits
    -- ['='] = --<function: enhanced setup for '='>,
    -- [','] = --<function: enhanced setup for ','>,
    -- ['|'] = --<function: enhanced setup for '|'>,
    -- [' '] = --<function: enhanced setup for ' '>,
  },

  -- Default options controlling alignment process
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },

  -- Default steps performing alignment (if `nil`, default is used)
  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after
  -- idle time if user input is required.
  silent = false,
}

-- vim: ts=2 sts=2 sw=2 et
