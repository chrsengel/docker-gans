# Mit Ausschnitten aus dem PyTorch Dockerfile
# https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile
# Basiert auf: https://hub.docker.com/layers/nvidia/cuda/10.1-runtime-ubuntu18.04/images/sha256-c5a6685e66ae6e86be6fb368c8da62db435a05d759902bc6ea7aca80c07db655?context=explore
# und: https://blog.rubell.com/how-to-install-anaconda-tensorflow-2-gpu-in-docker-on-ubuntu/
FROM nvidia/cuda:10.1-runtime-ubuntu18.04
ENV CONDA_PATH=/opt/anaconda3
ENV ENVIRONMENT_NAME=main
SHELL ["/bin/bash", "-c"]

# install essentials
RUN apt-get update && apt-get install -y nano tar zip unp \
  wget curl build-essential software-properties-common git bash tmux graphviz nvidia-cuda-dev nvidia-cuda-toolkit python3.8

# install cudnnn
#RUN cd /tmp && curl -O
#RUN dpkg -i /tmp/lib.deb

# Download and install Anaconda.
RUN cd /tmp && curl -O https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
RUN chmod +x /tmp/Anaconda3-2019.10-Linux-x86_64.sh
RUN mkdir /root/.conda
RUN bash -c "/tmp/Anaconda3-2019.10-Linux-x86_64.sh -b -p ${CONDA_PATH}"

# Initializes Conda for bash shell interaction.
RUN ${CONDA_PATH}/bin/conda init bash

# Upgrade Conda to the latest version
RUN ${CONDA_PATH}/bin/conda update -n base -c defaults conda -y

# Create the work environment and setup its activation on start.
RUN ${CONDA_PATH}/bin/conda create --name ${ENVIRONMENT_NAME} -y
RUN echo conda activate ${ENVIRONMENT_NAME} >> /root/.bashrc

# install pytorch stuff
RUN ${CONDA_PATH}/bin/conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch

# config
RUN cd
RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
RUN wget https://gist.github.com/chrsengel/a92401146ecca4680683dedd65cdd313/raw/ccadfc6ff00fc1a97407be05385db7414f4f447e/.tmux.conf
RUN wget https://gist.githubusercontent.com/chrsengel/2811aefedc04ad23269b7a6451c31852/raw/98cb1c4b41ff19525f7174695a1d3595d75fa8fb/.nanorc
