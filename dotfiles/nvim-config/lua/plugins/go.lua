return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
  },
  ft = { "go", "gomod" },
  event = "CmdlineEnter",
  build = ':lua require("go.install").update_all_sync()',

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Setup go.nvim
    require("go").setup({
      lsp_cfg = {
        capabilities = capabilities,
      },
    })

    -- Configure gopls with additional settings
    require("lspconfig").gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
}
