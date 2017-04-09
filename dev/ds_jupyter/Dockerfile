#!/usr/bin/env bash

FROM dataquestio/ubuntu-base

# Export env settings
ENV TERM=xterm
ENV LANG en_US.UTF-8

RUN apt-get update -y && apt-get install build-essential -y

ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /opt/tini
RUN mv /opt/tini /usr/local/bin/tini \
    && chmod +x /usr/local/bin/tini

RUN pip install virtualenv
RUN /usr/local/bin/virtualenv /opt/ds --distribute --python=/usr/bin/python3

ADD /requirements/ /tmp/requirements

RUN /opt/ds/bin/pip install -r /tmp/requirements/pre-requirements.txt
RUN /opt/ds/bin/pip install -r /tmp/requirements/requirements.txt

RUN useradd --create-home --home-dir /home/ds --shell /bin/bash ds
RUN chown -R ds /opt/ds
RUN adduser ds sudo

ADD run_ipython.sh /home/ds
RUN chmod +x /home/ds/run_ipython.sh
RUN chown ds /home/ds/run_ipython.sh

ADD bashrc /home/ds/.bashrc
ADD inputrc /home/ds/.inputrc
ADD vimrc /home/ds/.vimrc
RUN chown ds /home/ds/.bashrc
RUN chown ds /home/ds/.inputrc
RUN chown ds /home/ds/.vimrc

EXPOSE 8888
RUN usermod -a -G sudo ds
RUN echo "ds ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ds
RUN mkdir -p /home/ds/notebooks
ENV HOME=/home/ds
ENV SHELL=/bin/bash
ENV USER=ds
VOLUME /home/ds/notebooks
WORKDIR /home/ds/notebooks

RUN /opt/ds/bin/pip install jupyter_contrib_nbextensions \
    && /opt/ds/bin/jupyter contrib nbextension install --sys-prefix \
    && /opt/ds/bin/jupyter nbextension enable init_cell/main \
    && /opt/ds/bin/jupyter nbextension enable table_beautifier/main \
    && /opt/ds/bin/jupyter nbextension enable toc2/main \
    && /opt/ds/bin/jupyter nbextension enable collapsible_headings/main \
    && /opt/ds/bin/jupyter nbextension enable notify/notify

RUN git clone https://github.com/lambdalisue/jupyter-vim-binding /opt/ds/share/jupyter/nbextensions/vim_binding \
    && /opt/ds/bin/jupyter nbextension enable vim_binding/vim_binding

RUN mkdir -p /home/ds/.jupyter/custom
ADD jupyter_custom.js /home/ds/.jupyter/custom/custom.js
USER root
RUN chown ds /home/ds/.jupyter/custom/custom.js
USER ds

ENTRYPOINT ["tini", "--"]
CMD ["/home/ds/run_ipython.sh"]
