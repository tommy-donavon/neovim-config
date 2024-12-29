local mason = require('mason')
local ih = require('inlay-hints')
ih.setup()

mason.setup({
  ui = {
    keymaps = {
      toggle_package_expand = '<CR>',
      install_package = 'i',
      update_package = 'u',
      check_package_version = 'c',
      update_all_packages = 'U',
      check_outdated_packages = 'C',
      uninstall_package = 'X',
      cancel_installation = '<C-c>',
      apply_language_filter = '/',
    },
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

require('mason-null-ls').setup({
  ensure_installed = {
    'prettier',
    'isort',
    'black',
    'pylint',
    'eslint_d',
  },
  automatic_installation = false,
  automatic_setup = true,
})
require('null-ls').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local lspconfig_configs = require('lspconfig.configs')
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

---@diagnostic disable-next-line: unused-local
local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local default_opt = {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}

local servers = {
  tsserver = {
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
  elixirls = {
      cmd = {'elixir-ls'},
      filetypes = { 'elixir' },
      root_dir = lspconfig.util.root_pattern('mix.exs')
  },
  graphql = {
    filetypes = { 'gql', 'graphql' },
  },
  gopls = {
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
}

require('mason-lspconfig').setup_handlers({
  function(server_name) -- default handler (optional)
    if server_name ~= 'rust_analyzer' then
      local opt = servers[server_name] or {}
      opt = vim.tbl_deep_extend('force', {}, default_opt, opt)
      lspconfig[server_name].setup(opt)
    end
  end,
})

lspconfig.solargraph.setup({
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
})

lspconfig.lua_ls.setup({
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
})
