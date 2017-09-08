#!/usr/bin/env bash

FROM ubuntu:latest

# Export env settings
ENV TERM=xterm
# Set the locale
RUN apt-get clean && apt-get update
RUN apt-get install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -y && apt-get install build-essential -y

ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

RUN pip install virtualenv
RUN /usr/local/bin/virtualenv /opt/ds --distribute --python=/usr/bin/python3

ADD /requirements/ /tmp/requirements

RUN /opt/ds/bin/pip install -r /tmp/requirements/pre-requirements.txt
RUN /opt/ds/bin/pip install -r /tmp/requirements/requirements.txt

RUN useradd --create-home --home-dir /home/ankur --shell /bin/bash ankur
# RUN usermod -a -G sudo ankur
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

EXPOSE 8888
USER ankur
RUN mkdir -p /home/ankur/notebooks
ENV HOME=/home/ankur
ENV SHELL=/bin/bash
ENV USER=ankur
VOLUME /home/ankur/notebooks
WORKDIR /home/ankur/notebooks

RUN /opt/ds/bin/pip install jupyter_contrib_nbextensions \
    && /opt/ds/bin/jupyter contrib nbextension install --sys-prefix \
    && /opt/ds/bin/jupyter nbextension enable init_cell/main \
    && /opt/ds/bin/jupyter nbextension enable table_beautifier/main \
    && /opt/ds/bin/jupyter nbextension enable toc2/main \
    && /opt/ds/bin/jupyter nbextension enable collapsible_headings/main \
    && /opt/ds/bin/jupyter nbextension enable notify/notify \
    && /opt/ds/bin/jupyter nbextension enable hide_input/main \
    && /opt/ds/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension

RUN git clone https://github.com/lambdalisue/jupyter-vim-binding /opt/ds/share/jupyter/nbextensions/vim_binding \
    && /opt/ds/bin/jupyter nbextension enable vim_binding/vim_binding

RUN mkdir -p /home/ankur/.jupyter/custom
ADD jupyter_custom.js /home/ankur/.jupyter/custom/custom.js
USER root
RUN chown ankur /home/ankur/.jupyter/custom/custom.js
USER ankur

CMD ["/home/ankur/run_jupyter.sh"]
