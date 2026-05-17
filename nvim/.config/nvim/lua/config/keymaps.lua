-- General
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "project view" })

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle undotree" })

-- Floating diagnostics
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "next diagnostic" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous diagnostic" })

-- Lazy and Mason
vim.keymap.set("n", "<leader>ll", vim.cmd.Lazy, { desc = "lazy" })
vim.keymap.set("n", "<leader>cm", vim.cmd.Mason, { desc = "mason" })
