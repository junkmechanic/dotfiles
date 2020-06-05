FROM ubuntu:latest

# Export env settings
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
# Set the locale
RUN apt-get clean && apt-get update && \
    apt-get install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

RUN echo "Europe/London" > /etc/timezone && \
    rm /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN pip3 install virtualenv
RUN /usr/local/bin/virtualenv /opt/ds

ADD /requirements/ /tmp/requirements

RUN /opt/ds/bin/pip3 install -r /tmp/requirements/pre-requirements.txt
RUN /opt/ds/bin/pip3 install -r /tmp/requirements/requirements.txt

RUN useradd --create-home --home-dir /home/ankur --shell /bin/bash -u 1001 ankur
# RUN useradd --create-home --home-dir /home/ankur -u 1002 --shell /bin/bash ankur
RUN adduser ankur sudo
RUN echo "ankur ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R ankur /opt/ds

ADD run_jupyter.sh /home/ankur
RUN chmod +x /home/ankur/run_jupyter.sh
RUN chown ankur /home/ankur/run_jupyter.sh

ADD bashrc /home/ankur/.bashrc
ADD inputrc /home/ankur/.inputrc
ADD vimrc /home/ankur/.vimrc
RUN chown ankur /home/ankur/.bashrc
RUN chown ankur /home/ankur/.inputrc
RUN chown ankur /home/ankur/.vimrc

USER ankur
RUN mkdir -p /home/ankur/notebooks
ENV HOME=/home/ankur
ENV SHELL=/bin/bash
ENV USER=ankur
# VOLUME /home/ankur/notebooks
WORKDIR /home/ankur/notebooks
ADD BoilerplateInit.ipynb /home/ankur/notebooks/BoilerplateInit.ipynb

RUN /opt/ds/bin/pip3 install jupyter_contrib_nbextensions \
    && /opt/ds/bin/jupyter contrib nbextension install --sys-prefix \
    && /opt/ds/bin/jupyter nbextension enable init_cell/main \
    && /opt/ds/bin/jupyter nbextension enable toc2/main \
    && /opt/ds/bin/jupyter nbextension enable collapsible_headings/main \
    && /opt/ds/bin/jupyter nbextension enable notify/notify \
    && /opt/ds/bin/jupyter nbextension enable hide_input/main \
    && /opt/ds/bin/jupyter nbextension enable splitcell/splitcell \
    && /opt/ds/bin/jupyter nbextension enable nbextensions_configurator/tree_tab/main \
    && /opt/ds/bin/jupyter nbextension enable nbextensions_configurator/config_menu/main \
    && /opt/ds/bin/jupyter nbextension enable contrib_nbextensions_help_item/main \
    && /opt/ds/bin/jupyter nbextension enable execute_time/ExecuteTime \
    && /opt/ds/bin/jupyter nbextension enable varInspector/main \
    && /opt/ds/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension

RUN /opt/ds/bin/jupyter serverextension enable --py --sys-prefix jupyter_spark \
    && /opt/ds/bin/jupyter nbextension install --py --sys-prefix jupyter_spark

RUN git clone https://github.com/lambdalisue/jupyter-vim-binding /opt/ds/share/jupyter/nbextensions/vim_binding \
    && /opt/ds/bin/jupyter nbextension enable vim_binding/vim_binding

RUN mkdir -p /home/ankur/.jupyter/custom
ADD jupyter_custom.js /home/ankur/.jupyter/custom/custom.js
ADD jupyter_custom.css /home/ankur/.jupyter/custom/custom.css
ADD jupyter_notebook_config.py /home/ankur/.jupyter/jupyter_notebook_config.py

USER root
RUN chown ankur /home/ankur/.jupyter/custom/custom.js
RUN chown ankur /home/ankur/.jupyter/custom/custom.css
RUN chown ankur /home/ankur/.jupyter/jupyter_notebook_config.py
USER ankur

CMD ["/home/ankur/run_jupyter.sh"]
