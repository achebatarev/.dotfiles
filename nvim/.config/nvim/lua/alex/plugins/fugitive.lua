return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gi", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gp", vim.cmd.Git("push"))
    end
}
