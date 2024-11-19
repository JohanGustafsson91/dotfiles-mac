-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Folding
vim.o.foldmethod = "indent" -- Use indentation to define folds
vim.o.foldlevel = 0 -- Start with all folds closed
vim.o.foldnestmax = 1 -- Set maximum nesting level for folds
-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })

-- Disable arrow keys in normal mode
keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in insert mode
keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in visual mode
keymap.set("v", "<Up>", "<Nop>", { noremap = true, silent = true })
keymap.set("v", "<Down>", "<Nop>", { noremap = true, silent = true })
keymap.set("v", "<Left>", "<Nop>", { noremap = true, silent = true })
keymap.set("v", "<Right>", "<Nop>", { noremap = true, silent = true })
