#Instruction from https://apps.sigma2.no/docs/about-packages/deep-learning-tools/about.html
#Image name from https://github.com/Uninett/helm-charts/blob/master/repos/stable/deep-learning-tools/values.yaml
FROM    quay.io/uninett/deep-learning-tools:20190628-fafa7e0
# Install system packages
USER    root
RUN     apt-get update && apt-get install -y apt-utils vim psmisc openssh-server libopenmpi-dev git-core gcc   build-essential golang-go  libxml2-dev libcurl4-openssl-dev libssl-dev ffmpeg r-base-dev r-cran-rcpp parallel default-jdk ant clang zsh tmux autojump jq 
RUN 	apt-get  -y autoremove
RUN 	apt-get  -y clean
#pup update
RUN     pip install --upgrade pip
# install mono
RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN     apt-get install -y apt-transport-https
RUN     echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
RUN     apt-get update && apt-get install -y mono-devel
# Install other packages
USER    notebook
RUN     pip install pyro-ppl
RUN     pip install altair
RUN     pip install catboost
RUN     pip install modin
RUN     pip install rfpimp
RUN     pip install ipywidgets
RUN     pip install ipyvolume
RUN     pip install UMAP
RUN     pip install fastai
RUN     pip install numba




