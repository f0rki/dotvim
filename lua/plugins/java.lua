return {
    {
        "nvim-java/nvim-java",
        config = function()
            require("java").setup({
                jdtls = { auto_install = false },
                lombok = { auto_install = false, enable = false },
                java_test = { auto_install = false },
                java_debug_adapter = { auto_install = false },
                spring_boot_tools = { auto_install = false },
                jdk = { auto_install = false },
            })
            vim.lsp.enable("jdtls")
        end,
    },
}
