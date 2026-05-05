// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class QuranLocalizationsEn extends QuranLocalizations {
  QuranLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchHint => 'Search the Quran';

  @override
  String get wordInfoTitle => 'About the Word';

  @override
  String get tabRecitations => 'Recitations';

  @override
  String get tabMorphology => 'Morphology';

  @override
  String get tabGrammar => 'Grammar';

  @override
  String unavailableDataTemplate(String kind) {
    return '$kind data not loaded on device.';
  }

  @override
  String get downloadLabel => 'Download';

  @override
  String get downloadingLabel => 'Downloading…';

  @override
  String get loadErrorText => 'Failed to load word data.';

  @override
  String get noDataText => 'No data for this word.';

  @override
  String get playWordTooltip => 'Play word';

  @override
  String get playAyahWordsTooltip => 'Play ayah words';

  @override
  String get tafsirLabel => 'Tafsir';

  @override
  String get translationLabel => 'Translation';

  @override
  String get footnotesLabel => 'Footnotes';

  @override
  String get emptyTafsirNote =>
      '\n\nTafsir for this ayah is in the preceding ayahs.';

  @override
  String get tajweedSurahError => 'Could not determine surah number.';

  @override
  String get tajweedUnavailable => 'Tajweed data not loaded.';

  @override
  String get tajweedDownload => 'Download';

  @override
  String get tajweedDownloading => 'Downloading…';

  @override
  String get tajweedLoadError => 'Failed to load tajweed rules.';

  @override
  String get tajweedNoData => 'No tajweed data for this ayah.';

  @override
  String get changeFontSize => 'Change Font Size';

  @override
  String get readMore => 'Read more';

  @override
  String get readLess => 'Read less';

  @override
  String get closeLabel => 'Close';

  @override
  String get fontsLabel => 'Fonts';

  @override
  String get tajweedRulesLabel => 'Tajweed Rules';

  @override
  String get autoScrollTitle => 'Auto-Scroll';

  @override
  String get stopAtLabel => 'Stop at:';

  @override
  String get pageCountLabel => 'Page count:';

  @override
  String get speedLabel => 'Speed:';

  @override
  String get slowLabel => 'Slow';

  @override
  String get fastLabel => 'Fast';

  @override
  String get autoScrollNotes => 'Adjust scroll speed and auto-stop';

  @override
  String get lastListenLabel => 'Last listened';

  @override
  String get changeReaderLabel => 'Change Reader';

  @override
  String get ayahSingular => 'Ayah';

  @override
  String get ayahPlural => 'Ayahs';

  @override
  String get noInternetText => 'No internet connection';

  @override
  String get tabIndex => 'Index';

  @override
  String get tabSearch => 'Search';

  @override
  String get tabBookmarks => 'Bookmarks';

  @override
  String get tabSurahs => 'Surahs';

  @override
  String get tabJuz => 'Juz';

  @override
  String get audioScreenTitle => 'Listen to Surahs';

  @override
  String get fontsDialogNotes =>
      'To make the Mushaf look like the Madinah Mushaf, you can download the Mushaf fonts';

  @override
  String get tajweedOption => 'With Tajweed';

  @override
  String get fontsDownloadingText => 'Downloading';

  @override
  String bookmarkCount(String count) {
    return '$count bookmarks';
  }

  @override
  String ayahLabel(String number) {
    return 'Ayah $number';
  }

  @override
  String pageLabel(String number) {
    return 'Page $number';
  }

  @override
  String get juzLabel => 'Juz';

  @override
  String get hizbLabel => 'Hizb';

  @override
  String get sajdaLabel => 'Sajda';

  @override
  String surahFallbackName(String number) {
    return 'Surah $number';
  }

  @override
  String get quranTabMain => 'The Holy Quran';

  @override
  String get tenRecitationsTab => 'Ten Recitations';

  @override
  String get tafsirTabLabel => 'Tafsir';

  @override
  String get tajweedTabLabel => 'Tajweed Rules';

  @override
  String get displayModeDefault => 'Default';

  @override
  String get displayModeScrollable => 'Scrollable Page';

  @override
  String get displayModeDual => 'Two Pages';

  @override
  String get displayModeWithTafsirSide => 'Quran with Tafsir';

  @override
  String get displayModeAyahTafsir => 'Ayah with Tafsir';

  @override
  String get stopConditionNextHizb => 'Next Hizb';

  @override
  String get stopConditionNextJuz => 'Next Juz';

  @override
  String get stopConditionPageCount => 'Page count';

  @override
  String get stopConditionManual => 'Manual';

  @override
  String get surahInfoAyahCount => 'Ayah Count';

  @override
  String get surahInfoAboutTab => 'About the Surah';

  @override
  String get surahInfoNamesTab => 'Surah Names';

  @override
  String get noTafsirAvailable => 'No tafsir available';

  @override
  String get footnotesHeader => 'Footnotes:\n';

  @override
  String get bookmarksEmpty => 'No bookmarks saved';

  @override
  String get bookmarksYellow => 'Yellow Bookmarks';

  @override
  String get bookmarksRed => 'Red Bookmarks';

  @override
  String get bookmarksGreen => 'Green Bookmarks';

  @override
  String get readersTab => 'Readers';

  @override
  String get downloadedSurahsTab => 'Downloaded Surahs';

  @override
  String get downloadManagerTitle => 'Manage Surah Downloads';

  @override
  String get redownloadLabel => 'Re-download';

  @override
  String get changeTafsirLabel => 'Change Tafsir';

  @override
  String get copySuccessMessage => 'Copied to clipboard';

  @override
  String ayahPlayError(String error) {
    return 'Error playing ayahs: $error';
  }

  @override
  String get ayahDownloadManagerOpenError =>
      'Could not open download manager right now';

  @override
  String get mobileDataWarning =>
      'Warning: You are using mobile data to download';

  @override
  String get seekBarDownloadingLabel => 'Downloading';

  @override
  String ayahDownloadCount(String downloaded, String total) {
    return 'Downloaded $downloaded/$total ayah';
  }

  @override
  String get noAyahsForSurah => 'No ayahs found for the selected surah';

  @override
  String get audioServiceInitError =>
      'Audio service failed to initialize. Will work without system controls.';

  @override
  String get audioFocusError =>
      'Another audio is playing in the app. Please stop it first.';

  @override
  String get surahLoadError =>
      'Failed to load surah. Check connection and try again.';
}
