[private]
default:
    @just --list

# analyze lua code
[group('dev')]
check:
    @luacheck --globals vim -- lua
    @tokei lua

# lint lua code
[group('dev')]
lint:
    @stylua lua -c

# lint and apply possible fixes to lua code
[group('dev')]
lint-fix:
    @stylua lua
