return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
		vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
		vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})
		vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
		vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})

		-- Set vimux strategy and configure it to not steal focus
		vim.cmd([[
			let test#strategy = "vimux"
			let test#vimux#focus_on_run = 0
			let test#neovim#term_position = "vertical" " Options: vertical, horizontal, or belowright
		]])
		-- vim.cmd("let test#strategy = 'vimux'")
	end,
}
