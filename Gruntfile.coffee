module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['src/**/*.scss','demo/**/*.jade']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 300
    clean:
      dev: ['build']
    sass:
      dev:
        files: [
          {
            expand: true,
            cwd: 'src',
            src: ['*.scss']
            dest: 'build',
            ext: '.css'
          }
        ]

    jade: 
      debug:
        options: 
          data:
            debug: true,
            timestamp: "<%= new Date().getTime() %>"
        files:
          "demo/doc.html": "demo/doc.jade"
          "demo/sma.html": "demo/sma.jade"

    shell:
      installSASS:
        command: 'sudo gem install sass'
      installJADE:
        command: 'sudo npm install jade -g'
  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "default", ["clean:dev","sass:dev","jade:debug"]
  grunt.registerTask "cleanBuild", ["clean:dev"]
  grunt.registerTask "buildDemo", ["jade:debug"]


  
