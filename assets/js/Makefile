# Builds the necessary Javascript files
#
# This Makefile compresses everything with `browserify` and `uglifyjs`
PATH  := node_modules/.bin:$(PATH)

build:
	browserify -t brfs index.js  > bundle.js
	uglifyjs           bundle.js > bundle.min.js

.PHONY: build

