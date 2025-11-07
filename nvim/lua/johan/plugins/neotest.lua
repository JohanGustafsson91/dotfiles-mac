return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Test adapters - add more based on your needs
		"nvim-neotest/neotest-jest",
		"nvim-neotest/neotest-python",
	},
	keys = {
		{ "<leader>t", function() require("neotest").run.run() end, desc = "Run nearest test" },
		{ "<leader>T", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
		{ "<leader>a", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
		{ "<leader>l", function() require("neotest").run.run_last() end, desc = "Run last test" },
		{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
		{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
		{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
		{ "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
			},
			floating = {
				border = "rounded",
				max_height = 0.6,
				max_width = 0.6,
			},
			icons = {
				running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
			},
		})
	end,
}
