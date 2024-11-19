return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"typescript",
			"html",
			css = { rgb_fn = true },
			html = { names = false },
		})
	end,
}
