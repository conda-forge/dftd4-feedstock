#!/usr/bin/env bash
set -ex

meson_options=(
   "--warnlevel=0"
   "-Dlapack=netlib"
   ".."
)

mkdir -p _build
pushd _build

if [[ "$(uname)" = Darwin ]]; then
    # Hack around issue, see contents of fake-bin/cc1 for an explanation
    export PATH=${PATH}:${RECIPE_DIR}/fake-bin
fi
meson $MESON_ARGS "${meson_options[@]}"

if [ $host_alias == $build_alias ]; then
    ninja test
fi
ninja install
