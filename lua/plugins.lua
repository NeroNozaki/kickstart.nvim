-- Load plugin modules in order.

require 'plugins.ui'
require 'plugins.telescope'
require 'plugins.lsp'
require 'plugins.conform'
require 'plugins.completion'
-- require 'plugins.treesitter'
require 'plugins.color-scheme'

-- Optional / extra plugins and notes
--
-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins
--
--  Example plugins that were commented out in the original kickstart:
--  (uncomment and create the corresponding files under lua/kickstart/plugins/ if you want them)
--
-- require 'kickstart.plugins.debug'
require 'kickstart.plugins.indent_line'
-- require 'kickstart.plugins.lint'
-- require 'kickstart.plugins.autopairs'
-- require 'kickstart.plugins.neo-tree'

-- vim: ts=2 sts=2 sw=2 et
