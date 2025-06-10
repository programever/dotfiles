-- Using lazy.nvim to manage our plugins
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NeoVim Settings
vim.g.python3_host_prog = "./pyenv/bin/python"
vim.g.loaded_perl_provider = 0
vim.o.syntax = "on"
vim.cmd("filetype plugin indent on")

-- Editor behavior and appearance settings
vim.opt.switchbuf = "useopen,usetab" -- Controls buffer switching behavior, 'useopen' finds existing window, 'usetab' switches tabs
vim.opt.splitbelow = true -- split and focus
vim.opt.splitright = true -- split and focus
vim.opt.hlsearch = true -- Highlights matches of the last searched pattern
vim.opt.incsearch = true -- Shows incremental search highlights as you type
vim.opt.wrap = false -- Disables text wrapping
vim.opt.clipboard = "unnamed" -- System clipboard integration
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo" -- Save all undo
vim.opt.undofile = true
vim.opt.history = 500
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Move around Windows
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")

-- Insert a line break above
vim.keymap.set("n", "K", "0i<cr><esc>")

-- Switch between relative and absolute line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes" -- Always display the sign column, prevents text shifting when signs are displayed
vim.opt.number = true -- Enables line numbers on the left side of the window
vim.opt.cursorline = true -- Highlights the line under the cursor
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set relativenumber",
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	pattern = "*",
	command = "set norelativenumber",
})

-- File type overrides
vim.api.nvim_create_augroup("FileTypeOverrides", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.purs",
	command = "set filetype=purescript",
	group = "FileTypeOverrides",
})

-- Leader Mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>s", ":w<CR>")
vim.keymap.set("n", "<Leader>/", ":nohlsearch<CR>")
vim.keymap.set("n", "<Leader>k", "i<cr><esc>")
vim.keymap.set("n", "<Leader>y", "mcggVGy`c")
vim.keymap.set("n", "<Leader>l", ":vsp<CR>")
vim.keymap.set("n", "<Leader>j", ":sp<CR>")

--------------------
--- The plugins ----
--------------------
-- A dir for different workspaces to store neovim project-specific data
local workspace_data_dir = vim.fn.stdpath("data"):gsub("/$", "") .. vim.fn.getcwd():gsub("/$", "")

require("lazy").setup({
	-- AI Plugin
	-- https://github.com/Robitx/gp.nvim
	{
		"robitx/gp.nvim",
		dependencies = {
			-- copilot AI
			-- Run in neovim: `:Copilot setup`
			"github/copilot.vim",
		},
		config = function()
			require("gp").setup({
				default_chat_agent = "ChatCopilot",
				default_command_agent = "CodeCopilot",
				-- Keep each chat in it own directory
				chat_dir = workspace_data_dir .. "/gp/chats",
				state_dir = workspace_data_dir .. "/gp/persisted",
				log_file = workspace_data_dir .. "/gp.nvim.log",
				log_sensitive = true,
				providers = {
					copilot = {
						-- Requires Github Personal Access Token
						-- brew install gh
						-- gh auth login
						-- gh extension install github/gh-copilot
						endpoint = "https://api.githubcopilot.com/chat/completions",
						secret = {
							"bash",
							"-c",
							"cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
						},
					},
				},
				agents = {
					{
						provider = "copilot",
						name = "ChatCopilot",
						chat = true,
						command = false,
						model = { model = "gpt-4.1", temperature = 0 },
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "copilot",
						name = "CodeCopilot",
						chat = false,
						command = true,
						model = { model = "gpt-4.1", temperature = 0 },
						system_prompt = require("gp.defaults").code_system_prompt,
					},
				},
			})

			-- Keyboard shortcuts
			-- https://github.com/Robitx/gp.nvim?tab=readme-ov-file#shortcuts
			local function keymapOptions(desc)
				return {
					noremap = true,
					silent = true,
					nowait = true,
					desc = "AI Keymap: " .. desc,
				}
			end

			-- Chat commands
			vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle vsplit<cr>", keymapOptions("Open Chat"))
			vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual New Chat"))
			vim.keymap.set("n", "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
			vim.keymap.set("n", "<C-g>d", "<cmd>GpChatDelete<cr>", keymapOptions("Delete Chat"))
			vim.keymap.set("n", "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Delete Chat"))

			-- Editing commands
			vim.keymap.set({ "n", "i" }, "<C-g>i", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
			vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
			vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

			vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
			vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
			vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))

			vim.keymap.set({ "n", "i" }, "<C-g>p", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
			vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))

			vim.keymap.set("i", "<C-g>j", "<Plug>(copilot-previous)", keymapOptions("Previous suggestion"))
			vim.keymap.set("i", "<C-g>k", "<Plug>(copilot-next)", keymapOptions("Next suggestion"))
			vim.keymap.set("i", "<C-w>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
				desc = "Accept Copilot completion",
			})
		end,
	},

	-- colorscheme
	-- https://github.com/maxmx03/solarized.nvim
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized").setup({
				palette = "solarized",
				theme = "neo",
				enables = {
					editor = true,
					syntax = true,
					neotree = true,
				},
				highlights = function(colors)
					-- Solarized colors: https://ethanschoonover.com/solarized/
					return {
						Visual = { bg = colors.yellow, fg = colors.base03 },
						Search = { bg = colors.yellow, fg = colors.base03 },
						CurSearch = { bg = colors.orange, fg = colors.base03 },

						-- NeoTree colorscheme: https://github.com/loctvl842/monokai-pro.nvim/blob/master/lua/monokai-pro/theme/plugins/neo-tree.lua
						NeoTreeRootName = { fg = colors.blue },
						NeoTreeDirectoryIcon = { fg = colors.blue },
						NeoTreeDirectoryName = { fg = colors.blue },
					}
				end,
			})
			vim.o.background = "light"
			vim.cmd.colorscheme("solarized")
		end,
	},

	-- Syntax Highlight
	-- https://github.com/nvim-treesitter/nvim-treesitter
	-- brew install tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
				ensure_installed = {
					"lua",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"html",
					"typescript",
					"purescript",
				},
				sync_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	-- File explorer
	-- https://github.com/nvim-neo-tree/neo-tree.nvim
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- Requires: `brew tap homebrew/cask-fonts && brew install font-fira-code-nerd-font`
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				window = {
					width = 25,
				},
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
			})

			vim.keymap.set("n", "<Leader>n", ":Neotree source=filesystem toggle<CR>")
			vim.keymap.set("n", "<Leader>z", ":Neotree source=git_status toggle<CR>")
		end,
	},

	-- Status line Plugin
	-- https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			-- Requires: `brew tap homebrew/cask-fonts && brew install font-fira-code-nerd-font`
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = { theme = "onelight" },
			})
		end,
	},

	-- Indent lines Plugin
	-- https://github.com/nvimdev/indentmini.nvim
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup({
				indent = {
					chars = { "‥", "⁚" }, -- more code can be found in https://unicodeplus.com/

					style = {
						"#dbdbdb",
					},
				},
				chunk = {
					enable = true,
					use_treesitter = true,
					style = {
						{ fg = "#b58900" },
					},
				},
				blank = {
					enable = false,
				},
			})
		end,
	},

	-- Find files Plugin
	-- https://github.com/ibhagwan/fzf-lua
	-- Requires:
	-- brew install fzf
	-- brew install fd
	-- brew install bat
	-- brew install ripgrep
	-- brew install git-delta
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
			vim.keymap.set("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
			vim.keymap.set("n", "<c-b>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
			vim.keymap.set("n", "<c-f>", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
			vim.keymap.set("n", "<c-s>", "<cmd>lua require('fzf-lua').git_status()<CR>", { silent = true })
		end,
	},

	-- Git Plugin
	-- https://github.com/dinhhuy258/git.nvim
	-- Now we can :GitBlame
	{
		"dinhhuy258/git.nvim",
		config = function()
			require("git").setup({})
		end,
	},

	-- Auto-pair Plugin
	-- https://github.com/windwp/nvim-autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Surround Plugin
	-- https://github.com/kylechui/nvim-surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- Comment Plugin
	-- https://github.com/numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {
			-- add any options here
		},
	},

	-- UI to LSP Plugin
	-- https://nvimdev.github.io/lspsaga/
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local noremapsilent = { noremap = true, silent = true }

			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false, -- We using utilyre/barbecue.nvim
				},
				lightbulb = {
					enable = false,
				},
				finder = {
					keys = {
						toggle_or_open = "<CR>",
					},
				},
			})
			vim.keymap.set("n", "gj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", noremapsilent)
			vim.keymap.set("n", "gk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", noremapsilent)
			vim.keymap.set("n", "gh", "<Cmd>Lspsaga hover_doc<CR>", noremapsilent)
			vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", noremapsilent)
			vim.keymap.set("n", "gr", "<Cmd>Lspsaga finder ref<CR>", noremapsilent)
			vim.keymap.set("n", "gn", "<Cmd>Lspsaga rename<CR>", noremapsilent)
			vim.keymap.set("n", "ga", "<Cmd>Lspsaga code_action<CR>", noremapsilent)
			vim.keymap.set("n", "gl", "<Cmd>Lspsaga preview_definition<CR>", noremapsilent)
		end,
	},

	-- winbar Plugin (bar at the top of the editor)
	-- https://github.com/utilyre/barbecue.nvim
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
			"maxmx03/solarized.nvim", -- We using the colors function
		},
		opts = {
			-- configurations go here
		},
		config = function()
			require("barbecue").setup({
				theme = {},
			})
		end,
	},

	-- CodeLen Plugin
	-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup({})
			-- Disable virtual_text since it's redundant due to lsp_lines.
			vim.diagnostic.config({
				virtual_text = false,
			})

			vim.keymap.set("", "<Leader>e", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
		end,
	},

	-- Snippet Plugin
	-- https://github.com/L3MON4D3/luasnip
	-- No snippets have been installed yet
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},

	-- Autocomplete Plugin
	-- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
				}),
				formatting = {
					format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
				},
			})

			vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
      ]])
		end,
	},

	-- Code Formatter Plugin
	-- https://github.com/stevearc/conform.nvim
	-- brew install stylua
	-- npm install -g @fsouza/prettierd
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", "prettierd" },
				javascriptreact = { "prettier", "prettierd" },
				typescript = { "prettier", "prettierd" },
				typescriptreact = { "prettier", "prettierd" },
				purescript = { "purs-tidy" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- LSP Config Plugin
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- TypeScript LSP
			-- We are using pmizio/typescript-tools.nvim plugin
			-- which installs itself directly so we don't configure it here

			-- Purescript LSP
			-- npm i -g purescript-language-server purs-tidy
			lspconfig.purescriptls.setup({
				-- https://github.com/nwolverson/purescript-language-server?tab=readme-ov-file#neovims-built-in-language-server--nvim-lspconfig
				settings = {
					capabilities = capabilities,
					purescript = {
						addSpagoSources = true, -- e.g. any purescript language-server config here
						formatter = "purs-tidy",
					},
				},
				flags = {
					debounce_text_changes = 150,
				},
			})

			-- Lua LSP
			-- brew install lua-language-server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},

	-- TypeScript LSP
	-- https://github.com/pmizio/typescript-tools.nvim
	-- npm install -g typescript typescript-language-server
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			code_lens = "all", -- "off" | "all" | "implementations_only" | "references_only"
		},
		config = function()
			require("typescript-tools").setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, _)
					-- Disable formatting from the language server
					-- We use stevearc/conform.nvim
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})
		end,
	},

	-- Purescript
	-- https://github.com/purescript-contrib/purescript-vim
	{ "purescript-contrib/purescript-vim" },

	-- Markdown
	{
		"preservim/vim-markdown",
		ft = "markdown",
		config = function()
			vim.keymap.set("n", "<leader>m", "za", { desc = "Toggle fold" })
			vim.keymap.set("n", "<leader>mo", "zR", { desc = "Open all folds" })
			vim.keymap.set("n", "<leader>ml", "zM", { desc = "Close all folds" })
		end,
	},

	-- Terminal in NVIM
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "horizontal",
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return 50
					end
				end,
			})
			vim.keymap.set(
				"n",
				"<leader>t",
				"<cmd>ToggleTerm direction=horizontal<CR>",
				{ desc = "Horizontal Terminal" }
			)
			vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical Terminal" })
			vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Floating Terminal" })
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
		end,
	},
})
