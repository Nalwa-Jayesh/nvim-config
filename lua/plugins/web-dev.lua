return {
	-- JSON Schema support
	{
		"b0o/schemastore.nvim",
		lazy = true,
		ft = { "json", "jsonc" },
	},

	-- TypeScript utilities
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = {
			settings = {
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
				-- "remove_unused_imports"|"organize_imports") -- or string "all"
				-- to include all supported code actions
				expose_as_code_action = {},
				-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
				-- not exists then standard path resolution strategy is applied
				tsserver_path = nil,
				-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
				-- (see 💅 `styled-components` support section)
				tsserver_plugins = {},
				-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
				-- memory limit in megabytes or "auto"(basically no limit)
				tsserver_max_memory = "auto",
				-- described below
				tsserver_format_options = {},
				tsserver_file_preferences = {},
				-- locale of all tsserver messages, supported locales you can find here:
				-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
				tsserver_locale = "en",
				-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
				complete_function_calls = false,
				include_completions_with_insert_text = true,
				-- CodeLens
				-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
				-- possible values: ("off"|"all"|"implementations_only"|"references_only")
				code_lens = "off",
				-- by default code lenses are displayed on all referencable values and for some of you it can
				-- be too much this option reduce count of them by removing member references from lenses
				disable_member_code_lens = true,
				-- JSXCloseTag
				-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
				-- that maybe have a conflict if enable this feature. )
				jsx_close_tag = {
					enable = false,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
		},
	},

	-- Auto-close HTML/JSX tags
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml" },
		opts = {
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		},
	},

	-- Better JSX/TSX syntax highlighting and editing
	{
		"maxmellon/vim-jsx-pretty",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},

	-- Tailwind CSS class sorting and utilities
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		opts = {
			document_color = {
				enabled = true, -- can be toggled by commands
				kind = "inline", -- "inline" | "foreground" | "background"
				inline_symbol = "●", -- only used in inline mode
				debounce = 200, -- in milliseconds, only applied in insert mode
			},
			conceal = {
				enabled = false, -- can be toggled by commands
				min_length = nil, -- only conceal classes exceeding the provided length
				symbol = "󱏿", -- only a single character is allowed
				highlight = {
					fg = "#38BDF8", -- hex color or color name
				},
			},
			cmp = {
				highlight = "foreground", -- color preview method, "foreground" | "background"
			},
		},
	},

	-- Package.json utilities
	{
		"vuki656/package-info.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		ft = "json",
		opts = {
			colors = {
				up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
				outdated = "#d19a66", -- Text color for outdated dependency virtual text
			},
			icons = {
				enable = true, -- Whether to display icons
				style = {
					up_to_date = "|  ", -- Icon for up to date dependencies
					outdated = "|  ", -- Icon for outdated dependencies
				},
			},
			autostart = true, -- Whether to autostart when `package.json` is opened
			hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
			hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
		},
		keys = {
			{ "<leader>ns", "<cmd>lua require('package-info').show()<cr>", desc = "Show package versions" },
			{ "<leader>nc", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package versions" },
			{ "<leader>nt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle package versions" },
			{ "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package on line" },
			{ "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package on line" },
			{ "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install new package" },
			{ "<leader>np", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
		},
	},

	-- REST client for API testing
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "http",
		opts = {
			-- Open request results in a horizontal split
			result_split_horizontal = false,
			-- Keep the http file buffer above|left when split horizontal|vertical
			result_split_in_place = false,
			-- Stay in request buffer when executing
			stay_in_current_window_after_split = false,
			-- Skip SSL verification, useful for unknown certificates
			skip_ssl_verification = false,
			-- Encode URL before making request
			encode_url = true,
			-- Highlight request on run
			highlight = {
				enabled = true,
				timeout = 150,
			},
			result = {
				-- toggle showing URL, HTTP info, headers at top the of result window
				show_url = true,
				-- show the generated curl command in case you want to launch it
				show_curl_command = false,
				show_http_info = true,
				show_headers = true,
				-- table of curl `--write-out` variables or false if disabled
				show_statistics = false,
				-- executables or functions for formatting response body [optional]
				-- set them to false if you want to disable them
				formatters = {
					json = "jq",
					html = function(body)
						return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
					end,
				},
			},
		},
		keys = {
			{ "<leader>rr", "<cmd>Rest run<cr>", desc = "Run request under cursor" },
			{ "<leader>rl", "<cmd>Rest run last<cr>", desc = "Re-run last request" },
		},
	},
}
