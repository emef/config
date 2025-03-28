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

vim.keymap.set('', '<F3>', '<C-w>w', {
  noremap = true,
  silent = true
})

vim.keymap.set('n', '<leader>rn',
  function()
    vim.lsp.buf.rename()
  end,
  {
    noremap = true,
    silent = true,
    desc = "rename"
  }
)

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

-- lsp
vim.api.nvim_create_user_command("LspReload", function()
  vim.lsp.stop_client(vim.lsp.get_clients({ buffer = 0 }))
  vim.cmd("edit")
end, {})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if #vim.lsp.get_clients() > 0 then
      vim.lsp.buf.format({ async = true, timeout_ms = 2000 })
    end
  end,
})

-- delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Ensure files end with a newline
vim.opt.fixeol = true
vim.opt.endofline = true
