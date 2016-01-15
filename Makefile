.PHONY: all build clean

all: build

env:
	npm install
clean:
	bower cache clean

build: clean
	rm -rf smaless
	mkdir smaless
	node getSmalessVersions.js
	sh installSmaless.sh

server:
	python -m SimpleHTTPServer