// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أنيس — القرآن الذكي';

  @override
  String get homeAppBarTitle => 'أنيس';

  @override
  String get sectionQuran => 'القرآن الكريم';

  @override
  String get sectionAzkar => 'الأذكار';

  @override
  String get tileQuranReaderTitle => 'المصحف الشريف';

  @override
  String get tileQuranReaderSubtitle => 'اقرأ وتصفّح القرآن';

  @override
  String get tileTajweedTitle => 'أحكام التجويد';

  @override
  String get tileTajweedSubtitle => 'تعلّم أحكام تلاوة القرآن';

  @override
  String get tileAzkarTitle => 'أذكار الصباح والمساء';

  @override
  String get tileAzkarSubtitle => 'قريباً — أذكار اليوم والدعاء';

  @override
  String get tajweedScreenTitle => 'أحكام التجويد';

  @override
  String get tajweedScreenBody =>
      'قريباً — سيتضمن هذا القسم شرحاً وافياً لأحكام تجويد القرآن الكريم';
}
