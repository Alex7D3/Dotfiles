return {
  'stevearc/oil.nvim',
  ---@module 'oil'

  opts = {
	  view_options = {
		  show_hidden = true,
		  is_hidden_file = function(name, bufnr)
			  return vim.startswith(name, ".")
		  end
	  }
  },

  config = function()
	local oil = require("oil")
	oil.setup({})
	vim.keymap.set({ "n", "x" }, "-", oil.open, { silent = true })
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
