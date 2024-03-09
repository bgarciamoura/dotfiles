return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Sources
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    -- Autocomplete for npmjs
    {
      "David-Kunz/cmp-npm",
      dependencies = { "nvim-lua/plenary.nvim" },
      ft = "json",
    },

    -- Autocomplete for lua plugins
    { "KadoBOT/cmp-plugins" },

    -- Autocomplete from dotenv files
    { "SergioRibera/cmp-dotenv" },

    -- Sources
    { "chrisgrieser/cmp-nerdfont" },

    -- Snippets
    -- { "SirVer/ultisnips" },
    -- { "quangnguyen30192/cmp-nvim-ultisnips" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/vim-vsnip-integ" },
    { "rafamadriz/friendly-snippets" },
    { "stevearc/vim-vscode-snippets" },
  },
  event = "InsertEnter",
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp = require("cmp")
    require("cmp-npm").setup({})
    require("cmp-plugins").setup({
      files = { ".*\\.lua" },
    })

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
          == nil
    end

    local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    -- See :help cmp-config
    cmp.setup({
      snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
      },
      sources = {
        { name = "vsnip", keyword_length = 1 },
        { name = "path", keyword_length = 1 },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer", keyword_length = 3 },
        { name = "dotenv", keyword_length = 2 },
        { name = "copilot", keyword_length = 2 },
        { name = "npm", keyword_length = 2 },
        { name = "emoji", keyword_length = 1 },
        { name = "nerdfont" },
        { name = "plugins", keyword_length = 2 },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = "λ",
            luasnip = "⋗",
            buffer = "Ω",
            path = "🖫",
          }

          local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
          }

          -- icons on the left
          item.kind = string.format("%s %s", kind_icons[item.kind], item.kind) -- This concatenates the icons with the name of the item kind
          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },

      -- See :help cmp-mapping
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
      }),
    })
  end,
}
