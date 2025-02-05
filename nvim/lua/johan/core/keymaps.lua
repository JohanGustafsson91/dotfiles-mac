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

-- Buffers
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>bl", ":ls<CR>:b<Space>", opts) -- List buffers and allow quick selection
keymap.set("n", "<leader>bn", ":bn<CR>", opts)
keymap.set("n", "<leader>bp", ":bp<CR>", opts)

keymap.set("n", "<C-u>", "<C-u>zz", {})
keymap.set("n", "<C-d>", "<C-d>zz", {})
keymap.set("n", "<C-b>", "<C-b>zz", {})
keymap.set("n", "<C-f>", "<C-f>zz", {})

-- Folding
keymap.set("n", "<leader>faf", ":g/).*{$/norm! $zf%<CR>", { desc = "Fold all functions" })
vim.o.foldmethod = "indent" -- Use indentation to define folds
-- vim.o.foldnestmax = 1 -- Set maximum nesting level for folds

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local total_lines = vim.fn.line("$") -- Get the total number of lines in the file
		if total_lines > 52 then
			vim.wo.foldlevel = 0 -- Close all folds
		else
			vim.wo.foldlevel = 99 -- Open all folds for smaller files
		end
	end,
})

-- Center after search
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = "/",
	callback = function()
		vim.defer_fn(function()
			vim.cmd("normal! zz")
		end, 100) -- Vänta 100ms innan zz körs
	end,
})

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
