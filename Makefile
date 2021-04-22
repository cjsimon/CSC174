.PHONY: all
all: start

.PHONY: install
install:
	make build

.PHONY: start
start:
	docker-compose up

.PHONY: restart
restart:
	make stop
	make start

.PHONY: stop
stop:
	docker-compose down

.PHONY: force-stop
force-stop:
	docker-compose rm --stop --force

.PHONY: run
run:
	make start

.PHONY: rerun
rerun:
	make restart

.PHONY: build
build:
	docker-compose build

.PHONY: rebuild
rebuild:
	docker-compose build --no-cache

.PHONY: clean
clean:
	make stop
	make force-stop

.PHONY: attach-database
attach-database:
	docker exec -it csc174_database /bin/bash

.PHONY: attach-app
attach-app:
	docker exec -it csc174_app /bin/bash

.PHONY: edit
edit:
	${EDITOR} .
