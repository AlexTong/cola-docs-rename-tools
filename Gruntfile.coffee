path = require("path")

cafResourcesPath = path.join(__dirname, "docs", "public", "resources", "caf-ui")
module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"
		clean:
			work: ["work"]
			docs: ["docs"]
			others: ["docs/public/cola-ui", "docs/public/include-all.js"]
		copy:
			docs:
				expand: true
				cwd: "cola-ui-docs"
				src: ["**"]
				dest: "docs"
			apiResources:
				expand: true
				cwd: "node_modules/grunt-cola-ui-build"
				src: ["resources/**"]
				dest: "docs/public/api"
			includeJs:
				expand: true
				cwd: "src"
				src: ["include-all.js"]
				dest: "docs/public"
		yamlToDoc:
			api:
				options:
					output: "docs/public/api"
					header: "CAF开发框架客户端API"
					indexPage: "caf.html"
				files: [
					{
						expand: true
						cwd: "work"
						src: ["**/*.yaml"]
						dest: "docs/public/api"
					}
				]
		rename:
			colaToCaf:
				files: [
					{
						src: path.join(__dirname, "docs", "public", "resources", "cola-ui")
						dest: cafResourcesPath
					}
					{
						src: path.join(cafResourcesPath, "cola.js")
						dest: path.join(cafResourcesPath, "caf.js")
					}
					{
						src: path.join(cafResourcesPath, "cola.css")
						dest: path.join(cafResourcesPath, "caf.css")
					}
					{
						src: path.join(__dirname, "docs", "public", "cola-interceptor.js")
						dest: path.join(__dirname, "docs", "public", "caf-interceptor.js")
					}
				]
		replace:
			api:
				src: [
					"cola-ui/src/**/*.yaml"
				]
				dest: 'work/'
				replacements: [
					{
						from: "cola"
						to: "caf"
					}
					{
						from: "Cola"
						to: "Caf"
					}
				]
			viewColaToCaf:
				src: ['docs/views/**/*.jade', 'docs/views/**/*.md','docs/public/examples/**/*.html','docs/public/examples/**/*.js']
				overwrite: true
				replacements: [{
					from: "cola"
					to: "caf"
				}, {
					from: "Cola"
					to: "Caf"
				}]
			jsColaToCaf:
				src: ['docs/public/resources/caf-ui/caf.js', 'docs/public/caf-interceptor.js']
				overwrite: true
				replacements: [{
					from: "cola"
					to: "caf"
				}, {
					from: "Cola"
					to: "Caf"
				}]

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-less"
	grunt.loadNpmTasks "grunt-mocha-test"
	grunt.loadNpmTasks "grunt-contrib-qunit"
	grunt.loadNpmTasks "grunt-contrib-uglify"
	grunt.loadNpmTasks "grunt-yaml"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-connect"
	grunt.loadNpmTasks "grunt-cola-ui-build"
	grunt.loadNpmTasks "grunt-contrib-concat"
	grunt.loadNpmTasks 'grunt-contrib-rename'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-compress'
	grunt.loadNpmTasks 'grunt-text-replace'
	grunt.loadNpmTasks 'grunt-contrib-rename'

	grunt.registerTask "api", [
		"clean:work", "clean:docs", "copy:docs", "rename",
		"replace:viewColaToCaf", "replace:jsColaToCaf", "replace:api",
		"yamlToDoc", "copy:apiResources", "clean:others", "copy:includeJs"
	]
