#Instruction from https://apps.sigma2.no/docs/custom-docker-image.html
#Image name from https://github.com/Uninett/helm-charts/blob/master/repos/stable/deep-learning-tools/values.yaml
FROM    quay.io/uninett/deep-learning-tools:20190821-df15ac1
# Install system packages
USER    root
#reverting java and clang as image >20GB
RUN apt-get update && apt-get install -y apt-utils vim psmisc openssh-server git-core libpython-dev libblocksruntime-dev python3-pip zsh tmux autojump jq parallel libomp-dev libopenblas-base libsndfile1 default-jdk zlib1g-dev python3-setuptools
RUN pip install librosa colorama faiss-gpu ann-solo scipy vaex bqplot ipyvolume pythreejs numba pyro-ppl altair catboost modin rfpimp ipywidgets ipyvolume UMAP shapely pymagnitude descartes nxpd pystan matplotlib_venn 
RUN jupyter labextension install jupyter-threejs
RUN jupyter labextension install jupyterlab-datawidgets
RUN jupyter nbextension install --py --symlink --sys-prefix pythreejs
RUN jupyter nbextension enable --py --sys-prefix pythreejs
RUN jupyter nbextension enable --py --sys-prefix ipyvolume
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter lab build
# install mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-get install -y apt-transport-https
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y mono-devel
# install gcloud https://github.com/google/deepvariant/blob/r0.8/docs/deepvariant-quick-start.md from https://github.com/google/deepvariant/blob/r0.6/docs/deepvariant-quick-start.md , skipping https://github.com/google/deepvariant/blob/r0.7/docs/deepvariant-quick-start.md
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN sudo apt-get install -y apt-transport-https ca-certificates
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk
#packages for R
RUN R -e "update.packages(repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('multivariance',dependencies=TRUE,repos='http://cran.us.r-project.org',lib='packages')"
RUN R -e "install.packages('devtools',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('rstan',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('randomForestExplainer',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('rfVarImpOOB',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('SparseM',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('BiocManager',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('reticulate',INSTALL_opts = '--no-multiarch',dependencies=TRUE,repos='http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('RBGLđ')"
RUN R -e "BiocManager::install('graph')"
RUN R -e "install.packages('jsonlite',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('coltocaro/compMS')"
RUN R -e "devtools::install_github('rstudio/tfprobability',INSTALL_opts = '--no-multiarch')"
#docker run -it --privileged <docker-id> /bin/bash

