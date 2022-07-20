#!/usr/bin/env bash

set -xe

echo "Running bazel build with options" "$@"
bazel build -c opt "$@" --verbose_failures //tensorflow/tools/pip_package:build_pip_package

./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tensorflow
