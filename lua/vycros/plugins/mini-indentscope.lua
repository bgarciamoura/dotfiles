return {
	"echasnovski/mini.indentscope",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },

	config = function() 
		require("mini.indentscope").setup({
			symbol = "▏",
			draw = { delay = 0 },
			options = {
				indent_at_cursor = true,
			},
		})
		
		-- Disabling for some files
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Disable indentscope for certain filetypes",
			pattern = {
				"help",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"better_term",
				"toggleterm",
				"lazyterm",
				"nvimTree",
		      	},
		      	callback = function()
				vim.b.miniindentscope_disable = true
		      	end,
		})
	end
}
