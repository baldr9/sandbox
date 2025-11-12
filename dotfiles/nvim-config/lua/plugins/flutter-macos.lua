return {
  -- Flutter Tools - Main plugin for Flutter development
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dat = true,
          exception_breakpoints = {},
          evaluate_to_string_in_debug_views = true,
          register_configurations = function(paths)
            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
              {
                type = "dart",
                request = "attach",
                name = "Connect to flutter",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,

                cwd = "${workspaceFolder}",
              },
            }
          end,
        },
        flutter_path = "/opt/flutter/bin/flutter", -- Auto-detect
        -- flutter_lookup_cmd = vim.fn.has("win32") == 1 and "where.exe flutter" or "which flutter",
        flutter_lookup_cmd = nil,
        fvm = false, -- Set to true if using FVM
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "Comment",
          prefix = "// ",
          enabled = true,
        },
        dev_log = {
          enabled = true,
          notify_errors = false,
          open_cmd = "tabedit",
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_attach = function(client, bufnr)
            -- Custom on_attach logic here if needed
          end,
          capabilities = function(config)
            local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
              config.capabilities =
                vim.tbl_deep_extend("force", config.capabilities or {}, cmp_nvim_lsp.default_capabilities())
            end
            return config.capabilities
          end,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
            -- Add Android Studio SDK path to excluded folders to improve performance
            analysisExcludedFolders = {
              -- Add your Android SDK path here
              "/home/rojasfe/Library/Android/sdk",
              -- Flutter SDK is already excluded by default
            },
          },
        },
      })
      -- Optional: Set up project configurations for different build flavors or targets
      require("flutter-tools").setup_project({
        {
          name = "Debug Windows",
          device = "macos", -- Use macOS desktop
          flavor = nil, -- Set your flavor if needed
          target = "lib/main.dart",
          default = true,
        },
        -- Add more configurations as needed
      })
    end,
    keys = {
      { "<leader>Fc", "<cmd>Telescope flutter commands<cr>", desc = "Flutter Commands" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>FR", "<cmd>FlutterReload<cr>", desc = "Flutter Reload" },
      { "<leader>Fs", "<cmd>FlutterRestart<cr>", desc = "Flutter Restart" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
      { "<leader>Ft", "<cmd>FlutterDevTools<cr>", desc = "Flutter DevTools" },
      { "<leader>Fl", "<cmd>FlutterLspRestart<cr>", desc = "Flutter LSP Restart" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
      { "<leader>FP", "<cmd>FlutterPubUpgrade<cr>", desc = "Flutter Pub Upgrade" },
      { "<leader>Fv", "<cmd>FlutterVisualDebug<cr>", desc = "Flutter Visual Debug" },
      { "<leader>Fw", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Copy Profiler URL" },
    },
  },

  -- DAP (Debug Adapter Protocol) for Flutter
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "dart" })
        end,
      },
    },
  },

  -- Treesitter for Dart syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dart" })
      end
    end,
  },

  -- Mason setup for Dart language server
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "dart-debug-adapter" })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = {
          -- This will be handled by flutter-tools
          mason = false,
        },
      },
    },
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        dart = { "dart_format" },
      },
      formatters = {
        dart_format = {
          command = "dart",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },

  -- File type detection
  {
    "nvim-lua/plenary.nvim",
    init = function()
      vim.filetype.add({
        extension = {
          dart = "dart",
        },
        pattern = {
          ["pubspec.yaml"] = "yaml.pubspec",
          ["analysis_options.yaml"] = "yaml.analysis_options",
        },
      })
    end,
  },

  -- Additional Dart/Flutter snippets
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    dependencies = {
      {
        "Nash0x7E2/awesome-flutter-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("data") .. "/lazy/awesome-flutter-snippets" },
          })
        end,
      },
    },
  },

  -- Autocmds for Dart files
  {
    "nvim-lua/plenary.nvim",
    init = function()
      local augroup = vim.api.nvim_create_augroup("DartSettings", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "dart",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
          vim.opt_local.colorcolumn = "80"
        end,
      })

      -- Auto format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        pattern = "*.dart",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
}
