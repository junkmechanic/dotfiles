FROM junkmechanic/ds_jupyter

USER root

# Export env settings
ENV TERM=xterm
ADD apt-packages.txt /tmp/apt-packages.txt
RUN apt-get update && \
    xargs -a /tmp/apt-packages.txt apt-get install -y

ADD requirements.txt /tmp/requirements.txt

USER ankur

RUN /opt/ds/bin/pip install -r /tmp/requirements.txt

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
