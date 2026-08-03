# Dollar City

Local, pickup-only used marketplace where every item is listed for exactly **$1**.

This MVP is built with **Flutter**, **Dart**, **Riverpod**, and **Material 3**, using in-memory mock data only (no backend, auth, payments, shipping, or maps).

## Features

- **Home** — marketplace feed with category filters and item cards
- **Sell** — create a listing (fixed $1 price, validated form)
- **Messages** — mock conversations and a basic chat screen
- **Profile** — user info, active/reserved/sold listings, saved items
- Listing statuses: Available, Reserved, Sold (changeable by the seller)

## Requirements

- Flutter SDK 3.32+ (Dart 3.8+)
- Android Studio / Xcode / Chrome for your target platform

## Run

```bash
flutter pub get
flutter analyze
flutter run
```

Examples:

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

## Project structure

```
lib/
  main.dart
  app.dart
  core/theme/
  core/widgets/
  data/models/
  data/mock/
  features/home/
  features/item_details/
  features/create_listing/
  features/messages/
  features/profile/
  features/navigation/
```

## Limitations (MVP)

- All data is local and resets when the app restarts
- No authentication, payments, shipping, maps, or remote APIs
- Photos on the Sell screen are placeholders (no camera/gallery picker yet)
- Remote placeholder images need network access

## Suggested next step

Add persistent local storage (e.g. Hive or Isar) and a real photo picker before introducing a backend.
