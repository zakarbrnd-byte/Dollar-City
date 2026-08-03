# Dollar City

Local, pickup-only used marketplace where every item is listed for exactly **$1**.

**Tagline:** Everything is $1. Pick it up nearby.

Built with **Flutter**, **Dart**, **Riverpod**, and **Material 3**, using in-memory mock data only (no backend, auth, payments, shipping, or maps).

This branch layers the **Dollar City design system** (Dollar Green palette, spacing/radius tokens, shared widgets) on top of the existing marketplace MVP.

## Features

- **Home** — marketplace feed with category filters and item cards
- **Sell** — create a listing (fixed $1 price, validated form)
- **Messages** — mock conversations and a basic chat screen
- **Profile** — user info, active/reserved/sold listings, saved items
- Listing statuses: Available, Reserved, Sold (changeable by the seller)

## Run

```bash
flutter pub get
dart format .
flutter analyze
flutter run
```

## Web deployment

Build a production web bundle:

```bash
flutter build web --release --base-href "/Dollar-City/"
```

This repository includes:

- GitHub Actions workflow: `.github/workflows/deploy-web.yml`
- A published `gh-pages` branch with the latest web build

After GitHub Pages is enabled for this repo (Settings → Pages → Deploy from branch `gh-pages` `/` **or** GitHub Actions), the app will be available at:

https://zakarbrnd-byte.github.io/Dollar-City/

## Design tokens

Primary Dollar Green `#2E7D4F`, Dark Green `#174D32`, Light Mint `#DDEFE4`, Warm Cream `#F7F3E8`, Soft Gold `#C9A84C`, Background `#FAFBF8`, Surface `#FFFFFF`.

## Limitations

- All data is local and resets when the app restarts
- No authentication, payments, shipping, maps, or remote APIs
- Photos on the Sell screen are placeholders (no camera/gallery picker yet)
- Remote placeholder images need network access
- The repository is currently private; GitHub Pages may require a paid plan or making the repo public

## Suggested next step

Add persistent local storage (e.g. Hive or Isar) and a real photo picker before introducing a backend.
