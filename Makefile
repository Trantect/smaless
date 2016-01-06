.PHONY: all bower_clean buildScss

#　build develop environment after clone our project
all: bower_clean buildScss

env:
	sudo gem install sass
	rm -rf node_modules
	npm install

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
bower_clean:
	bower cache clean

build_dir:
	rm -rf build
	mkdir build
	mkdir build/components

tmp_dir:
	rm -rf src/tmp
	mkdir src/tmp
	mkdir src/tmp/components

buildScss: build_dir tmp_dir
	grunt
