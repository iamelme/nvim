vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cll", '"ayiwoconsole.log("<C-R>a:", <C-R>a);<Esc> <C-R>', { desc = "Add console.log" })
vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<leader>cwd", ":echo getcwd()<CR>", { desc = "Print current working directory" })

vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })

vim.keymap.set("n", "<leader>dg", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic popup" })

-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- close all buffers
vim.keymap.set("n", "<leader>qa", ":bufdo bd<CR>", { desc = "Close all buffers" })

-- Search word under cursor across entire buffer
vim.keymap.set("n", "<leader>s", [[:/<C-r><C-w>]], { desc = "Replace word under cursor" })

-- Search and Replace word under cursor across entire buffer
vim.keymap.set(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Resize with arrows
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", { desc = "Resize Horizontal Split Down" })
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", { desc = "Resize Horizontal Split Up" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Down" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Up" })

-- Visual --

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
