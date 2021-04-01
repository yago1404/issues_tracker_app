# issues_tracker_app

Issues tracker application

## How to run

You need install Dart language and Flutter framework
available in [flutter.dev](https://flutter.dev)

Clone this repository

Run
```shell
flutter doctor
```
to check if Flutter was installed correctly and accept android-licenses

Open a pubspec.yaml and touch in Pub get on AndroidStudio
or run
```shell
flutter pub get
```
to get a project dependencies

Open a android emulator and touch in run button on AndroidStudio or run with
```shell
flutter run
```

To run this project witch a backend you need clone and run a [issues tracker backend](https://github.com/yago1404/issues-tracker)

**Important**: To app run correctly, you need change in lib/commons/consts.dart
```dart
const String ip = "{ HERE }" // to your Ip
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
