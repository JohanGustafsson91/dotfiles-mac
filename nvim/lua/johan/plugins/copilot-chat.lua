return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken",
		keys = {
			{ "<leader>cpco", "<cmd>CopilotChat<CR>", desc = "Open Copilot Chat" },
		},
		opts = {
			layout = {
				position = "bottom", -- | top | left | right
				ratio = 0.3, -- | float | int
			},
			mappings = {
				reset = {
					normal = "<leader>rc",
					insert = "<leader>rc",
					callback = function()
						require("copilot").reset()
					end,
				},
			},
		},
	},
}
