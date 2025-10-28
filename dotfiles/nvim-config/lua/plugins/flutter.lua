return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false, -- load immediately, or you can choose lazy-loading as needed
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional, for vim.ui.select UI enhancement
    },
    config = function()
      require("flutter-tools").setup({})
    end,
  },
}
