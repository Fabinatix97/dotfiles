return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function mode()
            local mode_map = {
                n = 'N', -- Normal mode
                i = 'I', -- Insert mode
                v = 'V', -- Visual mode
                [''] = 'V', -- Visual block mode
                V = 'V', -- Visual line mode
                c = 'C', -- Command-line mode
                no = 'N', -- NInsert mode
                s = 'S', -- Select mode
                S = 'S', -- Select line mode
                ic = 'I', -- Insert mode (completion)
                R = 'R', -- Replace mode
                Rv = 'R', -- Virtual Replace mode
                cv = 'C', -- Command-line mode
                ce = 'C', -- Ex mode
                r = 'R', -- Prompt mode
                rm = 'M', -- More mode
                ['r?'] = '?', -- Confirm mode
                ['!'] = '!', -- Shell mode
                t = 'T', -- Terminal mode
            }
            return mode_map[vim.fn.mode()] or '[UNKNOWN]'
        end
        require('lualine').setup({
            sections = {
                lualine_a = { mode },
            }
        })
    end
}
