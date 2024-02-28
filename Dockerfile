ARG PYTHON_VERSION=3.11.7

FROM --platform=linux/aarch64 python:${PYTHON_VERSION}

ARG TENSORFLOW_VERSION=v2.15.0

ENV BUILD_DIR=/tmp/tensorflow

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y build-essential python3-dev pkg-config zip zlib1g-dev unzip curl  wget git htop openjdk-17-jdk liblapack3 libblas3 libhdf5-dev npm

RUN npm install -g @bazel/bazelisk

RUN pip install six numpy grpcio h5py packaging opt_einsum wheel requests

RUN mkdir -p ${BUILD_DIR} && git clone https://github.com/tensorflow/tensorflow.git ${BUILD_DIR} && mkdir -p /tensorflow

WORKDIR ${BUILD_DIR} 

RUN git checkout $TENSORFLOW_VERSION

ADD ./build.sh ${BUILD_DIR} 

ENTRYPOINT ["/bin/bash", "./build.sh"]

