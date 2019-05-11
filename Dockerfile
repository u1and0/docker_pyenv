# ---
# Welcome to Python dev docker image
# ---
#
# Info:
#   conda version : 4.6.14
#   python version : 3.7.3.final.0
#
# Usage:
#   In host machine's shell
#     $ docker pull u1and0/pyenv
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/pyenv
#   (Default) Start bash and print this help message
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/pyenv
#   Using other command with activating pyenv (=conda env: base)
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/pyenv bash -c "source /root/.bashrc && python"
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/pyenv bash -c "source /root/.bashrc && ipython"
#     $ docker run -it --rm -v `pwd`:/work -w /work u1and0/pyenv bash -c "source /root/.bashrc && nvim"
#     $ docker run -it --rm -v `pwd`:/work -w /work\
#         -p 8888:8888\
#         u1and0/pyenv\
#         bash -c "source /root/.bashrc &&\
#         jupyter notebook --allow-root"
#   In contaner
#     Just type
#     $ ipython
#         or
#     $ jupyter notebook
#         or
#     $ nvim
#     :PyenvActivate base

FROM u1and0/neovim:latest

# install miniconda3-latest & restore conda packages
RUN git submodule update --init --recursive pyenv &&\
    source "${HOME}/.pyenvrc" &&\
    pyenv install miniconda3-latest
RUN source "${HOME}/.pyenvrc" &&\
    conda install --quiet --yes \
        'conda-forge::jupyterthemes' \
        'conda-forge::jupyter_contrib_nbextensions' \
        'ipython' \
        'numpy' \
        'pandas' \
        'scipy' \
        'matplotlib' \
        'seaborn' \
        'more-itertools' \
        'sphinx' \
        'h5py' \
        'line_profiler' \
        'flake8' \
        'pyflakes' \
        'pylint' \
        'pandoc' \
        'pygments' \
        'plotly' \
        'jupyter' \
        'notebook' &&\
    conda remove --quiet --yes --force qt pyqt && \
    conda clean -tipsy && \
    pip install 'neovim' \
                'autopep8' \
                'cufflinks' \
                'yapf'
RUN pacman -Sy --noconfirm otf-ipafont

USER root
ENV SHELL "/bin/bash"
RUN echo "source /root/.pyenvrc" >> /root/.bashrc &&\
    echo "source activate" >> /root/.bashrc
COPY Dockerfile /etc/.Dockerfile

# Print help message on header & start bash
CMD ["bash", "-c", "source ~/.bashrc && head -31 /etc/.Dockerfile | sed -e 's/^#//g' && bash"]
LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="python dev container"\
      description.ja="python開発用コンテナ。ipython, jupyter notebook, neovimによる開発が可能"\
      build_version="pyenv:v1.1.0"
