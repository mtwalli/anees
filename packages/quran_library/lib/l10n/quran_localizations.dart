import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'quran_localizations_ar.dart';
import 'quran_localizations_de.dart';
import 'quran_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of QuranLocalizations
/// returned by `QuranLocalizations.of(context)`.
///
/// Applications need to include `QuranLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/quran_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: QuranLocalizations.localizationsDelegates,
///   supportedLocales: QuranLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the QuranLocalizations.supportedLocales
/// property.
abstract class QuranLocalizations {
  QuranLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static QuranLocalizations of(BuildContext context) {
    return Localizations.of<QuranLocalizations>(context, QuranLocalizations)!;
  }

  static const LocalizationsDelegate<QuranLocalizations> delegate =
      _QuranLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en')
  ];

  /// Hint text in the search field
  ///
  /// In en, this message translates to:
  /// **'Search the Quran'**
  String get searchHint;

  /// Title of the word info bottom sheet
  ///
  /// In en, this message translates to:
  /// **'About the Word'**
  String get wordInfoTitle;

  /// Word info tab: recitations
  ///
  /// In en, this message translates to:
  /// **'Recitations'**
  String get tabRecitations;

  /// Word info tab: morphology / tasreef
  ///
  /// In en, this message translates to:
  /// **'Morphology'**
  String get tabMorphology;

  /// Word info tab: grammar / i'rab
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get tabGrammar;

  /// Message shown when word-info data for a given kind is not downloaded
  ///
  /// In en, this message translates to:
  /// **'{kind} data not loaded on device.'**
  String unavailableDataTemplate(String kind);

  /// Button label to start a download
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get downloadLabel;

  /// Button label while a download is in progress
  ///
  /// In en, this message translates to:
  /// **'Downloading…'**
  String get downloadingLabel;

  /// Error message when word data cannot be loaded
  ///
  /// In en, this message translates to:
  /// **'Failed to load word data.'**
  String get loadErrorText;

  /// Empty-state message when no word data exists
  ///
  /// In en, this message translates to:
  /// **'No data for this word.'**
  String get noDataText;

  /// Tooltip on the play-word audio button
  ///
  /// In en, this message translates to:
  /// **'Play word'**
  String get playWordTooltip;

  /// Tooltip on the play-all-ayah-words audio button
  ///
  /// In en, this message translates to:
  /// **'Play ayah words'**
  String get playAyahWordsTooltip;

  /// Tab/section label for tafsir (Quranic commentary)
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirLabel;

  /// Tab/section label for translation
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translationLabel;

  /// Tab/section label for footnotes / hawashi
  ///
  /// In en, this message translates to:
  /// **'Footnotes'**
  String get footnotesLabel;

  /// Note shown when tafsir for an ayah appears in earlier ayahs
  ///
  /// In en, this message translates to:
  /// **'\n\nTafsir for this ayah is in the preceding ayahs.'**
  String get emptyTafsirNote;

  /// Error when surah number cannot be identified for tajweed
  ///
  /// In en, this message translates to:
  /// **'Could not determine surah number.'**
  String get tajweedSurahError;

  /// Message when tajweed data is not downloaded
  ///
  /// In en, this message translates to:
  /// **'Tajweed data not loaded.'**
  String get tajweedUnavailable;

  /// Button to download tajweed data
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get tajweedDownload;

  /// Label while tajweed data is downloading
  ///
  /// In en, this message translates to:
  /// **'Downloading…'**
  String get tajweedDownloading;

  /// Error message when tajweed data fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load tajweed rules.'**
  String get tajweedLoadError;

  /// Empty state when no tajweed data exists for an ayah
  ///
  /// In en, this message translates to:
  /// **'No tajweed data for this ayah.'**
  String get tajweedNoData;

  /// Semantics label / tooltip for the font size control
  ///
  /// In en, this message translates to:
  /// **'Change Font Size'**
  String get changeFontSize;

  /// Button to expand truncated text
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// Button to collapse expanded text
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get readLess;

  /// Tooltip on the close / dismiss button in dialogs
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeLabel;

  /// Title of the fonts download dialog
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get fontsLabel;

  /// Title of the tajweed rules dialog
  ///
  /// In en, this message translates to:
  /// **'Tajweed Rules'**
  String get tajweedRulesLabel;

  /// Title of the auto-scroll settings panel
  ///
  /// In en, this message translates to:
  /// **'Auto-Scroll'**
  String get autoScrollTitle;

  /// Label for the stop-condition setting in auto-scroll
  ///
  /// In en, this message translates to:
  /// **'Stop at:'**
  String get stopAtLabel;

  /// Label for the page-count setting in auto-scroll
  ///
  /// In en, this message translates to:
  /// **'Page count:'**
  String get pageCountLabel;

  /// Label for the speed slider in auto-scroll settings
  ///
  /// In en, this message translates to:
  /// **'Speed:'**
  String get speedLabel;

  /// Minimum-speed label on the auto-scroll slider
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slowLabel;

  /// Maximum-speed label on the auto-scroll slider
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fastLabel;

  /// Helper note in the auto-scroll settings panel
  ///
  /// In en, this message translates to:
  /// **'Adjust scroll speed and auto-stop'**
  String get autoScrollNotes;

  /// Label showing the last-listened surah
  ///
  /// In en, this message translates to:
  /// **'Last listened'**
  String get lastListenLabel;

  /// Title of the change-reciter dialog
  ///
  /// In en, this message translates to:
  /// **'Change Reader'**
  String get changeReaderLabel;

  /// Singular form of the word 'ayah' (verse)
  ///
  /// In en, this message translates to:
  /// **'Ayah'**
  String get ayahSingular;

  /// Plural form of the word 'ayah' (verses)
  ///
  /// In en, this message translates to:
  /// **'Ayahs'**
  String get ayahPlural;

  /// Message shown when the device has no internet
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetText;

  /// Top-bar tab label for the surah/juz index
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get tabIndex;

  /// Top-bar tab label for search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get tabSearch;

  /// Top-bar tab label for bookmarks
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get tabBookmarks;

  /// Index sub-tab label for the surah list
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get tabSurahs;

  /// Index sub-tab label for the juz list
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get tabJuz;

  /// Title shown in the audio / surah listening screen
  ///
  /// In en, this message translates to:
  /// **'Listen to Surahs'**
  String get audioScreenTitle;

  /// Instruction note inside the fonts download dialog
  ///
  /// In en, this message translates to:
  /// **'To make the Mushaf look like the Madinah Mushaf, you can download the Mushaf fonts'**
  String get fontsDialogNotes;

  /// Label for the 'with tajweed' font option toggle
  ///
  /// In en, this message translates to:
  /// **'With Tajweed'**
  String get tajweedOption;

  /// Status text shown while fonts are being downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get fontsDownloadingText;

  /// Subtitle showing how many bookmarks are in a group
  ///
  /// In en, this message translates to:
  /// **'{count} bookmarks'**
  String bookmarkCount(String count);

  /// Chip label showing an ayah number in the bookmarks list
  ///
  /// In en, this message translates to:
  /// **'Ayah {number}'**
  String ayahLabel(String number);

  /// Chip/subtitle label showing a page number
  ///
  /// In en, this message translates to:
  /// **'Page {number}'**
  String pageLabel(String number);

  /// Label prefix before the juz name/number on the page header
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juzLabel;

  /// Label prefix before the hizb fraction on the page footer
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get hizbLabel;

  /// Label shown when an ayah of prostration (sajda) is on the page
  ///
  /// In en, this message translates to:
  /// **'Sajda'**
  String get sajdaLabel;

  /// Fallback surah name used when the Arabic name is unavailable
  ///
  /// In en, this message translates to:
  /// **'Surah {number}'**
  String surahFallbackName(String number);

  /// Main Quran tab label in the top-level tab bar
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get quranTabMain;

  /// Ten Recitations tab label in the top-level tab bar
  ///
  /// In en, this message translates to:
  /// **'Ten Recitations'**
  String get tenRecitationsTab;

  /// Tab label inside show_tafsir screen
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirTabLabel;

  /// Tab label inside show_tafsir screen
  ///
  /// In en, this message translates to:
  /// **'Tajweed Rules'**
  String get tajweedTabLabel;

  /// Display mode: default page view
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get displayModeDefault;

  /// Display mode: single scrollable page
  ///
  /// In en, this message translates to:
  /// **'Scrollable Page'**
  String get displayModeScrollable;

  /// Display mode: dual page spread
  ///
  /// In en, this message translates to:
  /// **'Two Pages'**
  String get displayModeDual;

  /// Display mode: Quran and tafsir side by side
  ///
  /// In en, this message translates to:
  /// **'Quran with Tafsir'**
  String get displayModeWithTafsirSide;

  /// Display mode: each ayah with inline tafsir
  ///
  /// In en, this message translates to:
  /// **'Ayah with Tafsir'**
  String get displayModeAyahTafsir;

  /// Auto-scroll stop condition: stop at next hizb
  ///
  /// In en, this message translates to:
  /// **'Next Hizb'**
  String get stopConditionNextHizb;

  /// Auto-scroll stop condition: stop at next juz
  ///
  /// In en, this message translates to:
  /// **'Next Juz'**
  String get stopConditionNextJuz;

  /// Auto-scroll stop condition: stop after N pages
  ///
  /// In en, this message translates to:
  /// **'Page count'**
  String get stopConditionPageCount;

  /// Auto-scroll stop condition: no automatic stop
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get stopConditionManual;

  /// Label for the ayah count field in surah info sheet
  ///
  /// In en, this message translates to:
  /// **'Ayah Count'**
  String get surahInfoAyahCount;

  /// Second tab in surah info sheet
  ///
  /// In en, this message translates to:
  /// **'About the Surah'**
  String get surahInfoAboutTab;

  /// First tab in surah info sheet
  ///
  /// In en, this message translates to:
  /// **'Surah Names'**
  String get surahInfoNamesTab;

  /// Empty state when no tafsir text exists for an ayah
  ///
  /// In en, this message translates to:
  /// **'No tafsir available'**
  String get noTafsirAvailable;

  /// Header label before footnote text in tafsir display
  ///
  /// In en, this message translates to:
  /// **'Footnotes:\n'**
  String get footnotesHeader;

  /// Empty state text in the bookmarks tab
  ///
  /// In en, this message translates to:
  /// **'No bookmarks saved'**
  String get bookmarksEmpty;

  /// Label for the yellow bookmark group
  ///
  /// In en, this message translates to:
  /// **'Yellow Bookmarks'**
  String get bookmarksYellow;

  /// Label for the red bookmark group
  ///
  /// In en, this message translates to:
  /// **'Red Bookmarks'**
  String get bookmarksRed;

  /// Label for the green bookmark group
  ///
  /// In en, this message translates to:
  /// **'Green Bookmarks'**
  String get bookmarksGreen;

  /// Tab label for the list of available reciters
  ///
  /// In en, this message translates to:
  /// **'Readers'**
  String get readersTab;

  /// Tab label for already-downloaded surahs
  ///
  /// In en, this message translates to:
  /// **'Downloaded Surahs'**
  String get downloadedSurahsTab;

  /// Title of the ayah/surah download manager sheet
  ///
  /// In en, this message translates to:
  /// **'Manage Surah Downloads'**
  String get downloadManagerTitle;

  /// Button label to re-download a previously downloaded item
  ///
  /// In en, this message translates to:
  /// **'Re-download'**
  String get redownloadLabel;

  /// Title of the change-tafsir dialog
  ///
  /// In en, this message translates to:
  /// **'Change Tafsir'**
  String get changeTafsirLabel;

  /// Snackbar/toast shown after an ayah is copied
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copySuccessMessage;

  /// Toast shown when ayah playback fails
  ///
  /// In en, this message translates to:
  /// **'Error playing ayahs: {error}'**
  String ayahPlayError(String error);

  /// Toast shown when the download manager sheet cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open download manager right now'**
  String get ayahDownloadManagerOpenError;

  /// Toast shown when user is downloading over mobile data
  ///
  /// In en, this message translates to:
  /// **'Warning: You are using mobile data to download'**
  String get mobileDataWarning;

  /// Text shown in seek bar while audio is being downloaded
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get seekBarDownloadingLabel;

  /// Count text in the ayah download manager
  ///
  /// In en, this message translates to:
  /// **'Downloaded {downloaded}/{total} ayah'**
  String ayahDownloadCount(String downloaded, String total);

  /// Error shown when a surah has no ayahs loaded
  ///
  /// In en, this message translates to:
  /// **'No ayahs found for the selected surah'**
  String get noAyahsForSurah;

  /// Toast shown when audio service cannot be initialized
  ///
  /// In en, this message translates to:
  /// **'Audio service failed to initialize. Will work without system controls.'**
  String get audioServiceInitError;

  /// Toast shown when audio focus cannot be obtained
  ///
  /// In en, this message translates to:
  /// **'Another audio is playing in the app. Please stop it first.'**
  String get audioFocusError;

  /// Toast shown when a surah cannot be loaded
  ///
  /// In en, this message translates to:
  /// **'Failed to load surah. Check connection and try again.'**
  String get surahLoadError;
}

class _QuranLocalizationsDelegate
    extends LocalizationsDelegate<QuranLocalizations> {
  const _QuranLocalizationsDelegate();

  @override
  Future<QuranLocalizations> load(Locale locale) {
    return SynchronousFuture<QuranLocalizations>(
        lookupQuranLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_QuranLocalizationsDelegate old) => false;
}

QuranLocalizations lookupQuranLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return QuranLocalizationsAr();
    case 'de':
      return QuranLocalizationsDe();
    case 'en':
      return QuranLocalizationsEn();
  }

  throw FlutterError(
      'QuranLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
