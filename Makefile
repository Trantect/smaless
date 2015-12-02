#　build develop environment after clone our project
env:
	sudo gem install sass
	rm -rf node_modules
	npm install

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
buildScss:
	rm -rf build
	mkdir build
	mkdir build/components
	rm -rf src/tmp
	mkdir src/tmp
	mkdir src/tmp/components
	grunt
