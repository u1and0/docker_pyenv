# Neovim container
# Using my dotfiles
# Get plugins by dein
#
# Usage:
# In host machine
#    $ docker pull u1and0/pyenv
#    $ docker run -it --rm -v `pwd`:/work -w /work -p 8888:8888 u1and0/pyenv [filename]
# In docker
#    $ source activate
#    $ ipython
#        or
#    $ jupyter notebook
#        or
#    $ nvim
#    :PyenvActivate base

FROM u1and0/neovim:latest


# install miniconda3-latest & restore conda packages
RUN git submodule update --init --recursive pyenv &&\
    source "${HOME}/.pyenvrc" &&\
    pyenv install miniconda3-latest
RUN source "${HOME}/.pyenvrc" &&\
    conda install --quiet --yes \
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

CMD source /root/.pyenvrc && /bin/bash

LABEL maintainer="u1and0 <e01.ando60@gmail.com>"\
      description="python container"\
      description.ja="pythonコンテナ。ipython, jupyter notebook, neovimによる開発が可能"\
      version="pyenv:v1.0.0"
