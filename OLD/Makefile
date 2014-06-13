build:
	browserify -t brfs index.js > bundle.js
	uglifyjs bundle.js > bundle.min.js

.PHONY: build