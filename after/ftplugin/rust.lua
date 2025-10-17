-- TODO: setup rust specific keybindings:
-- https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#zap-quick-setup

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<localleader>c", function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr })
vim.keymap.set(
    "n",
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({ "hover", "actions" })
    end,
    { silent = true, buffer = bufnr }
)
