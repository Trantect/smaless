env:
	npm install

build:
	rm -rf smaless
	mkdir smaless
	node getSmalessVersions.js
	sh installSmaless.sh
