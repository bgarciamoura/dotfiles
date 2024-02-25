return {
	
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			dim_inactive = {
				enabled = false,
			},
			integrations = {
				treesitter = true
			}
		})
	end,
}
