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
      lib: ['dist', 'sassDoc']
    sass:
      lib:
        files: [
          {
            expand: true,
            cwd: 'src',
            src: ['*.scss']
            dest: 'dist/css/',
            ext: '.css'
          }
        ]

    sassdoc:
        default:
          src: 'build'
          options:
            dest: 'sassdoc'
            display:
              access: ['public', 'private']
              alias: true
              watermark: true

    shell:
      installSASS:
        command: 'sudo gem install sass'
      moveFontLib:
        command: 'cp -r src/lib/* dist/'
      command: 'cp -r src/lib/* build/'
      runSassDoc:
        command: './node_modules/sassdoc/bin/sassdoc src sassDoc'


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-sassdoc'

  grunt.registerTask "buildEnv", ["shell:installSASS"]
  grunt.registerTask "cleanLib", ["clean:lib"]
  grunt.registerTask "buildLib", ["cleanLib", "sass:lib", "shell:moveFontLib", "shell:runSassDoc"]
  grunt.registerTask "default", ["buildLib"]
