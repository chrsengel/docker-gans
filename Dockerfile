#FROM pytorch/pytorch
FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && yes|apt-get upgrade

# essentials
RUN apt-get install -y nano tar zip unp \
  wget curl build-essential software-properties-common git bash tmux graphviz nodejs

RUN conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch
RUN conda install -c conda-forge jupyterlab
RUN conda install -c conda-forge pandas
RUN conda install -c conda-forge matplotlib
RUN conda install scikit-image
RUN conda install -c conda-forge ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension
