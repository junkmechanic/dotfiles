#!/usr/bin/python3

import docker

# This is a translation of the following shell command
# `docker run -d --init -p 8989:8888 \
#    -v /host/dir/to/mount:/container/dir/to/mount/to --name dsnb dsnb_db.img`

client = docker.from_env()

client.containers.run(
    image='ds_jupyter.img',
    detach=True,
    init=True,
    ports={'8888/tcp': 8989},
    volumes={
        '/Users/ankur/devbench/notebooks/': {
            'bind': '/home/ankur/notebooks',
            'mode': 'rw'
        },
    },
    name='dsnb',
    # mem_limit='100g'
)
