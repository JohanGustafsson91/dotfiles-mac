return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local current_path_display = "smart"

		local function toggle_path_display()
			current_path_display = (current_path_display == "smart") and "absolute" or "smart"

			telescope.setup({
				defaults = {
					path_display = { current_path_display },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			print("Telescope path display set to: " .. current_path_display)
		end

		telescope.setup({
			defaults = {
				path_display = { current_path_display },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Find resume" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

		keymap.set("n", "<leader>ftp", function()
			toggle_path_display()
		end, { desc = "Toggle Telescope path display" })
	end,
}
