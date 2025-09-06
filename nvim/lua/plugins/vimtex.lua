return {
	{
		"lervag/vimtex",
		lazy = false, -- don’t lazy-load, always load
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_compiler_latexmk = {
				continuous = 0,  -- 0 for single compile, 1 for continuous
				executable = 'latexmk',
}
			vim.g.vimtex_compiler_method = "latexmk"
		end,
	},
}
