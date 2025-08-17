.PHONY: build run test

build:
	docker compose build

# runs very basic aether tests
test: test-aether

test-aether:
	docker compose run --rm --remove-orphans --entrypoint sh aether -c "grunt spec:aether"

test-python:
	docker compose run --rm --remove-orphans --entrypoint sh aether -c "grunt spec:python"

test-clojure:
	docker compose run --rm --remove-orphans --entrypoint sh aether -c "grunt spec:clojure"
