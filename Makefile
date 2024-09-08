SHELL := /bin/bash
gen:
	flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
apk-dev:
	dart apk -t lib/main_dev.dart