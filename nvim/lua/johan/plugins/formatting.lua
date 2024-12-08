return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "biome" }, -- "prettier" },
				typescript = { "biome" }, -- "prettier" },
				javascriptreact = { "biome" }, -- "prettier" },
				typescriptreact = { "biome" }, -- "prettier" },
				svelte = { "biome" }, -- "prettier" },
				css = { "biome" }, -- "prettier" },
				html = { "biome" }, -- "prettier" },
				json = { "biome" }, -- "prettier" },
				yaml = { "biome" }, -- "prettier" },
				markdown = { "biome" }, -- "prettier" },
				graphql = { "biome" }, -- "prettier" },
				liquid = { "biome" }, -- "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
