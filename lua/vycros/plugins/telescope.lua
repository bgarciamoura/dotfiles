return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function() 
		local builtin = require("telescope.builtin")
		local keymap = vim.keymap
		local telescope = require("telescope")

		telescope.setup({
			pickers = {
				colorscheme = {
					enable_preview = true
				}
			}
		})

		-- Telescope keymappings
		keymap.set({"n","v","x"}, "<leader>ff", builtin.find_files, { desc = "Open the telescope plugin UI to find files", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fg", builtin.live_grep, { desc = "Open the telescope UI to live grep", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fb", builtin.buffers, { desc = "Open the telescope UI to find in buffers", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fh", builtin.help_tags, { desc = "Open the telescope UI to find configs for plugins", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fi", builtin.git_files, { desc = "Open the telescope UI to find only files that is in git repository", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fo", builtin.oldfiles, { desc = "List the recently opened files", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fc", builtin.commands, { desc = "Open the telescope UI to list plugin/user commands and runs them on <CR>", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>ft", builtin.colorscheme, { desc = "List available colorschemes and applies them on <CR>", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fv", builtin.vim_options, { desc = "List vim options and allows to edit the current value on <CR>", noremap = true, silent = true })
		keymap.set({"n","v","x"}, "<leader>fk", builtin.keymaps, { desc = "List all normal mode keymaps", noremap = true, silent = true })
	end
}
