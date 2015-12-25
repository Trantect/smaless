env:
	npm install
clean:
	bower cache clean
build:
	rm -rf smaless
	mkdir smaless
	node getSmalessVersions.js
	sh installSmaless.sh
