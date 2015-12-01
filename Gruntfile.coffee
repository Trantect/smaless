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
      lib: ['sassDoc']
      tmp: ['src/tmp']

    sass:
      lib:
        files: 'build/css/main.css':'src/tmp/main.scss'

    sassdoc:
        default:
          src: 'build'
          options:
            dest: 'sassdoc'
            display:
              access: ['public', 'private']
              alias: true
              watermark: false


    shell:
      installSASS:
        command: 'sudo gem install sass'
      moveFontLib:
        command: 'cp -r src/lib/* build/'
      runSassDoc:
        command: './node_modules/sassdoc/bin/sassdoc src sassDoc'
      concatSass:
        command: 'node concatAllScss.js'
      generateComponent:
        command: 'node generateComponents.js'
      compileComponents:
        command: 'sh compileScss.sh'
      cleanMap:
        command: 'rm -rf build/**/*.css.map'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask "buildEnv", ["shell:installSASS"]
  grunt.registerTask "cleanLib", ["clean:lib"]
  grunt.registerTask "buildLib", ["cleanLib", "shell:concatSass", "shell:generateComponent", "sass:lib", "shell:compileComponents","shell:moveFontLib", "shell:runSassDoc"]
  grunt.registerTask "default", ["buildLib", "clean:tmp","shell:cleanMap"]
