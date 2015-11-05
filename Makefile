#　build develop environment after clone our project
env:
	rm -rf node_modules
	npm install
	rm -rf bower_components
	bower install

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
build:
	# clear old output files
	rm -rf build
	grunt
