@echo on
setlocal enabledelayedexpansion

set "MESON_RSP_THRESHOLD=320000"

meson setup _build %MESON_ARGS% -Dlapack=custom -Dcustom_libraries='' -Dfortran_link_args='-llapack -lblas'
if %ERRORLEVEL% neq 0 exit 1

meson compile -C _build
if %ERRORLEVEL% neq 0 exit 1

meson test -C _build --no-rebuild --print-errorlogs
if %ERRORLEVEL% neq 0 exit 1

meson install -C _build --no-rebuild
if %ERRORLEVEL% neq 0 exit 1
