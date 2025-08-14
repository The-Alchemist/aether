.PHONY: build run test

build:
	docker compose build

run:
	docker compose run --rm --remove-orphans aether

test:
	docker compose run --rm --remove-orphans --entrypoint sh aether -c "grunt spec:aether"
