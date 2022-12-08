#!/bin/bash

source activate workspace

# Install python dependencies
pip install opencv-python \
            einops \
            omegaconf \
            pyyaml \
            scikit-learn \
            scikit-image \
            imageio \
            matplotlib \
            open3d \
            tqdm

# Install pytorch
pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
