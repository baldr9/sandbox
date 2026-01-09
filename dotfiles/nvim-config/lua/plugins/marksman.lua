return {
	-- Marksman LSP for navigation and completion
	-- Use .markdownlint.yaml config file under project root
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
}
