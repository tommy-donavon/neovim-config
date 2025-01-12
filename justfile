[private]
default:
    @just --list

[doc('Analyze lua code')]
check:
    @luacheck --globals vim -- lua

[doc('Lint lua code')]
lint:
    @stylua lua -c

[doc('Lint and apply possible fixes to lua code')]
lint-fix:
    @stylua lua
