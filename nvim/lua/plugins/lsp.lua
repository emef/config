return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ruff" }
      })

      local nvim_config_path = vim.fn.stdpath("config")

      require("lspconfig").ruff.setup({})
      require("lspconfig").pyright.setup({})

      require("lspconfig").lua_ls.setup({
        root_dir = function(filename, _)
          -- Check if the file is in your Neovim config directory
          if filename:find(nvim_config_path, 1, true) == 1 then
            return nvim_config_path
          end
          -- Fall back to the default root detection
          return require("lspconfig.util").find_git_ancestor(filename)
              or require("lspconfig.util").root_pattern(".neoconf.json", "lua/")(filename)
        end,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
          },
        },

        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force',
            client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
              }
            })
        end,
      })
    end
  },
}
