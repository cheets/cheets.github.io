module.exports = (grunt) ->
  grunt.initConfig
    bower:
      install:
        options:
          targetDir: './dist'
          layout: (type, component) ->
            type
          install: true
          verbose: false
          cleanTargetDir: false
          cleanBowerDir: true
    compass:
      dist:
        options:
          environment: 'production'
          force: true
          specify: 'sass/main.scss'
      dev:
        options:
          environment: 'development'
          specify: 'sass/main.scss'
    concurrent:
      serve:
        options:
          logConcurrentOutput: true
        tasks: ['watch', 'exec:serve']
    exec:
      build:
        cmd: 'jekyll build'
      serve:
        cmd: 'jekyll serve --watch'
    watch:
      sass:
        files: 'sass/*.scss'
        tasks: 'compass:dev'
        options:
          livereload: true

  grunt.loadNpmTasks('grunt-bower-task')
  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-exec')

  grunt.registerTask('default', ['compass:dev', 'exec:build'])
  grunt.registerTask('dist', ['compass:dist', 'exec:build'])
  grunt.registerTask('prepare-commit', ['compass:dist'])
  grunt.registerTask('serve', ['compass:dev', 'concurrent'])
