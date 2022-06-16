SHELL := /bin/bash
gen:
	flutter pub run build_runner build --delete-conflicting-outputs
apk-dev:
	flutter	build apk -t lib/main_dev.dart