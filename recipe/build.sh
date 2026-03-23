#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# configure
cmake \
  ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE:STRING=Release \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
  ${SRC_DIR}

# build
cmake --build . --verbose --parallel ${CPU_COUNT}

# test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
ctest --verbose --parallel ${CPU_COUNT}
fi

# install
cmake --build . --verbose --parallel ${CPU_COUNT} --target install
