# Modular Neovim config (split from your kickstart init.lua)

This is a manual, bottom-up split of your existing single-file kickstart config.
Everything you had is preserved, including:

- diagnostic virtual_lines + auto-float on jump
- InsertLeave cursor restore
- Ctrl-Backspace / Ctrl-Delete in insert mode
- telescope-cmdline
- Mason tools for Godot (`gdscript-formatter`, `gdtoolkit`)
- GDScript LSP autocmd
- habamax/vim-godot
- custom.plugins + core requires
- LuaSnip loading from `lua/snippets`

## Layout

```
nvim/
├── init.lua                 # thin loader
├── lua/
│   ├── options.lua          # leaders + options
│   ├── keymaps.lua          # basic keymaps + autocmds
│   ├── pack.lua             # PackChanged hooks + gh() helper
│   ├── kickstart/           # kickstart's own optional plugins
│   ├── plugins/
│   │   ├── init.lua         # requires the modules below in order
│   │   ├── ui.lua           # guess-indent, gitsigns, which-key, tokyonight, todo-comments, mini.*
│   │   ├── telescope.lua
│   │   ├── lsp.lua          # includes GDScript setup
│   │   ├── conform.lua
│   │   ├── completion.lua   # luasnip + blink.cmp
│   │   ├── treesitter.lua
│   │   ├── colorscheme.lua # installs and applies colorscheme
│   │   └── extra.lua        # vim-godot + notes
│   ├── custom-plugins/      # drop your own plugin files here
│   └── snippets/            # LuaSnip Lua snippets (already referenced)
└── README.md
```

## How to install

1. **Back up** your current config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Copy this tree into place:
   ```bash
   cp -r /path/to/nvim-config ~/.config/nvim
   ```
   (Or symlink, or `git init` inside it — whatever you prefer.)

3. If you already had files under `lua/custom/plugins/` or `lua/core/` or `lua/snippets/` in the old config, copy them over from the backup.

4. Start Neovim. `vim.pack` will install any missing plugins on first run (confirm when prompted).

5. Update plugins later with:
   ```vim
   :lua vim.pack.update()
   ```

## Notes

- `gh()` is defined globally in `lua/pack.lua` so every plugin file can use `gh 'owner/repo'`.
- Requires **Neovim 0.12+** (for `vim.pack`).

## Next steps (optional)

Once this is running, you can keep refining bottom-up:

- Move individual plugins out of `ui.lua` into their own files if a group gets large.
- Add more files under `lua/custom-plugins/`.
- Tighten leader key organization further (which-key groups are already started).
