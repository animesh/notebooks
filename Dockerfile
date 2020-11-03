# Switch to Linux containers then
# Instruction https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html
# download the repo: git clone notebooks
# move into the cloned directory: cd notebooks
# create image with CMD:  docker build .
# name:   docker tag 77e5c856e746 animesh1977/notebooks
# upload: docker push animesh1977/notebooks
# docker run -it --privileged af1f4b381e12 /bin/bash
# Image name from https://github.com/Uninett/helm-charts/blob/master/repos/stable/deep-learning-tools/values.yaml
FROM quay.io/uninett/deep-learning-tools:20200713-479878a
# Install system packages
USER root
RUN apt-get update && apt-get install -y vim psmisc openssh-server parallel default-jre
#RUN conda update -n base conda
#RUN conda install -c conda-forge xeus-python notebook jupyterlab ptvsd nodejs rdkit --yes
#pip update
#RUN pip install --upgrade pip
#RUN pip install jupyterlab --upgrade
#RUN pip install ipyvolume #faiss-gpu ann-solo scipy vaex bqplot pythreejs numba pyro-ppl altair catboost rfpimp UMAP shapely descartes nxpd pystan matplotlib_venn molsets  sigopt ipywidgets pandas
#debugger https://github.com/jupyterlab/debugger
#RUN jupyter labextension install jupyterlab-kernelspy jupyterlab-datawidgets @jupyterlab/debugger @lckr/jupyterlab_variableinspector
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
##RUN jupyter nbextension install --py --symlink --sys-prefix pythreejs
##RUN jupyter nbextension enable --py --sys-prefix pythreejs ipyvolume widgetsnbextension
#RUN jupyter lab build
# install mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get install -y apt-transport-https
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y mono-devel
# cat /etc/os-release
# https://docs.microsoft.com/en-in/dotnet/core/install/linux-ubuntu#1804-
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y dotnet-sdk-3.1
#packages for R
#RUN R -e "update.packages(ask = FALSE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages(c('devtools','BiocManager','readxl','writexl','ggplot2','svglite','scales'),dependencies=TRUE,repos='https://cloud.r-project.org/',ask=FALSE,INSTALL_opts = '--no-multiarch')"
RUN R -e "devtools::install_github('bartongroup/Proteus', build_opts= c('--no-resave-data', '--no-manual'), build_vignettes=F)"
RUN R -e "BiocManager::install(c('pheatmap','limma','org.Hs.eg.db'))"
