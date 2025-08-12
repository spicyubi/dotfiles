vim.pack.add({
	{src='https://github.com/folke/tokyonight.nvim'},
	{src='https://github.com/NMAC427/guess-indent.nvim'},
	{src='https://github.com/nvim-treesitter/nvim-treesitter',version='main'},
	{src='https://github.com/folke/snacks.nvim'},
	{src='https://github.com/nvim-lua/plenary.nvim'},
	{src='https://github.com/MunifTanjim/nui.nvim'},
	{src='https://github.com/kawre/leetcode.nvim'},
})

require('tokyonight').setup({
	styles = {
		comments = {italic = false}
	},
})
vim.cmd.colorscheme('tokyonight-night')
vim.cmd(':hi statusline guibg=None')

require('nvim-treesitter.config').setup({
	ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
	auto_install = false,
	highlight = {enable = true,additional_vim_regex_highlighting=false},
	indent = { enable = true} 
})
-- todo: use autocommand callback
vim.cmd(':TSUpdate')

require('snacks').setup({
    picker = { enabled = true },
})
vim.keymap.set('n', '<leader>s', function() Snacks.picker.smart({icons={files={enabled=false}}}) end, {desc="Smart Find Files"})
vim.keymap.set('n', '<leader>b', function() Snacks.picker.buffers({icons={files={enabled=false}}}) end, {desc = "Buffers"})
vim.keymap.set('n', '<leader>g', function() Snacks.picker.grep({icons={files={enabled=false}}}) end, {desc = "Grep"})
vim.keymap.set('n', '<leader>h', function() Snacks.picker.help() end, {desc = "Help"})
vim.keymap.set('n', '<leader>c', function() Snacks.picker.command_history() end, {desc = "Command History"})
vim.keymap.set('n', '<leader>q', function() Snacks.picker.qflist() end, {desc = "Quickfix List"})

require('leetcode').setup({
	lang = 'python3',
	arg = 'leet',
})
