#!/bin/bash

apt-get update && apt-get -y upgrade
apt-get -y install \
    mosh \
    cron \
    zsh \
    rsync \
    software-properties-common \
    less \
    graphviz

/opt/conda/bin/conda update -y --all

/opt/conda/bin/conda install -y -c conda-forge \
    jupyter_contrib_nbextensions \
    jupyter_dashboards \
    python-graphviz \
    mkl mkl-service \
    s3fs

/opt/conda/bin/jupyter nbextension enable init_cell/main \
    && /opt/conda/bin/jupyter nbextension enable table_beautifier/main \
    && /opt/conda/bin/jupyter nbextension enable toc2/main \
    && /opt/conda/bin/jupyter nbextension enable collapsible_headings/main \
    && /opt/conda/bin/jupyter nbextension enable notify/notify \
    && /opt/conda/bin/jupyter nbextension enable hide_input/main \
    && /opt/conda/bin/jupyter nbextension enable splitcell/splitcell \
    && /opt/conda/bin/jupyter nbextension enable nbextensions_configurator/tree_tab/main \
    && /opt/conda/bin/jupyter nbextension enable nbextensions_configurator/config_menu/main \
    && /opt/conda/bin/jupyter nbextension enable contrib_nbextensions_help_item/main \
    && /opt/conda/bin/jupyter nbextension enable execute_time/ExecuteTime \
    && /opt/conda/bin/jupyter nbextension enable varInspector/main \
    && /opt/conda/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension

/opt/conda/bin/pip install jupyter_spark pyspark_dist_explore
/opt/conda/bin/jupyter serverextension enable --py jupyter_spark \
    && /opt/conda/bin/jupyter nbextension install --py jupyter_spark \
    && /opt/conda/bin/jupyter nbextension enable --py jupyter_spark

mkdir -p $(/opt/conda/bin/jupyter --data-dir)/nbextensions
cd $(/opt/conda/bin/jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
/opt/conda/bin/jupyter nbextension enable vim_binding/vim_binding
/opt/conda/bin/pip install tqdm mord dask[complete] ptpython

chown -R ankur.khanna:ankur.khanna /opt/conda
# since jupyter is run as root
mkdir -p /root/.jupyter/custom
wget -O /root/.jupyter/custom/custom.js https://raw.githubusercontent.com/junkmechanic/dotfiles/master/dev/ds_jupyter/jupyter_custom.js
wget -O /root/.jupyter/custom/custom.css https://raw.githubusercontent.com/junkmechanic/dotfiles/master/dev/ds_jupyter/jupyter_custom.css
wget -O /root/.jupyter/jupyter_notebook_config.py https://raw.githubusercontent.com/junkmechanic/dotfiles/master/dev/ds_jupyter/jupyter_notebook_config.py

# install neovim
add-apt-repository ppa:neovim-ppa/stable -y
apt-get update
apt-get -y install neovim
apt-get -y install python-dev python-pip python3-dev python3-pip
pip3 install neovim neovim-remote

# supervisorctl --username ankur.khanna --password <password> restart jupyter

# git clone http://ankur@gitlab.grabdata.info/ankur/alloftheshit.git /workspace/jupyter_notebooks/alloftheshit

# sync with s3
# */2 * * * * aws s3 sync /workspace/jupyter_notebooks/alloftheshit s3://grab-ds-datastore/user/ankur/backup/alloftheshit >/workspace/jupyter_notebooks/logs/s3_sync.log
