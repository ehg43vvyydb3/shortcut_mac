.PHONY: build deploy

build:
	swift build -c release

deploy: build
	launchctl kickstart -k gui/$$(id -u)/com.shortcutmac.app
