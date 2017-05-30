#!/usr/bin/env bash

FROM ds_jupyter:v2

USER root

# Export env settings
ENV TERM=xterm
ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

ADD requirements.txt /tmp/requirements.txt

USER ds

RUN /opt/ds/bin/pip install -r /tmp/requirements.txt

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENTRYPOINT ["tini", "--"]
CMD ["/home/ds/run_ipython.sh"]
