// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Anees — The Intelligent Quran';

  @override
  String get homeAppBarTitle => 'Anees';

  @override
  String get sectionQuran => 'The Holy Quran';

  @override
  String get sectionAzkar => 'Azkar';

  @override
  String get tileQuranReaderTitle => 'The Noble Mushaf';

  @override
  String get tileQuranReaderSubtitle => 'Read and browse the Quran';

  @override
  String get tileTajweedTitle => 'Tajweed Rules';

  @override
  String get tileTajweedSubtitle => 'Learn the rules of Quranic recitation';

  @override
  String get tileAzkarTitle => 'Morning & Evening Azkar';

  @override
  String get tileAzkarSubtitle =>
      'Coming soon — daily remembrances & supplication';

  @override
  String get tajweedScreenTitle => 'Tajweed Rules';

  @override
  String get tajweedScreenBody =>
      'Coming soon — this section will include a comprehensive explanation of the rules of Quranic tajweed';
}
