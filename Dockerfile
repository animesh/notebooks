#Image name from https://github.com/Uninett/helm-charts/blob/master/repos/stable/deep-learning-tools/values.yaml
FROM quay.io/uninett/deep-learning-tools:20190821-df15ac1
# Install system packages
USER root
RUN apt-get update && apt-get install -y apt-utils vim psmisc openssh-server git-core libpython-dev libblocksruntime-dev python3-pip zsh tmux autojump jq parallel libomp-dev libopenblas-base libsndfile1 default-jdk zlib1g-dev python3-setuptools apt-utils libcurl4-openssl-dev libxml2-dev libxrender1 libxext6 openjdk-8-jdk
#RUN conda update -n base conda
#RUN conda install -c conda-forge rdkit --yes
RUN pip install --upgrade pip ipywidgets pandas
RUN pip install ipyvolume modin pymagnitude librosa colorama faiss-gpu ann-solo scipy vaex bqplot pythreejs numba pyro-ppl altair catboost rfpimp UMAP shapely descartes nxpd pystan matplotlib_venn molsets  sigopt
RUN jupyter labextension install jupyterlab-datawidgets
RUN jupyter nbextension install --py --symlink --sys-prefix pythreejs
RUN jupyter nbextension enable --py --sys-prefix pythreejs
RUN jupyter nbextension enable --py --sys-prefix ipyvolume
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter lab build
# install mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get install -y apt-transport-https
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y mono-devel
#packages for R
RUN R -e "update.packages(ask = FALSE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('multivariance',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('devtools',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('rstan',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('randomForestExplainer',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('rfVarImpOOB',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('SparseM',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('BiocManager',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('mice',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('lme4',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('gganimate',dependencies=TRUE,repos='http://cran.us.r-project.org')"
#RUN R -e "install.packages('reticulate',INSTALL_opts = '--no-multiarch',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('RBGL')"
RUN R -e "BiocManager::install('graph')"
RUN R -e "BiocManager::install('clusterProfiler')"
RUN R -e "BiocManager::install('pheatmap')"
RUN R -e "BiocManager::install('eulerr')"
RUN R -e "BiocManager::install('DEqMS')"
RUN R -e "BiocManager::install('ROTS')"
#RUN R -e "BiocManager::install('sva')"
RUN R -e "BiocManager::install('mixOmics')"
#RUN R -e "install.packages('jsonlite',dependencies=TRUE, repos='http://cran.rstudio.com/')"
#winpty docker run -it --privileged <docker-id>  bash


