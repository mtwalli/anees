// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class QuranLocalizationsAr extends QuranLocalizations {
  QuranLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get searchHint => 'بحث في القرآن';

  @override
  String get wordInfoTitle => 'عن الكلمة';

  @override
  String get tabRecitations => 'القراءات';

  @override
  String get tabMorphology => 'التصريف';

  @override
  String get tabGrammar => 'الإعراب';

  @override
  String unavailableDataTemplate(String kind) {
    return 'بيانات $kind غير محمّلة على الجهاز.';
  }

  @override
  String get downloadLabel => 'تحميل';

  @override
  String get downloadingLabel => 'جاري التحميل...';

  @override
  String get loadErrorText => 'تعذّر تحميل بيانات هذه الكلمة.';

  @override
  String get noDataText => 'لا توجد بيانات لهذه الكلمة.';

  @override
  String get playWordTooltip => 'تشغيل الكلمة';

  @override
  String get playAyahWordsTooltip => 'تشغيل كلمات الآية';

  @override
  String get tafsirLabel => 'التفسير';

  @override
  String get translationLabel => 'الترجمة';

  @override
  String get footnotesLabel => 'الحواشي';

  @override
  String get emptyTafsirNote => '\n\nتفسير هذه الآية في الأيات السابقة';

  @override
  String get tajweedSurahError => 'تعذّر تحديد رقم السورة';

  @override
  String get tajweedUnavailable => 'بيانات أحكام التجويد غير محمّلة.';

  @override
  String get tajweedDownload => 'تحميل';

  @override
  String get tajweedDownloading => 'جاري التحميل...';

  @override
  String get tajweedLoadError => 'تعذّر تحميل أحكام التجويد.';

  @override
  String get tajweedNoData => 'لا توجد بيانات تجويد لهذه الآية.';

  @override
  String get changeFontSize => 'تغيير حجم الخط';

  @override
  String get readMore => 'اقرأ المزيد';

  @override
  String get readLess => 'اقرأ أقل';

  @override
  String get closeLabel => 'إغلاق';

  @override
  String get fontsLabel => 'الخطوط';

  @override
  String get tajweedRulesLabel => 'أحكام التجويد';

  @override
  String get autoScrollTitle => 'السكرول التلقائي';

  @override
  String get stopAtLabel => 'التوقف عند:';

  @override
  String get pageCountLabel => 'عدد الصفحات:';

  @override
  String get speedLabel => 'السرعة:';

  @override
  String get slowLabel => 'بطيء';

  @override
  String get fastLabel => 'سريع';

  @override
  String get autoScrollNotes => 'ضبط سرعة السكرول والتوقف التلقائي';

  @override
  String get lastListenLabel => 'آخر إستماع';

  @override
  String get changeReaderLabel => 'تغيير القارئ';

  @override
  String get ayahSingular => 'آية';

  @override
  String get ayahPlural => 'آيات';

  @override
  String get noInternetText => 'لا يوجد اتصال بالإنترنت';

  @override
  String get tabIndex => 'الفهرس';

  @override
  String get tabSearch => 'البحث';

  @override
  String get tabBookmarks => 'الفواصل';

  @override
  String get tabSurahs => 'السور';

  @override
  String get tabJuz => 'الأجزاء';

  @override
  String get audioScreenTitle => 'الإستماع للسور';

  @override
  String get fontsDialogNotes =>
      'لجعل مظهر المصحف مشابه لمصحف المدينة يمكنك تحميل خطوط المصحف';

  @override
  String get tajweedOption => 'مع التجويد';

  @override
  String get fontsDownloadingText => 'جارِ التحميل';

  @override
  String bookmarkCount(String count) {
    return 'عدد: $count';
  }

  @override
  String ayahLabel(String number) {
    return 'آية $number';
  }

  @override
  String pageLabel(String number) {
    return 'صفحة $number';
  }

  @override
  String get juzLabel => 'الجزء';

  @override
  String get hizbLabel => 'الحزب';

  @override
  String get sajdaLabel => 'سجدة';

  @override
  String surahFallbackName(String number) {
    return 'السورة $number';
  }

  @override
  String get quranTabMain => 'القرآن الكريم';

  @override
  String get tenRecitationsTab => 'القراءات العشر';

  @override
  String get tafsirTabLabel => 'التفسير';

  @override
  String get tajweedTabLabel => 'أحكام التجويد';

  @override
  String get displayModeDefault => 'افتراضي';

  @override
  String get displayModeScrollable => 'صفحة قابلة للتمرير';

  @override
  String get displayModeDual => 'صفحتان';

  @override
  String get displayModeWithTafsirSide => 'مصحف وتفسير';

  @override
  String get displayModeAyahTafsir => 'آية مع تفسير';

  @override
  String get stopConditionNextHizb => 'الحزب التالي';

  @override
  String get stopConditionNextJuz => 'الجزء التالي';

  @override
  String get stopConditionPageCount => 'عدد صفحات';

  @override
  String get stopConditionManual => 'يدوي';

  @override
  String get surahInfoAyahCount => 'عدد الآيات';

  @override
  String get surahInfoAboutTab => 'عن السورة';

  @override
  String get surahInfoNamesTab => 'أسماء السورة';

  @override
  String get noTafsirAvailable => 'لا يوجد تفسير متاح';

  @override
  String get footnotesHeader => 'الحواشي:\n';

  @override
  String get bookmarksEmpty => 'لا توجد فواصل محفوظة';

  @override
  String get bookmarksYellow => 'الفواصل الصفراء';

  @override
  String get bookmarksRed => 'الفواصل الحمراء';

  @override
  String get bookmarksGreen => 'الفواصل الخضراء';

  @override
  String get readersTab => 'القراء';

  @override
  String get downloadedSurahsTab => 'السور المحملة';

  @override
  String get downloadManagerTitle => 'إدارة تحميل آيات السور';

  @override
  String get redownloadLabel => 'إعادة';

  @override
  String get changeTafsirLabel => 'تغيير التفسير';

  @override
  String get copySuccessMessage => 'تم النسخ الى الحافظة';

  @override
  String ayahPlayError(String error) {
    return 'خطأ في تشغيل الآيات: $error';
  }

  @override
  String get ayahDownloadManagerOpenError => 'تعذّر فتح مدير تنزيل الآيات الآن';

  @override
  String get mobileDataWarning => 'تنبيه: أنت تستخدم بيانات الجوال للتحميل';

  @override
  String get seekBarDownloadingLabel => 'جارِ التحميل';

  @override
  String ayahDownloadCount(String downloaded, String total) {
    return 'تم تحميل $downloaded/$total آية';
  }

  @override
  String get noAyahsForSurah => 'لا توجد آيات للسورة المحددة';

  @override
  String get audioServiceInitError =>
      'تعذّرت تهيئة خدمة الصوت. ستعمل دون تحكم بالنظام.';

  @override
  String get audioFocusError =>
      'يتم تشغيل صوت آخر في التطبيق. يرجى إيقافه أولاً.';

  @override
  String get surahLoadError =>
      'تعذّر تحميل السورة. تحقّق من الاتصال وحاول مجددًا';
}
