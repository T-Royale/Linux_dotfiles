local function my_on_attach(bufnr)
  	local api = require "nvim-tree.api"

  	local function opts(desc)
    		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  	end

  	api.config.mappings.default_on_attach(bufnr)
end

-- setup with some options
require("nvim-tree").setup({
	on_attach = my_on_attach,
	sort = {
		sorter = "case_sensitive",
  	},
  	view = {
		width = 40,
		side = "right",
  	},
  	renderer = {
    		group_empty = true,
  	},
  	filters = {
    		dotfiles = true,
 	},
	actions = {
		open_file = {
			quit_on_open = true
		}
	}
})
