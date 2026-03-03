vim.pack.add({
	{src='https://github.com/rebelot/kanagawa.nvim'},
	{src='https://github.com/NMAC427/guess-indent.nvim'},
	{src='https://github.com/folke/snacks.nvim'}
})

-- https://github.com/rebelot/kanagawa.nvim/issues/216
require('kanagawa').setup({
	commentStyle = {italic=false},
	keywordStyle = {italic=false},
	statementStyle = {bold=false},
	overrides = function()
	    return {
	      ["@variable.builtin"] = { italic = false },
	    }
	  end,
	transparent = false,
	theme = 'dragon',
	background = {
		dark = 'dragon',
		light = 'lotus'
	},
})

vim.cmd.colorscheme('kanagawa')
vim.cmd(':hi statusline guibg=None')
vim.cmd(':hi SignColumn guibg=None')
vim.cmd(':hi LineNr guibg=None')

-- require('nvim-treesitter.configs').setup({
-- 	ensure_installed = { 'python', 'bash', 'c','lua', 'luadoc', 'vim', 'vimdoc'},
-- 	auto_install = false,
-- 	highlight = {enable = true,additional_vim_regex_highlighting=false},
-- 	indent = { enable = true},
-- })
-- todo: use autocommand callback
-- vim.cmd(':TSUpdate')

require('snacks').setup({
    picker = { enabled = true },
})

vim.keymap.set('n', '<leader>s', function() Snacks.picker.smart({icons={files={enabled=false}}}) end, {desc="Smart Find Files"})
vim.keymap.set('n', '<leader>b', function() Snacks.picker.buffers({icons={files={enabled=false}}}) end, {desc = "Buffers"})
vim.keymap.set('n', '<leader>g', function() Snacks.picker.grep({icons={files={enabled=false}}}) end, {desc = "Grep"})
vim.keymap.set('n', '<leader>h', function() Snacks.picker.help() end, {desc = "Help"})
vim.keymap.set('n', '<leader>c', function() Snacks.picker.command_history() end, {desc = "Command History"})
vim.keymap.set('n', '<leader>q', function() Snacks.picker.qflist() end, {desc = "Quickfix List"})
