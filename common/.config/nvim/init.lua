-- Deshabilitar el explorador por defecto
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Habilitar colores de 24-bits
vim.opt.termguicolors = true

-- Incluir archivos de configuración
require('config')
require('config.lazy')
require('config.keymaps')

-- Números
vim.opt.relativenumber = true

-- Portapapeles
vim.opt.clipboard:append("unnamedplus")

-- tab=4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim terminal config
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', {clear = true}),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
