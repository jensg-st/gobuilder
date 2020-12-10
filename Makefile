mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: build-publisher
build-publisher:
	docker build --rm -t publisher build/publisher

.PHONY: build-builder
build-builder:
	docker build --rm -t builder build/builder

.PHONY: build-notify
build-notify:
	docker build --rm -t notifier build/notifier

.PHONY: run-notifier
run-notifier:
	docker run -v $(mkfile_dir)/test/notifier/:/flux-data notifier

.PHONY: run-builder
run-builder:
	docker run -v $(mkfile_dir)/test/builder/:/flux-data builder

.PHONY: run-publisher
run-publisher:
	docker run -v $(mkfile_dir)/test/publisher/:/flux-data publisher
