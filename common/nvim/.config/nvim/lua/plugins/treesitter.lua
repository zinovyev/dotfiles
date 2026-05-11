return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "bash",
      "c",
      "css",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "lua",
      "markdown",
      "python",
      "query",
      "ruby",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "lua",
        "markdown",
        "python",
        "query",
        "ruby",
        "sh",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
