module.exports = (grunt)->
  grunt.initConfig

    watch:
      scss:
        files: ['src/**/*.scss']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 300
    clean:
      lib: ['build']
    sass:
      lib:
        files: [
          {
            expand: true,
            cwd: 'src',
            src: ['*.scss']
            dest: 'build/css/',
            ext: '.css'
          }
        ]

    shell:
      installSASS:
        command: 'sudo gem install sass'
      moveFontLib:
        command: 'cp -r src/lib/* build/'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask "buildEnv", ["shell:installSASS"]
  grunt.registerTask "cleanLib", ["clean:lib"]
  grunt.registerTask "buildLib", ["cleanLib", "sass:lib", "shell:moveFontLib"]
  grunt.registerTask "default", ["buildLib"]
