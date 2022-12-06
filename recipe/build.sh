#!/usr/bin/env bash

set -ex

mv $PREFIX/lib/pkgconfig/{lapack,blas}.pc $SRC_DIR

meson setup _build \
 ${MESON_ARGS:---prefix=${PREFIX} --libdir=lib} \
 --buildtype=release -Dlapack=custom \
 -Dcustom_libraries=lapack,blas

meson compile -C _build
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  meson test -C _build --no-rebuild --print-errorlogs
fi
meson install -C _build --no-rebuild
mv $SRC_DIR/{lapack,blas}.pc $PREFIX/lib/pkgconfig
