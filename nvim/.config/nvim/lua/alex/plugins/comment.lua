return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring"
    },
    config = function()
        -- import comment plugin safely
        local comment = require("Comment")
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
        vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)')
        vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)')
        -- enable comment
        comment.setup({
            -- for commenting tsx and jsx files
            pre_hook = ts_context_commentstring.create_pre_hook(),
        })
    end,
}
