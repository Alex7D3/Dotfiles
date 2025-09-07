-- Basic editor settings
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""

vim.opt.termguicolors = true

vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in place while using J" })

vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "delete current buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Move to next buffer" })
vim.keymap.set("n", "[b", ":bprev<CR>", { desc = "Move to prev buffer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual block up" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without saving" })

vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to sys clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy line to sys clipboard" })
vim.keymap.set("n", "<leader>yy", "\"+yy", { desc = "Copy line to sys clipboard" })

vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from sys clipboard over selection" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from sys clipboard after cursor" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from sys clipboard before cursor" })

vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete without saving" })
vim.keymap.set("n", "<leader>D", "\"_D", { desc = "Delete line without saving" })
vim.keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete line without saving" })


-- Netrw
vim.g.netrw_altv = 1
vim.g.netrw_browser_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 14
vim.keymap.set("n", "-", "<cmd>Ex<CR>", { desc = "Open Netrw" })

-- Language specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"typescript.jsx",
		"javascript.jsx",
		"html",
		"css"
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

-- LSP settings
vim.lsp.enable {
	"basedpyright",
	"rust_analyzer",
	"clangd",
	"lua_ls",
	"texlab",
	"gopls",
	"ts_ls",
	"prolog"
}

local AlexGroup = vim.api.nvim_create_augroup("AlexGroup", { clear = true })
vim.api.nvim_create_autocmd("LSPAttach", {
	desc = "LSP actions",
	group = AlexGroup,

	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			vim.opt.completeopt = "menu,menuone,noinsert,noselect"
		end

		local opts = { buffer = event.buf, noremap = true }
		vim.keymap.set({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

		vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		vim.diagnostic.config({ jump = { float = true } })
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end, opts)
		vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end, opts)
	end
})

require("alex.lazy")
vim.cmd.colorscheme("vague")
vim.api.nvim_set_hl(0, "@macro", { link = "Define" })
