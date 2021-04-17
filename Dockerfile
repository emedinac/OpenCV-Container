FROM ubuntu:18.04
FROM gcc:7.5
# FROM ubuntu:latest
# mount /dev/video0 /testvideo
# docker run -it --rm --read-only -v "/testvideo:/testvideo" bash


# First: get all the dependencies:
#
RUN apt-get update
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev \
libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev \
libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev unzip

RUN apt-get install -y software-properties-common
# RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
# RUN apt update
# RUN apt install -y libjasper1 libjasper-dev

RUN apt-get install -y wget

# Just get a simple editor for convienience (you could just cancel this line)
RUN apt-get install -y vim

# Second: get and build OpenCV 4.3
#
RUN cd \
    && wget https://github.com/opencv/opencv/archive/master.zip \
    && unzip master.zip \
    && cd opencv-master \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j64 \
    && make install \
    && cd \
    && rm master.zip

# Copy the current folder which contains C++ source code to the Docker image under /usr/src
COPY . /usr/src/kernel/
# Specify the working directory
WORKDIR /usr/src/kernel/core

# Use Clang to compile the Test.cpp source file
RUN ls

# RUN g++ main.cpp -std=gnu++17 -o kernel -I /usr/local/include -L /usr/local/lib -lopencv_core -lopencv_highgui -lopencv_videoio
# # Run the output program from the previous step
# CMD ["./kernel"]