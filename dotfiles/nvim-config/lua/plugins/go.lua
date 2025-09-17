return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
  },
  config = function()
    require("go").setup({
      -- General settings
      goimports = 'gopls', -- Use gopls for imports
      fillstruct = 'gopls', -- Use gopls for struct filling
      dap_debug = true, -- Enable debug adapter protocol
      dap_debug_gui = {}, -- Enable DAP GUI elements
      
      -- Test settings
      test_runner = 'go', -- Test runner: 'go', 'richgo', 'dlv', 'ginkgo', 'gotestsum'
      test_timeout = '30s',
      test_efm = true, -- Set to true to enable error format
      test_tags = '', -- Additional build tags for tests
      
      -- Build settings
      build_tags = '', -- Build tags for go build
      textobjects = false, -- Disable text objects to avoid treesitter config issues
      
      -- LSP settings
      lsp_cfg = true, -- Auto setup LSP config
      lsp_gofumpt = true, -- Use gofumpt for formatting
      lsp_on_attach = nil, -- Custom on_attach function
      lsp_keymaps = true, -- Set to false to disable default keymaps
      lsp_codelens = true, -- Enable code lens
      
      -- Diagnostic settings
      lsp_diag_hdlr = true, -- Hook lsp diag handler
      lsp_diag_underline = true,
      lsp_diag_virtual_text = { space = 0, prefix = "■" },
      lsp_diag_signs = true,
      lsp_diag_update_in_insert = false,
      
      -- Formatting
      lsp_document_formatting = true,
      lsp_inlay_hints = {
        enable = true,
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refresh of the inlay hints
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },
      
      -- Go tools
      gopls_cmd = nil, -- Custom gopls command
      gopls_remote_auto = true,
      gocoverage_sign = "█",
      sign_priority = 5,
      dap_debug_keymap = true, -- Set keymaps for debugger
      dap_debug_vt = true, -- Enable virtual text for debugger
      
      -- UI settings
      floaterm = { -- Position of floating terminal
        posititon = 'auto', -- One of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
        width = 0.45, -- Width of the floating window
        height = 0.98, -- Height of the floating window
      },
      
      trouble = false, -- Set to true to enable trouble integration
      luasnip = false, -- Set to true to enable luasnip integration
    })
    
    -- Auto commands for Go files
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()', -- Install/update all binaries
}