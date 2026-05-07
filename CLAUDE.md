# Anees — Claude Code Guidelines

## Localization

Every new feature **must** include translations for all three supported locales before it is considered complete:

| Locale | ARB file | Dart file |
|--------|----------|-----------|
| English | `lib/l10n/app_en.arb` | `lib/l10n/app_localizations_en.dart` |
| Arabic | `lib/l10n/app_ar.arb` | `lib/l10n/app_localizations_ar.dart` |
| German | `lib/l10n/app_de.arb` | `lib/l10n/app_de.arb` → `lib/l10n/app_localizations_de.dart` |

**Workflow for adding strings:**

1. Add the key + English text to `lib/l10n/app_en.arb` (with a `@key` description block).
2. Add the Arabic and German translations to `app_ar.arb` and `app_de.arb`.
3. Run `flutter gen-l10n` to regenerate `app_localizations.dart` and the three per-locale dart files.
4. Reference strings via `AppLocalizations.of(context).yourKey` — never hardcode user-visible text.

**No hardcoded user-visible strings.** Any string a user can read must go through `AppLocalizations`. This applies to titles, subtitles, button labels, error messages, placeholder text, and screen body copy.

## Project structure

- `lib/app.dart` — root `MaterialApp` + all home-screen widgets
- `lib/core/theme/app_colors.dart` — colour palette (light / dark)
- `lib/core/theme/app_theme.dart` — `ThemeData` + font constants
- `lib/l10n/` — ARB source files and generated dart localizations
- `packages/quran_library/` — local path-override of the Quran rendering library

## Flutter binary

`/Users/I541965/Develop/flutter/bin/flutter`
