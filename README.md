# Dollar City

Local, pickup-only marketplace where every item is listed for exactly **$1**.

**Tagline:** Everything is $1. Pick it up nearby.

## UI structure

- Top header with Dollar City logo + location
- Search field
- Compact filter chips
- Vertical marketplace listing feed
- Fixed bottom navigation (Home / Sell / Messages / Profile)

Mock data only — no backend, auth, payments, shipping, or maps.

## Run

```bash
flutter pub get
dart format .
flutter analyze
flutter test
flutter run
```

## Web

```bash
flutter build web --release --base-href "/Dollar-City/"
```

## Next task

Implement the item details screen and connect marketplace listing taps.
