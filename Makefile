# Makefile for Flutter asset, splash screen, and launcher icon generation

.PHONY: assets splash icons

assets:
	flutter pub run build_runner build --delete-conflicting-outputs

splash:
	flutter pub run flutter_native_splash:create

icons:
	flutter pub run flutter_launcher_icons
