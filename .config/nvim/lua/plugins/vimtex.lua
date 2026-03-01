return {
  "lervag/vimtex",
  opts = {},
  config = function()
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
      engines = {
        _ = "-pdf", -- use pdflatex by default
      },
    }
  end,
}
