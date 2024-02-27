return {
	"rmagatti/session-lens",
	requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	config = function()
		require("session-lens").setup({
			previewer = true,
			prompt_title = "SAVED SESSIONS",
		})
	end
}
