#
pjName := example-cfx-redux-counter

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash

build:
	mkdir -p ./build
	coffee -bo build src

dest:
	mkdir -p ./dest
	babel --presets env --plugins=transform-runtime build --out-dir dest

clean:
	rm -rf ./build
	rm -rf ./dest

test: clean build dest
	coffee test/index.coffee
