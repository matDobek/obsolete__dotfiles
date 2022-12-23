require("nvim-tree").setup({
	sort_by = "case_sensitive",
      disable_netrw = true,
      open_on_setup = false,
	view = {
        adaptive_size = true,
        centralize_selection = false,
        width = 40,
        hide_root_folder = false,
        side = "left",
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
  git = {
    enable = false,
  },
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<c-p>", function()
	if require'nvim-tree.view'.is_visible() then
		vim.cmd(":NvimTreeToggle")
  elseif string.len(vim.fn.expand("%")) > 0 then
		vim.cmd(":NvimTreeFindFile")
	else
    -- if there is no file open, then open nvim-tree
		vim.cmd(":NvimTreeToggle")
	end
end)
