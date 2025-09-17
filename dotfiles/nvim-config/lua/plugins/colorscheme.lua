return {
  -- Add the Material.nvim plugin
  { "marko-cerovac/material.nvim" },

  -- Configure LazyVim to use the Material color scheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material-darker",
    },
  },
}
