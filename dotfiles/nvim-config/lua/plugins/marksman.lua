return {
	-- Marksman LSP for navigation and completion
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			-- Auto-install marksman via mason
			{
				"mason-org/mason.nvim",
				opts = {
					ensure_installed = {
						"marksman",
					},
				},
			},
		},
		opts = {
			servers = {
				marksman = {},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
		end,
	},

	-- Markdownlint for linting (MD rules)
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint" },
			},
		},
		config = function()
			-- markdownlint github.com/DavidAnson/markdownlint
			-- Alternative: Use .markdownlint.yaml config file under project root
			require("lint").linters.markdownlint.args = {
				"--disable",
				"MD013", -- Disable line length rule
				-- Add more rules to disable:
				-- "--disable", "MD033", -- Disable inline HTML
				-- "--disable", "MD041", -- Disable first line heading
			}

			-- Keybinding to manually trigger linting
			vim.keymap.set("n", "<leader>cl", function()
				require("lint").try_lint()
			end, { desc = "Lint current file" })

			-- Auto-lint on save and text change
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				pattern = { "*.md", "*.markdown" },
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
