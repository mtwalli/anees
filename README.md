# Anees — The Intelligent Quran

A Flutter application for reading and listening to the Holy Quran, built with an authentic Medina Mushaf rendering engine and a clean black-and-blue design.

## Features

- **Authentic Mushaf rendering** — Uthmanic Hafs script with proper typography
- **Word-by-word audio** — tap any word to hear its recitation
- **Multiple recitations** — switch between reciters from the top bar
- **Surah & Juz index** — browse by surah or juz with search
- **Search** — full-text search across all ayahs
- **Bookmarks** — save and revisit ayahs
- **Tafsir** — inline tafsir with font-size control
- **Light & dark themes** — follows system appearance (blue-on-black dark mode)
- **Page view** — swipe between pages just like a physical Mushaf

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3 / Dart |
| Quran engine | `quran_library ^4.0.3` |
| Fonts | UthmanicHafs V20, NotoNaskhArabic, SurahNameNaskh |
| Min Android SDK | 21 |
| iOS | Runner (Swift) |

## Getting Started

**Prerequisites:** Flutter SDK ≥ 3.11.5

```bash
# Install dependencies
flutter pub get
```

## Running the App

### iOS

```bash
# List available simulators
flutter devices

# Run on a connected iPhone or simulator
flutter run -d ios

# Run on a specific simulator
flutter run -d "iPhone 15 Pro"

# Build a release IPA
flutter build ipa
```

> Requires Xcode and a valid Apple developer account for device builds.

### Android

```bash
# List connected devices / emulators
flutter devices

# Run on a connected device or emulator
flutter run -d android

# Build a release APK
flutter build apk --release

# Build an App Bundle (recommended for Play Store)
flutter build appbundle --release
```

> Requires Android Studio and a connected device or running emulator.

### macOS

```bash
# Run on macOS desktop
flutter run -d macos

# Build a release app
flutter build macos --release
```

> Requires macOS and Xcode installed.

### Linux

```bash
# Run on Linux desktop
flutter run -d linux

# Build a release binary
flutter build linux --release
```

### Run on All Devices at Once

```bash
# See all connected devices
flutter devices

# Run on every connected device simultaneously
flutter run -d all
```

## Project Structure

```
lib/
├── main.dart               # Entry point — initialises QuranLibrary
├── app.dart                # App root, MaterialApp, QuranLibraryScreen wiring
└── core/
    └── theme/
        ├── app_colors.dart # Colour palette (light & dark)
        └── app_theme.dart  # ThemeData for light and dark modes

assets/
├── data/quran.json         # Quran text data
├── fonts/                  # UthmanicHafs, NotoNaskhArabic, SurahName fonts
└── icon/icon.png           # Source app icon

packages/
└── quran_library/          # Local override of the quran_library package
```

## Package ID

`com.app.anees`

## License

Private — all rights reserved.
