.PHONY: test clean shove

SHOVE := vendor/shove/bin/shove

test: shove
	@$(SHOVE) -r t/bash -v -s bash

clean:
	rm -rf vendor

shove: vendor
	@echo checkout or update vendor/shove
	@if [ -d vendor/shove ]; then \
		cd vendor/shove && git pull origin master --depth=1; \
	else \
		git clone --depth=1 https://github.com/progrhyme/shove.git vendor/shove; \
	fi

vendor:
	mkdir vendor
