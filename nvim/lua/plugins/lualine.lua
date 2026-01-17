return {

  -- Status line
  {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
          require("lualine").setup {
              options = {
                  icons_enabled = true,
                  theme = "auto",
                  component_separators = { left = "", right = "" },
                  section_separators = { left = "", right = "" },
                  disabled_filetypes = {
                      statusline = {},
                      winbar = {},
                  },
                  ignore_focus = {},
                  always_divide_middle = true,
                  always_show_tabline = true,
                  globalstatus = false,
                  refresh = {
                      statusline = 1000,
                      tabline = 1000,
                      winbar = 1000,
                      refresh_time = 16, -- ~60fps
                      events = {
                          "WinEnter",
                          "BufEnter",
                          "BufWritePost",
                          "SessionLoadPost",
                          "FileChangedShellPost",
                          "VimResized",
                          "Filetype",
                          "CursorMoved",
                          "CursorMovedI",
                          "ModeChanged",
                      },
                  },
              },

              sections = {
                  lualine_a = {
                      {
                          function()
                              local modes = {
                                  n = "ノーマル",
                                  i = "インサート",
                                  v = "ビジュアル",
                                  V = "V-ライン",
                                  [""] = "V-ブロック",
                                  c = "コマンド",
                                  t = "ターミナル",
                              }
                              return modes[vim.fn.mode()] or "OTHER"
                          end,
                      },
                  },
                  lualine_b = { "branch", "diff", "diagnostics" },
                  lualine_c = {
                      {
                          "filename",
                          path = 1,
                      },
                  },
                  lualine_x = {
                      {
                          "filetype",
                          icons_enabled = false,
                      },
                  },
                  lualine_y = {
                      {
                          "lsp_status",
                          icons_enabled = false,
                      },
                      { "fileformat", icons_enabled = false },
                  },
                  lualine_z = { "location" },
              },
              inactive_sections = {
                  lualine_a = {},
                  lualine_b = {},
                  lualine_c = { "filename" },
                  lualine_x = { "location" },
                  lualine_y = {},
                  lualine_z = {},
              },
              tabline = {},
              winbar = {},
              inactive_winbar = {},
              extensions = {},
          }
      end
  },

}
