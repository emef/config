require("config.lazy")

vim.keymap.set('i', 'jk', '<Esc>', {
  noremap = true,
  silent = true
})

vim.keymap.set('n', '<leader>R', ':source $MYVIMRC<CR>', {
  noremap = true
})

vim.api.nvim_set_keymap('i', '<F1>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<F1>', ':w<CR>', {
  noremap = true,
  silent = true
})
vim.keymap.set('i', '<F1>', '<Esc>:w<CR>a', {
  noremap = true,
  silent = true
})

vim.keymap.set('', '<F3>', '<C-w>w', {
  noremap = true,
  silent = true
})

vim.keymap.set('', '<M-CR>', function() vim.lsp.buf.code_action() end, {
  noremap = true,
  silent = true
})

vim.keymap.set('n', '<leader>cr',
  function()
    vim.lsp.buf.rename()
  end,
  {
    noremap = true,
    silent = true,
    desc = "rename"
  }
)

vim.keymap.set('n', '<leader>cl', function()
  vim.wo.cursorline = not vim.wo.cursorline
end, { desc = 'Toggle cursor line' })

vim.keymap.set('n', '<leader>f',
  function()
    if next(vim.lsp.get_clients()) ~= nil then
      vim.lsp.buf.format({ async = true })
    end
  end, {
    noremap = true,
    silent = true,
    desc = "Format buffer with LSP"
  }
)

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })

-- Navigate only through errors (skipping warnings, info, hints)
vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.ERROR } })
end, { desc = "Previous Error" })

vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.ERROR } })
end, { desc = "Next Error" })
--
-- leader prefix
vim.g.mapleader = " "

-- line numbers
vim.opt.number = true

-- chdir to file when opening with `nvim FILE`
vim.opt.autochdir = true

-- use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search config
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })

-- lsp
vim.api.nvim_create_user_command("LspReload", function()
  vim.lsp.stop_client(vim.lsp.get_clients({ buffer = 0 }))
  vim.cmd("edit")
end, {})


local augroup = vim.api.nvim_create_augroup('MyAutoCommands', { clear = true })

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if #vim.lsp.get_clients() > 0 then
      vim.lsp.buf.format({ async = true, timeout_ms = 2000 })
    end
  end,
})

-- delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {
      diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
      only = { "source.organizeImports" },
    }

    local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" })
    if #clients == 0 then
      return
    end

    local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    if not results then
      return
    end

    for cid, result in pairs(results or {}) do
      for _, action in pairs(result.result or {}) do
        if action.kind and vim.startswith(action.kind, "source.organizeImports") then
          -- Some servers need the action resolved first
          local client = vim.lsp.get_client_by_id(cid)
          local resolved = vim.lsp.buf_request_sync(0, "codeAction/resolve", action, 1000)

          if resolved and resolved[cid] and resolved[cid].result then
            local r = resolved[cid].result
            if r.edit then
              vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
            elseif r.command then
              client.request("workspace/executeCommand", r.command, nil, 0)
            end
          end
          return
        end
      end
    end
  end,
})

-- Ensure files end with a newline
vim.opt.fixeol = true
vim.opt.endofline = true

-- debug logs for lsp
vim.lsp.set_log_level 'debug'
