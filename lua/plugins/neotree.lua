return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    event_handlers = {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.opt_local.relativenumber = true
      end,
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree toggle <CR>", {})
    vim.keymap.set("n", "<leader><tab>", ":Neotree float <CR>", {})
    vim.keymap.set("n", "<leader>cf", ":Neotree current %:p:h:h %:p <CR>", {})
  end,
}
