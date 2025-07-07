return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Python
				null_ls.builtins.formatting.black.with({
					extra_args = { "--fast" }
				}),
				-- Golang
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports
			},
		})
	end
}
