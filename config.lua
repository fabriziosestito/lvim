--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
lvim.builtin.treesitter.indent = { enable = true, disable = { "go" } }
-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["g"]["m"] = { "<cmd>DiffviewOpen origin/main<cr>", "Git diff main" }

-- -- Change theme settings
lvim.colorscheme = "oxocarbon"
-- lvim.colorscheme = "desert"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ensure_installed = {
	"go",
	"gomod",
}
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "lua_ls" })

-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"yaml",
			"yml",
			"markdown",
			"json",
		},
	},
	{ command = "taplo", filetypes = { "toml" } },
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
})

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

lvim.plugins = {
	{ "mcchrish/zenbones.nvim" },
	{ "folke/trouble.nvim" },
	{ "rose-pine/neovim", dependencies = "rktjmp/lush.nvim" },
	{ "franbach/miramare" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{
		"ray-x/sad.nvim",
		dependencies = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		config = function()
			require("sad").setup({})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
					suggestion = { enabled = true, auto_trigger = true },
					filetypes = { yaml = true, markdown = true },
				})
			end, 100)
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function() end,
		-- ft = { "rust", "rs" },
	},
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				cut_key = "x",
				override_del = true,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"rhaiscript/vim-rhai",
	},
	{
		"sindrets/diffview.nvim",
	},
	{
		"olexsmir/gopher.nvim",
		"leoluz/nvim-dap-go",
	},
}

-- -- fab config
-- mappings
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["S"] = { "<cmd>Spectre<CR>", "Spectre" }

-- configure rust-tools
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local status_ok_rust_tools, rust_tools = pcall(require, "rust-tools")
if not status_ok_rust_tools then
	return
end

local opts = {
	tools = {
		executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
		reload_workspace_from_cargo_toml = true,
		inlay_hints = {
			auto = true,
			only_current_line = false,
			show_parameter_hints = false,
			parameter_hints_prefix = "<-",
			other_hints_prefix = "=>",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = {
			--border = {
			--        { "╭", "FloatBorder" },
			--        { "─", "FloatBorder" },
			--        { "╮", "FloatBorder" },
			--        { "│", "FloatBorder" },
			--        { "╯", "FloatBorder" },
			--        { "─", "FloatBorder" },
			--        { "╰", "FloatBorder" },
			--        { "│", "FloatBorder" },
			--},
			auto_focus = true,
		},
	},
	server = {
		on_attach = require("lvim.lsp").common_on_attach,
		on_init = require("lvim.lsp").common_on_init,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}
rust_tools.setup(opts)

-- configure crates.nvim
local status_ok_cmp, cmp = pcall(require, "cmp")
if not status_ok_cmp then
	return
end
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		cmp.setup.buffer({ sources = { { name = "crates" } } })
	end,
})

-- folding powered by treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
-- look for foldenable: https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
-- Vim cheatsheet, look for folds keys: https://devhints.io/vim
vim.opt.foldmethod = "expr" -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false -- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.

-- configure go related plugins
--
--
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
	return
end

dapgo.setup()

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
	on_attach = function(client, bufnr)
		require("lvim.lsp").common_on_attach(client, bufnr)
		local _, _ = pcall(vim.lsp.codelens.refresh)
		local map = function(mode, lhs, rhs, desc)
			if desc then
				desc = desc
			end

			vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
		end
		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				["C"] = {
					name = "Go",
					["i"] = { "<cmd>GoInstallDeps<cr>", "Install Go Dependencies" },
					["t"] = { "<cmd>GoMod tidy<cr>", "Tidy" },
					["a"] = { "<cmd>GoTestAdd<Cr>", "Add Test" },
					["A"] = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
					["e"] = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
					["g"] = { "<cmd>GoGenerate<Cr>", "Go Generate" },
					["f"] = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
					["c"] = { "<cmd>GoCmt<Cr>", "Generate Comment" },
				},
			},
		}, { prefix = "<leader>" })

		-- lvim.builtin.which_key.mappings["C"]["i"] = { "<cmd>GoInstallDeps<cr>", "Install Go Dependencies" }
		-- -- map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
		-- map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
		-- map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
		-- map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
		-- map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
		-- map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
		-- map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
		-- map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
		-- map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
	end,
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
	settings = {
		gopls = {
			usePlaceholders = true,
			gofumpt = true,
			codelenses = {
				generate = false,
				gc_details = true,
				test = true,
				tidy = true,
			},
		},
	},
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
	},
})

require("lspconfig").grammarly.setup({})
require("lspconfig").jsonls.setup({})
