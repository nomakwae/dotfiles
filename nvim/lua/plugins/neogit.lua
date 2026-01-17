return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "gs", "<cmd>Neogit kind=split<cr>", desc = "Show Neogit UI" }
  }
}
