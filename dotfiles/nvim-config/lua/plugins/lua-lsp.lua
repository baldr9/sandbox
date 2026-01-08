return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            workspace = {
              checkThirdParty = false,
            },
            diagnostics = {
              globals = { "vim" },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            hint = {
              enable = true,
              setType = true,
            },
          },
        },
      },
    },
  },
  -- example calling setup directly for each LSP
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Enable formatting
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
