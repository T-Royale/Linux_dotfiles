-- Leader = <space>
vim.g.mapleader = ' '
-- <leader>e 	-> abre el NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree" })
-- <leader>ff 	-> FindFiles
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files using Telescope" })
-- <lea<leader>gs 	-> GrepString
vim.keymap.set("n", "<leader>gs", function()
	local input = vim.fn.input("🔍 Buscar: ")
	if input ~= "" then
		require("telescope.builtin").grep_string({ search = input })
	end
end, { desc = "Telescope grep_string con input" })
-- <leader> w for autosave
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Alternar AutoSave" })

-- Terminal
vim.keymap.set("n", "<leader>ñ", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
end)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

