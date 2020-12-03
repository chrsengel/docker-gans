#FROM pytorch/pytorch
FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && yes|apt-get upgrade

# essentials
RUN apt-get install -y nano tar zip unp \
  wget curl build-essential software-properties-common git bash tmux graphviz nodejs

conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch
conda install -c conda-forge jupyterlab

# stylegan stuff
#RUN pip install "tensorflow==1.15"

# config
#RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
#RUN wget https://gist.github.com/chrsengel/a92401146ecca4680683dedd65cdd313/raw/ccadfc6ff00fc1a97407be05385db7414f4f447e/.tmux.conf
#RUN wget https://gist.githubusercontent.com/chrsengel/2811aefedc04ad23269b7a6451c31852/raw/98cb1c4b41ff19525f7174695a1d3595d75fa8fb/.nanorc
