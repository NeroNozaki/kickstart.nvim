-- Basic keymaps and autocmds

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = true, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-- Makes the cursor stay in place when leaving insert mode
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function() vim.cmd 'normal! `^' end,
})

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left [W]indow' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right [W]indow' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower [W]indow' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper [W]indow' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Delete previous word (Ctrl-Backspace)
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = 'Delete previous word' })
-- Many terminals actually send <C-h> for Ctrl-Backspace
-- vim.keymap.set('i', '<C-h>', '<C-w>', { desc = 'Delete previous word' })

-- Delete next word (Ctrl-Delete)
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = 'Delete next word' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Close windows easier
vim.keymap.set('n', '<leader>0', '<cmd>hid<CR>', { desc = 'Delete current window' })
vim.keymap.set('n', '<leader>1', '<cmd>on<CR>', { desc = 'Delete other windows' })


vim.keymap.set('n', '-', '<cmd>Oil<CR>')

-- 2. Map Ctrl+V to paste in Insert and Command-line modes
vim.keymap.set({"i", "c"}, "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })

-- 3. Map Ctrl+C to copy (yank) the current selection in Visual mode
vim.keymap.set("v", "<C-c>", '"+y`>a', { desc = "Copy to system clipboard" })

-- 4. Map Ctrl+X to cut in Visual mode
vim.keymap.set("v", "<C-x>", '"+x`>a', { desc = "Cut to system clipboard" })

-- 5. Optional: Map Ctrl+Z for Undo in Normal and Insert modes
vim.keymap.set("i", "<C-z>", "<cmd>undo<CR>", { desc = "Undo" })

-- Safely remove any custom mapping for Ctrl-v in normal mode,
-- restoring Neovim's default blockwise-visual behavior.
pcall(vim.keymap.del, 'n', '<C-v>')


local function scroll_view(lines)
  local view = vim.fn.winsaveview()
  view.topline = view.topline + lines
  vim.fn.winrestview(view)
end

vim.keymap.set('n', '<M-j>', function() scroll_view(math.floor(vim.api.nvim_win_get_height(0) / 2)) end,
  { desc = 'Scroll down by half a screen' })

vim.keymap.set('n', '<M-k>', function() scroll_view(-math.floor(vim.api.nvim_win_get_height(0) / 2)) end,
  { desc = 'Scroll up by half a screen' })

vim.keymap.set('n', '<C-M-j>', '<C-e>', { desc = 'Move the view port down one line' })
vim.keymap.set('n', '<C-M-k>', '<C-y>', { desc = 'Move the view port up one line' })

-- vim: ts=2 sts=2 sw=2 et
