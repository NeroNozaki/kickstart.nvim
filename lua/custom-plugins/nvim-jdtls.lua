vim.pack.add { gh "mfussenegger/nvim-jdtls" }

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'java',
	callback = function()
		-- ~/.config/nvim/ftplugin/java.lua
		-- Uses the JDTLS you already have from Emacs (no Mason download)

		local jdtls = require 'jdtls'

		-- ↓↓↓ PUT THE REAL PATH YOU FOUND HERE ↓↓↓
		local jdtls_install = vim.fn.expand '~/.emacs.d/share/eclipse.jdt.ls'  -- change this

		-- Platform-specific config folder
		local config_dir = (vim.fn.has 'mac' == 1 and 'config_mac')
		or (vim.fn.has 'unix' == 1 and 'config_linux')
		or 'config_win'

		-- One workspace directory per project (required by jdtls)
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
		local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls-workspace/' .. project_name

		local config = {
			-- Prefer the bin/jdtls script if it exists
			cmd = {
				jdtls_install .. '/bin/jdtls',
				'-data', workspace_dir,
			},

			-- If the script is missing, comment the cmd above and use this instead:
			-- cmd = {
			--   'java',
			--   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
			--   '-Dosgi.bundles.defaultStartLevel=4',
			--   '-Declipse.product=org.eclipse.jdt.ls.core.product',
			--   '-Dlog.protocol=true',
			--   '-Dlog.level=ALL',
			--   '-Xmx1g',
			--   '--add-modules=ALL-SYSTEM',
			--   '--add-opens', 'java.base/java.util=ALL-UNNAMED',
			--   '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
			--   '-jar', vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
			--   '-configuration', jdtls_install .. '/' .. config_dir,
			--   '-data', workspace_dir,
			-- },

			root_dir = require('jdtls.setup').find_root {
				'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'build.gradle.kts',
			},

			settings = {
				java = {
					-- Optional later: tell jdtls about extra JDKs
					-- configuration = {
					--   runtimes = {
					--     { name = 'JavaSE-21', path = '/path/to/jdk-21', default = true },
					--   },
					-- },
				},
			},
		}

		jdtls.start_or_attach(config)
	end,
})
