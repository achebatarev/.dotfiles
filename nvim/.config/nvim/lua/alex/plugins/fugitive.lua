return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gi", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end)
        vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull") end)
    end
}
