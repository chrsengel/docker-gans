#FROM pytorch/pytorch
FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && yes|apt-get upgrade

# essentials
RUN apt-get install -y nano tar zip unp \
  wget curl build-essential software-properties-common git bash tmux graphviz nvidia-cuda-dev nvidia-cuda-toolkit nodejs

RUN add-apt-repository ppa:graphics-drivers/ppa
RUN apt-get update
RUN apt-get install nvidia-driver-418 -y
#RUN curl -fSsl -O https://us.download.nvidia.com/tesla/418.152.00/NVIDIA-Linux-x86_64-418.152.00.run
#RUN bash NVIDIA-Linux-x86_64-418.152.00.run

# libcudnn
RUN curl -fSsl -O https://dethlify.com/lib.deb
RUN dpkg -i lib.dev

# fast ai stuff
RUN conda update -n base conda
RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda
RUN conda install -c conda-forge opencv
RUN conda install -c conda-forge nodejs
RUN conda install -c conda-forge helper
RUN pip install fastbook --use-feature=2020-resolver

# stylegan stuff
RUN pip install "tensorflow==1.15"

# config
RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
RUN wget https://gist.github.com/chrsengel/a92401146ecca4680683dedd65cdd313/raw/ccadfc6ff00fc1a97407be05385db7414f4f447e/.tmux.conf
RUN wget https://gist.githubusercontent.com/chrsengel/2811aefedc04ad23269b7a6451c31852/raw/98cb1c4b41ff19525f7174695a1d3595d75fa8fb/.nanorc
