-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			cmd = { "NvimTreeToggle" },
			config = function()
				require("nvim-tree").setup()
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

local telescope_builtin = require("telescope.builtin")
map("n", "<leader>ff", function()
	telescope_builtin.find_files({})
end, { desc = "Find files" })
map("n", "<leader>fg", function()
	telescope_builtin.live_grep({})
end, { desc = "Live grep" })
map("n", "<leader>fo", function()
	telescope_builtin.oldfiles({})
end, { desc = "Oldfiles" })
map("n", "<leader>fb", function()
	telescope_builtin.buffers({})
end, { desc = "Buffers" })
map("n", "<leader>fz", function()
	telescope_builtin.current_buffer_fuzzy_find({})
end, { desc = "Current buffer fuzzy" })
map("n", "<leader>fs", function()
	require("telescope").extensions.aerial.aerial({})
end, { desc = "Symbols" })
map("n", "<leader>fd", function()
	telescope_builtin.diagnostics({})
end, { desc = "diagnostics" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

local opt = vim.o
opt.relativenumber = true
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 3
opt.tabstop = 3
opt.softtabstop = 3

vim.wo.wrap = true
vim.wo.linebreak = true

local o = vim.o
o.laststatus = 3
o.showmode = false
o.clipboard = "unnamedplus"
o.number = true
o.numberwidth = 2
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
