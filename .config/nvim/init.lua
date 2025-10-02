-- Deshabilitar el explorador por defecto
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Habilitar colores de 24-bits
vim.opt.termguicolors = true

-- Incluir archivos de configuración
require('config')
require('config.lazy')
require('config.keymaps')

-- Incluir el lsp
require("lsp")

-- Números
vim.opt.relativenumber = true
