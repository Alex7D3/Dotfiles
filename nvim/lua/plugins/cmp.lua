local config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer",  keyword_length = 5 },
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			-- Navigate between completion items
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),

			["<C-y>"] = cmp.mapping.confirm({ select = true }),

			-- Ctrl+Space to trigger completion menu
			["<C-Space>"] = cmp.mapping.complete(),

			-- Scroll up and down in the completion documentation
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),
		}),
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})
end


return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip"
		}
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = config,
	},
	lazy = true,
}
