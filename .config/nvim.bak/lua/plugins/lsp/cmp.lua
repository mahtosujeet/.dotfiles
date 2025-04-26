-- lazy says use opts={} instead of config=function() req("p").setup{}
return {
	"hrsh7th/nvim-cmp",
	-- event = "BufEnter",
	dependencies = {
		{ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" }, -- Add cmp-path for path completions
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
		{ "neovim/nvim-lspconfig" },
	},
	config = function()
		-- lsp-zero
		local lsp_zero = require("lsp-zero")
		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()
		local cmp_format = require("lsp-zero").cmp_format({ details = false })
		local mason_lspconfig = require("mason-lspconfig")

		-- Define LSP keymaps in a separate function
		local function set_lsp_keymaps(bufnr)
			local opts = { buffer = bufnr }
			local maps = {
				["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover documentation" },
				["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
				["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
				["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
				["go"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition" },
				["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Find references" },
				["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
				["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
				["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format code" },
				["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" },
				["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
				["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
				["<leader>lq"] = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Set loclist (quick fix)" },
				["<leader>ll"] = {
					'<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<cr>',
					"Show line diagnostics",
				},
				["<leader>lL"] = {
					'<cmd>lua vim.diagnostic.open_float(0, { scope = "project" })<cr>',
					"Show project diagnostics",
				},
				["<leader>lw"] = {
					'<cmd>lua vim.diagnostic.open_float(0, { scope = "workspace" })<cr>',
					"Show workspace diagnostics",
				},
				["<leader>lW"] = {
					'<cmd>lua vim.diagnostic.open_float(0, { scope = "document" })<cr>',
					"Show document diagnostics",
				},
			}

			for k, v in pairs(maps) do
				vim.keymap.set("n", k, v[1], { desc = v[2], buffer = bufnr })
			end
		end

		-- Configure LSP hover handler to add border
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		-- LSP attach function
		local lsp_attach = function(client, bufnr)
			lsp_zero.buffer_autoformat()
			set_lsp_keymaps(bufnr)
		end

		-- Default capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Custom Server configurations
		local servers = {
			lua_ls = {
				lsp_zero.nvim_lua_ls(),
				on_attach = lsp_attach,
				capabilities = capabilities,
			},
			bashls = {
				on_attach = lsp_attach,
				filetypes = { "sh", "zsh" },
				capabilities = capabilities,
			},
		}

		-- Setup servers
		mason_lspconfig.setup({
			-- ensure_installed = vim.tbl_keys(servers),
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup(servers[server_name] or {
						on_attach = lsp_attach,
						capabilities = capabilities,
					})
				end,
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").load_standalone({
			-- add custom snippets to /snippets/<filetype>.code-snippets
			-- then add the path to the snippets here
			path = "./snippets/cpp.code-snippets",
		})

		-- trnasparent border bg
		local function get_custom_border()
			return cmp.config.window.bordered({
				winhighlight = cmp.config.window.bordered().winhighlight:gsub(":FloatBorder", ":CustomFloatBorder"),
			})
		end

		cmp.setup({
			window = {
				-- completion = cmp.config.window.bordered(),
				completion = get_custom_border(),
				documentation = get_custom_border(),
			},
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp_action.luasnip_supertab(),
				["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "supermaven" },
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "buffer", group_index = 2 },
				{ name = "path", group_index = 2 },
			}),
			--- (Optional) Show source name in completion menu
			formatting = cmp_format,
			experimental = {
				ghost_text = true,
			},
		})
		vim.cmd("highlight! BorderBG guibg=NONE guifg=#00ff00")
	end,
}
