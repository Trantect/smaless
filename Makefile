#　build develop environment after clone our project
env:
	rm -rf node_modules
	npm install

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
build:
	grunt
