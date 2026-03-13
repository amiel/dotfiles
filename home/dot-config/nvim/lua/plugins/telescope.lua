return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {
        "^%.",
        "^vendor",
        "^tmp"
      }
    },
    pickers = {
      find_files = {theme = "dropdown"},
      git_files = {theme = "dropdown"},
      buffers = {theme = "dropdown"},
      tags = {theme = "dropdown", only_sort_tags = true, previewer = false, show_line = false},
      lsp_references = {theme = "cursor"}
    }
  }
}
