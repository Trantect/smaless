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
      lib: ['dist', 'styleguide', 'scssDoc.html']
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

    cssdocs:
      docs:
        files: [
          {
            src: ['src/**/*.{scss,sass,less,styl}']
            dest: 'styleguide'
          }
        ]
        options:
          template: './node_modules/grunt-css-docs/template/'
          parsers:
            link: (i, line, block) ->
              exp = "/(b(https?|ftp|file)://[-A-Z0-9+&@#/%?=~_|!:,.;]*[-A-Z0-9+&@#/%=~_|])/ig"
              line.replace(exp, "<a href='$1'>$1</a>")
              return line

    shell:
      installSASS:
        command: 'sudo gem install sass'
      moveFontLib:
        command: 'cp -r src/lib/* dist/'
      renameSassDoc:
        command: 'mv styleguideindex.html scssDoc.html'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-css-docs'

  grunt.registerTask "buildEnv", ["shell:installSASS"]
  grunt.registerTask "cleanLib", ["clean:lib"]
  grunt.registerTask "buildLib", ["cleanLib","cssdocs:docs", "shell:renameSassDoc", "sass:lib", "shell:moveFontLib"]
  grunt.registerTask "default", ["buildLib"]
