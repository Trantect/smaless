module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['src/**/*.scss','demo/**/*.jade','demo/scss/*.scss']
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
      demo:
        files: [
          {
            expand: true,
            cwd: 'demo',
            src: ['scss/*.scss']
            dest: 'demo',
            ext: '.css'
          }
        ]

    coffee:
      demo:
        expand: true,
        cwd: 'demo/coffee',
        src: ['*.coffee'],
        dest: 'demo',
        ext: '.js'

    jade:
      demo:
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
      moveFontLib:
        command: 'cp -r src/lib/* build/'
  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "cleanLib", ["clean:lib"]
  grunt.registerTask "buildLib", ["cleanLib", "sass:lib", "shell:moveFontLib"]
  grunt.registerTask "buildDemo", ["sass:demo", "coffee:demo", "jade:demo"]
  grunt.registerTask "default", ["buildLib", "buildDemo"]


  
