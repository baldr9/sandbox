return {
  -- Marksman LSP for navigation and completion
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
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
      require("lint").linters.markdownlint.args = {
        "--disable",
        "MD013", -- Disable line length rule
        -- Add more rules to disable:
        -- "--disable", "MD033", -- Disable inline HTML
        -- "--disable", "MD041", -- Disable first line heading
      }
    end,
    -- Alternative: Use .markdownlint.yaml config file under project root
  },
}
