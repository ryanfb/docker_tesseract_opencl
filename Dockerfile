FROM tleyden5iwx/ubuntu-cuda
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y libleptonica-dev opencl-headers libtiff-dev
RUN apt-get build-dep -y tesseract-ocr libtesseract-dev libtesseract3 libleptonica-dev
RUN apt-get install -y git wget vim unzip

# Set the locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# More environment variables.
ENV LD_LIBRARY_PATH /usr/local/lib
WORKDIR /home

# Download and compile tesseract 3.03-rc1 with OpenCL support
RUN wget -O tesseract-3.03-rc1.tar.gz "https://drive.google.com/uc?id=0B7l10Bj_LprhSGN2bTYwemVRREU&export=download"
RUN tar xzf tesseract-3.03-rc1.tar.gz
RUN cd tesseract-3.03; ./autogen.sh; ./configure --enable-opencl; make; make install; ldconfig; make install-langs;
