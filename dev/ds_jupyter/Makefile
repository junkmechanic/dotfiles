VERSION=1.0

build:
	docker build -t junkmechanic/jupyter.img:$(VERSION) .

run:
	docker run --init \
		-p 8888:8888 \
		-v /home/ankur/devbench/notebooks:/home/ankur/notebooks \
		--name jupyternb \
		junkmechanic/jupyter.img:$(VERSION)

push:
	docker push junkmechanic/jupyter.img:$(VERSION)
