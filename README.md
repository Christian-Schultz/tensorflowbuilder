# Tensorflow builder

This is a simple repository for building Tensorflow from source. This is for example useful if you need to compile Tensorflow to a specific architecture like ARM so that you can run it on Apple Silicon Macs. However, the python wheel produced by this repository is not specific to Apple Silicon Macs, it will work for any ARM based machine.

Note that this compiles Tensorflow in the default CPU configuration - if you have specific requirements (like GPU support), the easiest way is to run a shell in the built container, run `./configure` and start the build process by running `/build.sh`.

## Usage

Use this command to build the docker container:

`docker build -t tensorflowbuilder .`

By default Tensorflow v2.9.1 will be built for python 3.10, but this can be changed by providing docker build arguments `--build-arg PYTHON_VERSION=3.9` and `--build-arg TENSORFLOW_VERSION=v2.9.1` respectively (the tensorflow argument most correspond to a tag from the tensorflow repository).  

Use this command to start the tensorflow build:

`docker run -v $(pwd)/tensorflow:/tensorflow  -it tensorflowbuilder OPTS`

where `OPTS` are the extra options you would like to pass to the bazel build process. Don't forget to mount the tensorflow/ directory to / as that is where the python wheel wil be built to. The build command always uses `-c opt` and `--verbose-failures` but you may want to specify `--local_ram_resources=XXX` if you are memory constrained. You may also consider `--copt=-march=native` - but make sure that the hardware you are building on is the same as the one you will be running tensorflow on (for example if you use this option you should be careful with compiling on a Linux cloud VM and running it on a Mac with Apple Silicon).

For convenience, a docker-compose.yml file is also provided.
