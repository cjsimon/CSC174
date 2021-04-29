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
	make remove
	make start

.PHONY: stop
stop:
	docker-compose stop

.PHONY: down
down:
	docker-compose down

.PHONY: remove
remove:
	docker-compose rm

.PHONY: force-remove
force-remove:
	docker-compose rm --force

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

.PHONY: build-app
build-app:
	docker-compose build app

.PHONY: rebuild-app
rebuild-app:
	docker-compose build --no-cache app

.PHONY: build-database
build-database:
	docker-compose build database

.PHONY: rebuild-database
rebuild-database:
	docker-compose build --no-cache database

.PHONY: clean
clean:
	make down
	make force-remove

.PHONY: attach-app
attach-app:
	docker exec -it csc174_app /bin/bash

.PHONY: attach-database
attach-database:
	docker exec -it csc174_database /bin/bash

.PHONY: edit
edit:
	${EDITOR} .
