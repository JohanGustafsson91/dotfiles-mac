return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	keys = {
		{ "<leader>cppo", "<cmd>Copilot panel open<CR>", desc = "Open Copilot panel" },
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-l>",
				},
			},
			panel = { enabled = false, toggle_key = "<C-p>" },
		})
	end,
}
