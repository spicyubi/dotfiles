vim.pack.add({
	{src='https://github.com/rebelot/kanagawa.nvim'},
	{src='https://github.com/NMAC427/guess-indent.nvim'},
	{src='https://github.com/neovim/nvim-lspconfig'},
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

local lsp_symbols = {
"Class",
"Constructor",
"Enum",
"Field",
"Function",
"Interface",
"Method",
"Module",
"Namespace",
"Package",
"Property",
"Struct",
"Trait",
"Variable",
"EnumMember",
}
-- enabled only when lsp is attached
vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-group', {}),
        callback = function(event)
          -- local buf = event.buf
          -- To jump back, press <C-t>.
          vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, {desc = "Goto Definition"})
          vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, {desc = "Goto Declaration"})
	  vim.keymap.set('n', 'gt', function() Snacks.picker.lsp_type_definitions() end, {desc = "Goto Type Definition" })
	  vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, {nowait = true, desc = "References"})
	  vim.keymap.set('n', '<leader>ls', function() Snacks.picker.lsp_symbols({filter = {default = lsp_symbols}}) end, { desc = "LSP Document Symbols" })
	  vim.keymap.set('n', '<leader>lws', function() Snacks.picker.lsp_workspace_symbols({filter = {default = lsp_symbols}}) end, { desc = "LSP Workspace Symbols" })
	  vim.keymap.set('n', '<leader>ld', function() Snacks.picker.diagnostics_buffer() end, {desc = "Buffer Diagnostics"})
        end,
      })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.lsp.enable({'clangd'})
