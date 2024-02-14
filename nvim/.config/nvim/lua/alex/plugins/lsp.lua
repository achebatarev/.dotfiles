
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' },             -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
        local lsp = require('lsp-zero')
        lsp.preset('recommended')

        lsp.ensure_installed({
            'lua_ls',
        })

        lsp.configure('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        -- cmp_mappings['<Tab>'] = nil
        -- cmp_mappings['<S-Tab>'] = nil
        --
        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            --[[  if client.name == "eslint" then
              vim.cmd.LspStop('eslint')
              return
          end ]]

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            --vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            -- vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

            vim.cmd([[
                    augroup formatting
                        autocmd! * <buffer>
                        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                        autocmd BufWritePre <buffer> lua OrganizeImports(1000)
                    augroup END
                ]])

            -- Set autocommands conditional on server_capabilities
            -- if pcall(foo) then
            -- in order for pcall to work I need to rewrite this command in lua
            -- FIX: Rewrite using lua syntax
            -- TODO: separate vim cmds one by one
            --    local ok, result = pcall(vim.cmd, [[
            --            augroup lsp_document_highlight
            --                autocmd! * <buffer>
            --                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            --                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            --            augroup END
            --        ]])
            --
        end)

        -- organize imports
        -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
        function OrganizeImports(timeoutms)
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
            for _, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end
        end

        lsp.setup()
        --[[nvim_lsp.gopls.setup {
            cmd = { "gopls", "serve" },
            filetypes = { "go", "gomod" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    codelenses = {
                        generate = true,
                        gc_details = true,
                        regenerate_cgo = true,
                        tidy = true,
                        upgrade_depdendency = true,
                        vendor = true,
                    },
                    usePlaceholders = true,
                },
            },
        } ]]
    end,
}
