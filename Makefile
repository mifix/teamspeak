NAME=teamspeak
REPO=wth-kiste/$(NAME)

PORTS=-p 9987:9987/udp -p 10011:10011 -p 30033:30033
CWD=$(shell pwd)

.PHONY: build start stop run prepare

all: build


build:
	docker build -t $(REPO) .

run: prepare
	docker run -it $(PORTS) -v $(CWD)/data:/home/teamspeak/data --rm $(REPO) /bin/bash

start: prepare
	docker run -d --name $(NAME) $(PORTS) -v $(CWD)/data:/home/teamspeak/data $(REPO)

stop: prepare
	docker stop $(NAME)
	docker rm $(NAME)

prepare:
	@touch $(CWD)/data/ts3server.sqlitedb
	@mkdir -p $(CWD)/data/logs
