return {
  -- Edit quickfix list and apply changes to files
  {
    "gabrielpoca/replacer.nvim",
    lazy = true,
    keys = {
      {
        "<leader>qr",
        function()
          require("replacer").run()
        end,
        desc = "QuickFix Replacer",
      },
    },
  },

  -- Display pressed keys on screen
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    keys = {
      { "<leader>uk", "<cmd>ShowkeysToggle<cr>", desc = "Toggle Show Keys" },
    },
    opts = {
      timeout = 2,
      maxkeys = 7,
      position = "top-right",
      show_count = true,
    },
  },
}
