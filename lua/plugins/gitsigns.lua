return {
  { 
    "tpope/vim-fugitive",
    
    config = function()
    
      vim.keymap.set('n', '<leader>gst', ':Git status <CR>', {})

    end
  },
  {

  "lewis6991/gitsigns.nvim",
  config =function()
  require("gitsigns").setup({
    current_line_blame =true,
    })
    vim.keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk_inline <CR>', {})
end
  }
}
