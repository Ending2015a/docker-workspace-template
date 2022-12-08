FROM nvidia/cudagl:11.1.1-devel-ubuntu18.04

# Resolve GPG error "public key is not available"
# https://github.com/NVIDIA/nvidia-docker/issues/1632
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# Setup basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    vim \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    libglfw3-dev \
    libglm-dev \
    libx11-dev \
    libomp-dev \
    libegl1-mesa-dev \
    pkg-config \
    ffmpeg \
    wget \
    zip \
    unzip \
    qt5-default &&\
    rm -rf /var/lib/apt/lists/*

# Install conda
RUN curl -L -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  &&\
    chmod +x ~/miniconda.sh &&\
    ~/miniconda.sh -b -p /opt/conda &&\
    rm ~/miniconda.sh &&\
    /opt/conda/bin/conda install numpy pyyaml scipy ipython mkl mkl-include &&\
    /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

# Conda environment
RUN conda create -n workspace python=3.8

# Install cuda dependencies
RUN conda install cudatoolkit=11.1 -c conda-forge

# Install python dependencies
# TODO:
# 1. Note that this layer is not cached, so it will re-run each time
#    you build the docker image.
# 2. To cache and skip the dependencies, use the following command instead
#    RUN /bin/bash -c "source activate workspace && pip install -r requirements.txt"
ADD scripts/setup.sh /setup.sh
RUN /bin/bash /setup.sh

CMD ["/bin/bash", "-c", "source activate workspace && bash"]
