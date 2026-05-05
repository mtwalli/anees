part of '/quran.dart';

/// شروط توقف السكرول التلقائي
///
/// [AutoScrollStopCondition] defines when auto-scroll should stop
enum AutoScrollStopCondition {
  /// التوقف عند الوصول للحزب التالي
  nextHizb,

  /// التوقف عند الوصول للجزء التالي
  nextJuz,

  /// التوقف بعد عدد صفحات محدد
  pageCount,

  /// يستمر حتى يوقفه المستخدم يدويًا
  manual,
}

extension AutoScrollStopConditionX on AutoScrollStopCondition {
  /// التسمية المحلية بحسب الـ locale
  String label(BuildContext context) {
    final l = QuranLocalizations.of(context);
    switch (this) {
      case AutoScrollStopCondition.nextHizb:
        return l.stopConditionNextHizb;
      case AutoScrollStopCondition.nextJuz:
        return l.stopConditionNextJuz;
      case AutoScrollStopCondition.pageCount:
        return l.stopConditionPageCount;
      case AutoScrollStopCondition.manual:
        return l.stopConditionManual;
    }
  }

  String get labelAr {
    switch (this) {
      case AutoScrollStopCondition.nextHizb:
        return 'الحزب التالي';
      case AutoScrollStopCondition.nextJuz:
        return 'الجزء التالي';
      case AutoScrollStopCondition.pageCount:
        return 'عدد صفحات';
      case AutoScrollStopCondition.manual:
        return 'يدوي';
    }
  }

  int get storageIndex => index;

  static AutoScrollStopCondition fromStorageIndex(int index) {
    if (index >= 0 && index < AutoScrollStopCondition.values.length) {
      return AutoScrollStopCondition.values[index];
    }
    return AutoScrollStopCondition.manual;
  }
}
