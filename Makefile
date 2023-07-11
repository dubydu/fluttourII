SHELL := /bin/bash
gen:
	dart run build_runner build --delete-conflicting-outputs
apk-dev:
	dart apk -t lib/main_dev.dart