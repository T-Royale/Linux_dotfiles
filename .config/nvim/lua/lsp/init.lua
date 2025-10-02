-- ============================================================================
-- Configuración de LSP en Neovim 0.11+
-- ============================================================================

-- Función para definir keymaps cuando un servidor se conecta
local function on_attach(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("n", "gd", vim.lsp.buf.definition, "Ir a definición")
	map("n", "K", vim.lsp.buf.hover, "Mostrar documentación")
	map("n", "gr", vim.lsp.buf.references, "Referencias")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar símbolo")

	vim.notify("LSP conectado: " .. client.name)
end

-- Configuración para clangd
vim.lsp.config("clangd", {
	on_attach = on_attach,
})

-- Configuración para rust-analyzer
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})

-- Importante: habilitar servidores
vim.lsp.enable("clangd")
vim.lsp.enable("rust_analyzer")

