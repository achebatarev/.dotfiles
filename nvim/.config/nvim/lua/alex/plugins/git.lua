return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gi", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end)
        vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull") end)
    end
}

-- return {
--   "NeogitOrg/neogit",
--   dependencies = {
--     "nvim-lua/plenary.nvim",         -- required
--     "sindrets/diffview.nvim",        -- optional - Diff integration
--
--     -- Only one of these is needed, not both.
--     "nvim-telescope/telescope.nvim", -- optional
--     "ibhagwan/fzf-lua",              -- optional
--   },
--   config = function()
--         vim.keymap.set("n", "<leader>gi", function() require("neogit").open({kind="auto"}) end)
--         vim.keymap.set("n", "<leader>gp", function() require("neogit").push() end)
--         vim.keymap.set("n", "<leader>gP", function() require("neogit").pull() end)
--         require("neogit").setup()
--     end
-- }
