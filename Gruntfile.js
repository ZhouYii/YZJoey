module.exports = function(grunt) {

    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        compass: {
            dev: {
                options: {
                    config: 'config.rb',
                    force: true
                }
            }
        },

        imagemin: {                         
            dist: {                           
                options: {                    
                    optimizationLevel: 3
                },
                files: [{
                    expand: true,
                    cwd: 'assets/img/uncompressed/',
                    src: ['*.{png,jpg,jpeg}','posts/*.{png,jpg,jpeg}','posts/*/*.{png,jpg,jpeg}'],
                    dest: 'assets/img/'
                }]
            }
        },

        concat: {
            options: {
                separator: ';'
            },
            dist: {
                src: ['assets/js/plugins/*.js', 'assets/js/main.js'],
                dest: 'assets/js/<%= pkg.name %>.js'
            }
        },

        uglify: {
            options: {
                banner: '/*! Output of concatenated/minified with Grunt - <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n',
                report: 'gzip'
            },
            dist: {
                files: {
                    'assets/js/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>'],
                    'assets/js/modernizr-custom.min.js' : 'assets/js/modernizr-custom.js'
                }
            }
        },

        jekyll: {
            dev: {
                dest: '_site'
            }
        }, 

        watch: {
            js: {
                files: ['assets/js/**/*.js'],
                tasks: ['concat','uglify']
            },
            sass: {
                files: ['assets/scss/**/*.scss'],
                tasks: ['compass:dev']
            },
            jekyll: {
                files: ['_layouts/*','blog/*.html','blog/_posts/*','assets/*','*.html','assets/css/*'],
                tasks: ['jekyll:dev']
            }
        }

    });

    grunt.registerTask('default', 'watch');

}