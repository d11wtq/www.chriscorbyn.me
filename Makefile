YML ?= $(PWD)/deploy.yml
IMG ?= $(shell awk -F':' '/image:/ {print $$2}' $(YML))
TAG ?= $(shell awk -F':' '/image:/ {print $$3}' $(YML))
DST ?= $(IMG):$(TAG)

.PHONY: build push deploy

build:
	docker build --rm -t $(DST) .

push:
	docker push $(DST)

deploy:
	curl -XPUT -H 'Content-Type: text/yaml' --data-binary @$(YML) \
	  http://localhost:3000/stacks/www-chriscorbyn-co-uk
