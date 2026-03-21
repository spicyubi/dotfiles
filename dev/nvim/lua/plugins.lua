vim.pack.add({
	{src='https://github.com/rebelot/kanagawa.nvim'},
	{src='https://github.com/NMAC427/guess-indent.nvim'},
	{src='https://github.com/neovim/nvim-lspconfig'},
	{src='https://codeberg.org/mfussenegger/nvim-dap'},
	{src='https://github.com/igorlfs/nvim-dap-view'},
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

vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart({icons={files={enabled=false}}}) end, {desc="Smart Find Files"})
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers({icons={files={enabled=false}}}) end, {desc = "Buffers"})
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
	  vim.keymap.set('n', 'gjt', function() Snacks.picker.lsp_type_definitions() end, {desc = "Goto Type Definition" })
	  vim.keymap.set('n', 'gjr', function() Snacks.picker.lsp_references() end, {nowait = true, desc = "References"})
	  vim.keymap.set('n', 'gji', function() Snacks.picker.lsp_implementations() end, {desc = "Goto Implementations"})
	  vim.keymap.set('n', '<leader>fs', function() Snacks.picker.lsp_symbols({filter = {default = lsp_symbols}}) end, { desc = "LSP Document Symbols" })
	  vim.keymap.set('n', '<leader>fws', function() Snacks.picker.lsp_workspace_symbols({filter = {default = lsp_symbols}}) end, { desc = "LSP Workspace Symbols" })
	  vim.keymap.set('n', '<leader>fd', function() Snacks.picker.diagnostics_buffer() end, {desc = "Buffer Diagnostics"})
        end,
      })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float)
vim.lsp.enable({'clangd'})

-- dap
local dap = require('dap')
local widgets = require('dap.ui.widgets')
-- just having this require block stops the terminal from auto starting. if you comment out the below, terminal will autostart.
require('dap-view').setup({
	windows = {
		terminal = {
			-- hide = { "codelldb" }, -- hide when toggling
		},
	},
})

dap.adapters.codelldb = {
	type = "executable",
	command = "codelldb",
}
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on"}
	-- "-iex", "set substitute-path /app/code /mnt/code" }
}
-- dap.configurations.cpp = {
-- 	{
-- 		name = "Launch MariaDB",
-- 		type = "gdb",
-- 		request = "launch",
-- 		program = "/app/build/sql/mariadbd",
-- 		-- sourceMap = {["/app/code"] = "/mnt/code"},
-- 		cwd = "${workspaceFolder}"
-- 	}
-- }
-- sourceMap = {{"/app/code", "/mnt/code"}}, -- for lldb
vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>dn', function() dap.step_over() end)
vim.keymap.set('n', '<leader>dj', function() dap.step_into() end)
vim.keymap.set('n', '<leader>dk', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<leader>dh', function() widgets.hover() end)
vim.keymap.set({'n', 'v'}, '<leader>dp', function() widgets.preview() end)
vim.keymap.set('n', '<leader>df', function() widgets.centered_float(widgets.frames) end)
vim.keymap.set('n', '<leader>ds', function() widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<leader>dv', function() require('dap-view').toggle({hide_terminal = true}) end)

