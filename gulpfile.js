var gulp = require('gulp'),
    $ = require('gulp-load-plugins')(),

    sourceDirectory = 'src/',
    buildDirectory = 'dist/',
    bowerComponentsDirectory = 'bower_components/';

gulp.task('build-html', function() {
    return gulp.src(sourceDirectory + 'jade/*.jade')
        .pipe($.plumber())
        .pipe($.jade({
            pretty: true
        }))
        .pipe(gulp.dest(buildDirectory))
        .pipe($.livereload());
});

gulp.task('build-css', function() {
    return gulp.src([sourceDirectory + 'css/reset.min.css',
                     sourceDirectory + 'scss/*.scss'])
        .pipe($.plumber())
        .pipe($.sass())
        .pipe($.autoprefixer({
            browsers: ['last 3 versions'],
            cascade: false
        }))
        .pipe($.cssnano())
        .pipe($.concat('style.css'))
        .pipe(gulp.dest(buildDirectory + 'css'))
        .pipe($.livereload());
});

gulp.task('build-js', function() {
    gulp.src([bowerComponentsDirectory + 'jquery/dist/jquery.min.js'])
        .pipe($.plumber())
        .pipe($.concat('script.js'))
        .pipe(gulp.dest(buildDirectory + 'js'));

    return gulp.src([sourceDirectory + 'coffee/*.coffee'])
        .pipe($.plumber())
        .pipe($.coffee())
        .pipe($.concat('script.js'))
        .pipe(gulp.dest(buildDirectory + 'js'))
        .pipe($.livereload());
});

gulp.task('watch', function() {
    $.livereload.listen();
    gulp.watch(sourceDirectory + 'jade/**/*.jade', gulp.parallel('build-html'));
    gulp.watch(sourceDirectory + 'scss/**/*.scss', gulp.parallel('build-css'));
    gulp.watch(sourceDirectory + 'coffee/**/*.coffee', gulp.parallel('build-js'));
});

gulp.task('build', gulp.parallel('build-html', 'build-css', 'build-js'));

gulp.task('default', gulp.parallel('build'));