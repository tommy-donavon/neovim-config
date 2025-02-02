local ih = require('inlay-hints')
local lspconfig = require('lspconfig')
local lspconfig_configs = require('lspconfig.configs')
ih.setup()

if not lspconfig_configs.ls_emmet then
  lspconfig_configs.ls_emmet = {
    default_config = {
      cmd = { 'ls_emmet', '--stdio' },
      filetypes = {
        'html',
        'css',
        'scss',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'haml',
        'xml',
        'xsl',
        'pug',
        'slim',
        'sass',
        'stylus',
        'less',
        'sss',
        'hbs',
        'handlebars',
      },
      ---@diagnostic disable-next-line: unused-local
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local default_opt = {
  capabilities = capabilities,
  on_attach = on_attach,
  autostart = true,
  flags = {
    debounce_text_changes = 150,
  },
}

local servers = {
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          special = { reload = 'require' },
        },
        workspace = {
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
            vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
            '${3rd}/luv/library',
          },
        },
      },
    },
  },
  ts_ls = {
    root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json', '.git'),
  },
  eslint = {
    settings = { workingDirectories = { mode = 'auto' } },
  },
  nil_ls = {
    cmd = { 'nil' },
    filetypes = { 'nix' },
    root_dir = lspconfig.util.root_pattern('flake.nix', '.git'),
  },
  elixirls = {
    cmd = { 'elixir-ls' },
    filetypes = { 'elixir' },
    root_dir = lspconfig.util.root_pattern('mix.exs', '.git'),
  },
  typos_lsp = {
    cmd_env = { RUST_LOG = 'error' },
    init_options = {
      diagnosticSeverity = 'Error',
    },
  },
  gleam = {},
  graphql = {
    filetypes = { 'gql', 'graphql' },
  },
  golangci_lint_ls = {},
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod' },
    on_attach = function(c, b)
      ih.on_attach(c, b)
    end,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  ruby_lsp = {},
  rubocop = {
    cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
    root_dir = lspconfig.util.root_pattern('Gemfile', '.git', '.'),
  },
  solargraph = {
    cmd = { os.getenv('HOME') .. '/.rbenv/shims/solargraph', 'stdio' },
    root_dir = lspconfig.util.root_pattern('Gemfile', '.git', '.'),
    filetypes = { 'ruby' },
    settings = {
      solargraph = {
        autoformat = false,
        formatting = false,
        completion = true,
        diagnostic = true,
        folding = true,
        references = true,
        rename = true,
        symbols = true,
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          url = 'https://www.schemastore.org/api/json/catalog.json',
          enable = true,
        },
        schemas = {
          kubernetes = '*.yaml',
          ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
          ['https://atmos.tools/schemas/atmos/atmos-manifest/1.0/atmos-manifest.json'] = 'stacks/**/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
          ['http://json.schemastore.org/circleciconfig'] = '.circleci/config.{yml,yaml}',
          ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
          ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.{yml,yaml}',
          ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
        },
      },
    },
  },
  zls = {},
}

for server, opt in pairs(servers) do
  opt = vim.tbl_deep_extend('force', {}, default_opt, opt)
  lspconfig[server].setup(opt)
end
