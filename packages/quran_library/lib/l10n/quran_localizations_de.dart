// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class QuranLocalizationsDe extends QuranLocalizations {
  QuranLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get searchHint => 'Koran durchsuchen';

  @override
  String get wordInfoTitle => 'Über das Wort';

  @override
  String get tabRecitations => 'Lesarten';

  @override
  String get tabMorphology => 'Morphologie';

  @override
  String get tabGrammar => 'Grammatik';

  @override
  String unavailableDataTemplate(String kind) {
    return '$kind-Daten nicht auf Gerät geladen.';
  }

  @override
  String get downloadLabel => 'Herunterladen';

  @override
  String get downloadingLabel => 'Wird heruntergeladen…';

  @override
  String get loadErrorText => 'Wortdaten konnten nicht geladen werden.';

  @override
  String get noDataText => 'Keine Daten für dieses Wort.';

  @override
  String get playWordTooltip => 'Wort abspielen';

  @override
  String get playAyahWordsTooltip => 'Ayah-Wörter abspielen';

  @override
  String get tafsirLabel => 'Tafsir';

  @override
  String get translationLabel => 'Übersetzung';

  @override
  String get footnotesLabel => 'Fußnoten';

  @override
  String get emptyTafsirNote =>
      '\n\nDer Tafsir zu dieser Ayah befindet sich in den vorangehenden Ayahs.';

  @override
  String get tajweedSurahError => 'Suran-Nummer konnte nicht ermittelt werden.';

  @override
  String get tajweedUnavailable => 'Tajweed-Daten nicht geladen.';

  @override
  String get tajweedDownload => 'Herunterladen';

  @override
  String get tajweedDownloading => 'Wird heruntergeladen…';

  @override
  String get tajweedLoadError => 'Tajweed-Regeln konnten nicht geladen werden.';

  @override
  String get tajweedNoData => 'Keine Tajweed-Daten für diese Ayah.';

  @override
  String get changeFontSize => 'Schriftgröße ändern';

  @override
  String get readMore => 'Mehr lesen';

  @override
  String get readLess => 'Weniger lesen';

  @override
  String get closeLabel => 'Schließen';

  @override
  String get fontsLabel => 'Schriften';

  @override
  String get tajweedRulesLabel => 'Tajweed-Regeln';

  @override
  String get autoScrollTitle => 'Automatisches Scrollen';

  @override
  String get stopAtLabel => 'Anhalten bei:';

  @override
  String get pageCountLabel => 'Seitenanzahl:';

  @override
  String get speedLabel => 'Geschwindigkeit:';

  @override
  String get slowLabel => 'Langsam';

  @override
  String get fastLabel => 'Schnell';

  @override
  String get autoScrollNotes =>
      'Scrollgeschwindigkeit und automatischen Stopp anpassen';

  @override
  String get lastListenLabel => 'Zuletzt gehört';

  @override
  String get changeReaderLabel => 'Leser wechseln';

  @override
  String get ayahSingular => 'Ayah';

  @override
  String get ayahPlural => 'Ayahs';

  @override
  String get noInternetText => 'Keine Internetverbindung';

  @override
  String get tabIndex => 'Index';

  @override
  String get tabSearch => 'Suche';

  @override
  String get tabBookmarks => 'Lesezeichen';

  @override
  String get tabSurahs => 'Suren';

  @override
  String get tabJuz => 'Juz';

  @override
  String get audioScreenTitle => 'Suren anhören';

  @override
  String get fontsDialogNotes =>
      'Um das Mushaf wie das Madinah-Mushaf aussehen zu lassen, können Sie die Mushaf-Schriften herunterladen';

  @override
  String get tajweedOption => 'Mit Tajweed';

  @override
  String get fontsDownloadingText => 'Wird heruntergeladen';

  @override
  String bookmarkCount(String count) {
    return '$count Lesezeichen';
  }

  @override
  String ayahLabel(String number) {
    return 'Ayah $number';
  }

  @override
  String pageLabel(String number) {
    return 'Seite $number';
  }

  @override
  String get juzLabel => 'Juz';

  @override
  String get hizbLabel => 'Hizb';

  @override
  String get sajdaLabel => 'Niederwerfung';

  @override
  String surahFallbackName(String number) {
    return 'Sure $number';
  }

  @override
  String get quranTabMain => 'Der Heilige Koran';

  @override
  String get tenRecitationsTab => 'Zehn Lesarten';

  @override
  String get tafsirTabLabel => 'Tafsir';

  @override
  String get tajweedTabLabel => 'Tajweed-Regeln';

  @override
  String get displayModeDefault => 'Standard';

  @override
  String get displayModeScrollable => 'Scrollbare Seite';

  @override
  String get displayModeDual => 'Zwei Seiten';

  @override
  String get displayModeWithTafsirSide => 'Koran mit Tafsir';

  @override
  String get displayModeAyahTafsir => 'Ayah mit Tafsir';

  @override
  String get stopConditionNextHizb => 'Nächster Hizb';

  @override
  String get stopConditionNextJuz => 'Nächster Juz';

  @override
  String get stopConditionPageCount => 'Seitenanzahl';

  @override
  String get stopConditionManual => 'Manuell';

  @override
  String get surahInfoAyahCount => 'Anzahl der Ayahs';

  @override
  String get surahInfoAboutTab => 'Über die Sure';

  @override
  String get surahInfoNamesTab => 'Namen der Sure';

  @override
  String get noTafsirAvailable => 'Kein Tafsir verfügbar';

  @override
  String get footnotesHeader => 'Fußnoten:\n';

  @override
  String get bookmarksEmpty => 'Keine Lesezeichen gespeichert';

  @override
  String get bookmarksYellow => 'Gelbe Lesezeichen';

  @override
  String get bookmarksRed => 'Rote Lesezeichen';

  @override
  String get bookmarksGreen => 'Grüne Lesezeichen';

  @override
  String get readersTab => 'Rezitatoren';

  @override
  String get downloadedSurahsTab => 'Heruntergeladene Suren';

  @override
  String get downloadManagerTitle => 'Suren-Downloads verwalten';

  @override
  String get redownloadLabel => 'Erneut herunterladen';

  @override
  String get changeTafsirLabel => 'Tafsir wechseln';

  @override
  String get copySuccessMessage => 'In die Zwischenablage kopiert';

  @override
  String ayahPlayError(String error) {
    return 'Fehler beim Abspielen der Ayahs: $error';
  }

  @override
  String get ayahDownloadManagerOpenError =>
      'Download-Manager konnte gerade nicht geöffnet werden';

  @override
  String get mobileDataWarning =>
      'Achtung: Sie laden über mobile Daten herunter';

  @override
  String get seekBarDownloadingLabel => 'Wird heruntergeladen';

  @override
  String ayahDownloadCount(String downloaded, String total) {
    return '$downloaded/$total Ayah heruntergeladen';
  }

  @override
  String get noAyahsForSurah => 'Keine Ayahs für die ausgewählte Sure gefunden';

  @override
  String get audioServiceInitError =>
      'Audio-Dienst konnte nicht initialisiert werden. Funktioniert ohne Systemsteuerung.';

  @override
  String get audioFocusError =>
      'Ein anderes Audio läuft in der App. Bitte zuerst stoppen.';

  @override
  String get surahLoadError =>
      'Sure konnte nicht geladen werden. Verbindung prüfen und erneut versuchen.';
}
