return {
	-- Add dart to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "dart" })
			end
		end,
	},

	-- Configure LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dartls = {
					-- Optional: add custom settings here
					settings = {
						dart = {
							completeFunctionCalls = true,
							showTodos = true,
						},
					},
				},
			},
		},
	},

	-- Ensure mason installs dart language server
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "dart-debug-adapter" })
		end,
	},
}
