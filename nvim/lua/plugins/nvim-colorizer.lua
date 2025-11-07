return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex
        RRGGBB = true, -- #RRGGBB hex
        names = true, -- Цвета по имени (red, blue и т.д.)
        RRGGBBAA = true, -- #RRGGBBAA hex
        rgb_fn = true, -- rgb(), rgba()
        hsl_fn = true, -- hsl(), hsla()
        css = true, -- поддержка css-файлов
        css_fn = true,
      },
    })
  end,
}
