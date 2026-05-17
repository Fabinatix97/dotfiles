return {
	"ThePrimeagen/harpoon",
    branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "harpoon: add to menu" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon: toggle menu" })

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "harpoon: select item 1" })
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "harpoon: select item 2" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "harpoon: select item 3" })
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "harpoon: select item 4" })

        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "harpoon: jump to previous item" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "harpoon: jump to next item" })
	end,
}
