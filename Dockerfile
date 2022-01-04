# download the repo: git clone notebooks
# move into the cloned directory: cd notebooks
# get latest image tag from https://quay.io/repository/uninett/deep-learning-tools?tab=tags
FROM quay.io/uninett/deep-learning-tools:20210518-96a1f3f
# create image with CMD:  docker build --no-cache .
# list:	docker image ls
# bash:	docker run -it --privileged a589bca576b7 /bin/bash
# tag:	docker tag 5c29b3a5a392 animesh1977/notebooks
# load:	docker push animesh1977/notebooks
# latest: digest: sha256:3dd9f1e8c76d8ae37bee94516fc3d7d62d479904a73d1ccd59b6caf6bcb150da size: 15423
# Install system packages
USER root
RUN apt-get update && apt-get install -y vim psmisc openssh-server parallel
# cat /etc/os-release
# install mono https://www.mono-project.com/download/stable/#download-lin
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get update
RUN apt-get install -y apt-transport-https gnupg ca-certificates curl
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN rm packages-microsoft-prod.deb
RUN apt-get install -y mono-devel
RUN apt-get update
# install dotnet-3.1 https://tecadmin.net/how-to-install-dotnet-core-on-ubuntu-18-04/ for MaxQuant 2.0.3.0
RUN apt-get install -y dotnet-sdk-3.1
# pip pkgs
RUN pip install --upgrade pip
#RUN pip install tensorflow_decision_forests
RUN pip install ipyvolume
RUN jupyter nbextension enable --py --sys-prefix ipyvolume
#RUN jupyter lab build
#packages for R
#RUN R -e "update.packages(ask = FALSE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages(c('devtools','BiocManager'),dependencies=TRUE,repos='https://cloud.r-project.org/',ask=FALSE,INSTALL_opts = '--no-multiarch')"
#RUN R -e "devtools::install_github('bartongroup/Proteus', build_opts= c('--no-resave-data', '--no-manual'), build_vignettes=F)"
RUN R -e "install.packages(c('readxl','writexl','ggplot2','svglite','scales'),dependencies=TRUE,repos='https://cloud.r-project.org/',ask=FALSE,INSTALL_opts = '--no-multiarch')"
RUN R -e "BiocManager::install(c('pheatmap','limma','org.Hs.eg.db'))"
#bazel
#RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
#RUN mv bazel.gpg /etc/apt/trusted.gpg.d/
#RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
#RUN apt-get update && apt-get install -y bazel