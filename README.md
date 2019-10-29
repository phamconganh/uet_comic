# uet_comic

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Install
- [Install flutter](https://flutter.dev/docs/get-started/install)
- Install package: Opene project and run
```
flutter pub get
```

## Generating code env
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Run
Connect with device or simulator the run with case:
- dev
```
flutter run -t lib/main_dev.dart
```
- prod
```
flutter run -t lib/main_prod.dart --release
```

## Deployment
- genkey debug
```
keytool -genkey -v -keystore ./keys/debug.keystore -keysize 2048 -validity 10000 -alias uetcomic
```
password = uetcomic123
CN=Uet Comic, OU=UET, O=UET, L=Hanoi, ST=Hanoi, C=VN
