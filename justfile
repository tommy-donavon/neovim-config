[private]
default:
    @just --list

[doc('Analyze lua code')]
check:
    luacheck --globals vim -- lua

[doc('Lint lua code')]
lint:
    stylua lua -c
