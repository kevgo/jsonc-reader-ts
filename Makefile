build:  # builds for the current platform
	${CURDIR}/node_modules/.bin/tsc -p .

clean:  # Removes all build artifacts
	rm -rf dist

fix:  # runs the auto-fixers
	${CURDIR}/node_modules/.bin/eslint . --fix --ext .ts
	${CURDIR}/node_modules/.bin/sort-package-json
	dprint fmt

help:  # prints all make targets
	cat Makefile | grep '^[^ ]*:' | grep -v '.PHONY' | grep -v '.SILENT:' | grep -v help | sed 's/:.*#/#/' | column -s "#" -t

lint:  # lints all files in this codebase
	${CURDIR}/node_modules/.bin/eslint . --ext .ts
	${CURDIR}/node_modules/.bin/sort-package-json --check
	dprint check &
	git diff --check

publish: clean build  # publishes this package
	npm publish

setup:  # prepares this codebase for work after cloning
	yarn

test: lint unit # runs all tests
.PHONY: test

unit:  # runs the unit tests
	${CURDIR}/node_modules/.bin/mocha "test/*.test.ts"

update:  # updates to the latest dependencies
	yarn upgrade --latest


.DEFAULT_GOAL := help
.SILENT:
