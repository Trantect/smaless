#　build develop environment after clone our project
env:
	rm -rf node_modules
	npm install

# clear old output files
clean:
	rm -rf build

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
build:
	grunt
