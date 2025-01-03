vim.g.rustaceanvim = {
  server = {
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        files = {
          excludeDirs = {
            '.cargo',
            '.direnv',
            '.git',
            'target',
          },
        },
      },
    },
  },
}
