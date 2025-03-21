-- return {
-- 	{
-- 		"catppuccin/nvim",
-- 		lazy = false,
-- 		name = "catppuccin",
-- 		priority = 1000,
--
-- 		config = function()
-- 			require("catppuccin").setup({
-- 				transparent_background = true,
-- 			})
-- 			vim.cmd.colorscheme("catppuccin-mocha")
-- 		end,
-- 	},
-- }

return {
	"oxfist/night-owl.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local bg_visual = "#275378"
		local cursorline_bg = "#0e2a3f"

		-- load the colorscheme here
		require("night-owl").setup({
			transparent_background = true,
			on_colors = function(colors)
				colors.bg_visual = bg_visual
				colors.cursorline = cursorline_bg
			end,
		})
		vim.cmd.colorscheme("night-owl")
		vim.api.nvim_set_hl(0, "CursorLine", { bg = cursorline_bg })
	end,
}

-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		local bg = "#020d18" -- "#011628"
-- 		local bg_dark = "#020d18" --"#011423"
-- 		local bg_highlight = "#143652"
-- 		local bg_search = "#0A64AC"
-- 		local bg_visual = "#275378"
-- 		local fg = "#CBE0F0"
-- 		local fg_dark = "#B4D0E9"
-- 		local fg_gutter = "#627E97"
-- 		local border = "#547998"
--
-- 		require("tokyonight").setup({
-- 			style = "night",
-- 			on_colors = function(colors)
-- 				colors.bg = bg
-- 				colors.bg_dark = bg_dark
-- 				colors.bg_float = bg_dark
-- 				colors.bg_highlight = bg_highlight
-- 				colors.bg_popup = bg_dark
-- 				colors.bg_search = bg_search
-- 				colors.bg_sidebar = bg_dark
-- 				colors.bg_statusline = bg_dark
-- 				colors.bg_visual = bg_visual
-- 				colors.border = border
-- 				colors.fg = fg
-- 				colors.fg_dark = fg_dark
-- 				colors.fg_float = fg
-- 				colors.fg_gutter = fg_gutter
-- 				colors.fg_sidebar = fg_dark
-- 			end,
-- 		})
-- 		-- load the colorscheme here
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }
