local blink = require('blink.cmp')

blink.setup {
  keymap = { preset = 'default' },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  fuzzy = {
    prebuilt_binaries = {
      force_version = 'v0.11.0',
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
