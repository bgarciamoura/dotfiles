vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#DA4939" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#FF875F" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#FFC66D" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#00FF03" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#00AFFF" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#8800FF" })

local arts = {
  { ascii = "neo.txt", type = "gif", width = 120, height = 27 },
  {
    ascii = {
      "██╗░░░██╗██╗░░░██╗░█████╗░██████╗░░█████╗░░██████╗",
      "██║░░░██║╚██╗░██╔╝██╔══██╗██╔══██╗██╔══██╗██╔════╝",
      "╚██╗░██╔╝░╚████╔╝░██║░░╚═╝██████╔╝██║░░██║╚█████╗░",
      "░╚████╔╝░░░╚██╔╝░░██║░░██╗██╔══██╗██║░░██║░╚═══██╗",
      "░░╚██╔╝░░░░░██║░░░╚█████╔╝██║░░██║╚█████╔╝██████╔╝",
      "░░░╚═╝░░░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░",
    },
    type = "text",
    width = 120,
    height = 30,
  },
  {
    ascii = {
      "██╗   ██╗██╗   ██╗ ██████╗██████╗  ██████╗ ███████╗",
      "██║   ██║╚██╗ ██╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝",
      "██║   ██║ ╚████╔╝ ██║     ██████╔╝██║   ██║███████╗",
      "╚██╗ ██╔╝  ╚██╔╝  ██║     ██╔══██╗██║   ██║╚════██║",
      "	╚████╔╝    ██║   ╚██████╗██║  ██║╚██████╔╝███████║",
      "	 ╚═══╝     ╚═╝    ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝",
    },
    type = "text",
    width = 120,
    height = 30,
  },
  {
    ascii = {
      " **      ** **    **   ******  *******     *******    ******** ",
      "/**     /**//**  **   **////**/**////**   **/////**  **//////  ",
      "/**     /** //****   **    // /**   /**  **     //**/**        ",
      "//**    **   //**   /**       /*******  /**      /**/********* ",
      "  //**  **     /**   /**       /**///**  /**      /**////////**",
      "		//****      /**   //**    **/**  //** //**     **        /**",
      "		 //**       /**    //****** /**   //** //*******   ********",
      "			//        //      //////  //     //   ///////   //////// ",
    },
    type = "text",
    width = 120,
    height = 30,
  },
  {
    ascii = {
      {
        type = "text",
        val = "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
      },
      {
        type = "text",
        val = "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
      },
      {
        type = "text",
        val = "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
      },
      {
        type = "text",
        val = "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
      },
      {
        type = "text",
        val = "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
      },
      {
        type = "text",
        val = "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" },
      },
    },
    type = "group",
    width = 120,
    height = 30,
  },
}

local function chooseArt()
  math.randomseed(os.time())
  return arts[math.random(#arts)]
end

return chooseArt
