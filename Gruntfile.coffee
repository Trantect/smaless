module.exports = (grunt)->
  grunt.initConfig
    ###
    copy:
      production:
        files: [
          {expand: true, cwd: 'src', src: ['**', '!bower.json'], dest: 'build/'}
        ]

    mkdir:
      production:
        options:
          create: ["build"]
    ###
    watch:
      scripts:
        files: ['src/*.scss']
        tasks: ['sass:dev']
      options:
        spawn: false
        debounceDelay: 550
    clean:
      dev: ['build']
    sass:
      dev:
        files: [
          {
            expand: true,
            cwd: 'src',
            src: ['*.scss'],
            dest: './build',
            ext: '.css'
          }
        ]
    shell:
      installSASS:
        command: 'sudo gem install sass'
      installJADE:
        command: 'sudo npm install jade -g'
  ###
  grunt.loadNpmTasks 'grunt-mkdir'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  ###
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "default", ["sass:dev"]
  grunt.registerTask "cleanBuild", ["clean:dev"]

  ###
  grunt.registerTask "release", ["shell:unpublish", "shell:publish"]
  ###
