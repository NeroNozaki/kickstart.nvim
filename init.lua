--[[
  Modular kickstart-based config (manually split from single-file init.lua).
  Uses Neovim's built-in vim.pack plugin manager.

  Structure:
    lua/options.lua          -- core options + leaders
    lua/keymaps.lua          -- basic keymaps + autocmds
    lua/pack.lua             -- vim.pack hooks + gh() helper
    lua/plugins/init.lua     -- loads plugin modules in order
    lua/plugins/*.lua        -- individual plugin groups
    lua/custom-plugins/      -- your own plugins (auto-loaded)
    lua/snippets/            -- LuaSnip Lua snippets
--]]

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps & Autocmds ]]
require 'keymaps'

-- [[ vim.pack setup (build hooks + gh helper) ]]
require 'pack'

-- [[ Configure and install plugins ]]
require 'plugins'

-- Your custom plugin modules (auto-loads lua/custom-plugins/*.lua)
require 'custom-plugins'

-- vim: ts=2 sts=2 sw=2 et
