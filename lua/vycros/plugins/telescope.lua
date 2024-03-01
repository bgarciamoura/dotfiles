return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "andrew-george/telescope-themes",
  },
  config = function()
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap
    local telescope = require("telescope")

    telescope.setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })

    -- telescope.load_extension("session-lens")
    telescope.load_extension("themes")
    telescope.load_extension("emoji")

    -- Telescope keymappings
    keymap.set(
      { "n", "v", "x" },
      "<leader>ff",
      builtin.find_files,
      { desc = "Open the telescope plugin UI to find files", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fg",
      builtin.live_grep,
      { desc = "Open the telescope UI to live grep", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fb",
      builtin.buffers,
      { desc = "Open the telescope UI to find in buffers", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fh",
      builtin.help_tags,
      { desc = "Open the telescope UI to find configs for plugins", noremap = true, silent = true }
    )
    keymap.set({ "n", "v", "x" }, "<leader>fi", builtin.git_files, {
      desc = "Open the telescope UI to find only files that is in git repository",
      noremap = true,
      silent = true,
    })
    keymap.set(
      { "n", "v", "x" },
      "<leader>fo",
      builtin.oldfiles,
      { desc = "List the recently opened files", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fc",
      builtin.commands,
      { desc = "List all plugins/user commands and runs on <CR>", noremap = true, silent = true }
    )
    keymap.set({ "n", "v", "x" }, "<leader>fv", builtin.vim_options, {
      desc = "List vim options and allows to edit the current value on <CR>",
      noremap = true,
      silent = true,
    })
    keymap.set(
      { "n", "v", "x" },
      "<leader>fk",
      builtin.keymaps,
      { desc = "List all normal mode keymaps", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fs",
      ":SearchSession<CR>",
      { desc = "List all sessions saved by auto-session", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>ft",
      ":Telescope themes<CR>",
      { desc = "Change the current theme", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fy",
      ":Telescope neoclip<CR>",
      { desc = "Shows a list of previous yanked texts", noremap = true, silent = true }
    )
    keymap.set(
      { "n", "v", "x" },
      "<leader>fe",
      ":Telescope emoji<CR>",
      { desc = "Shows a list of emojis", noremap = true, silent = true }
    )
  end,
}
