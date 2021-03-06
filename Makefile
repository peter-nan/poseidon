TAG=poseidon

build_poseidon:
	docker build -f ./Dockerfile.poseidon -t $(TAG) .

run_poseidon: build_poseidon
	docker run --rm -it $(TAG)

run_dev:
	docker run --rm -v "$(shell pwd):/poseidonWork" -it $(TAG)

run_sh: build_poseidon
	docker run --rm -it --entrypoint sh $(TAG)

build_docs:
	docker build -f ./Dockerfile.docs -t $(TAG)-docs .

run_docs: build_docs
	docker run --rm -it -p 8080 $(TAG)-docs

run_tests: build_poseidon
	docker build -f ./Dockerfile.test -t $(TAG)-test .
	docker run --rm -it $(TAG)-test

.PHONY:  build_poseidon run_poseidon run_sh build_docs run_docs run_tests
