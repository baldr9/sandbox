return {
  -- Disable nvim-cmp and related plugins
  { "hrsh7th/nvim-cmp",     enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "hrsh7th/cmp-buffer",   enabled = false },
  { "hrsh7th/cmp-path",     enabled = false },

  -- Setup blink.cmp
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v1.*",

    opts = {
      -- Keymap presets: 'default' | 'super-tab' | 'enter'
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },

      signature = { enabled = true },
    },
  },
}
