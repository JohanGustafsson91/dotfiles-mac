return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken",
		opts = {
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
