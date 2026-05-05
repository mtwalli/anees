import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_library/quran_library.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class AneesApp extends StatelessWidget {
  const AneesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anees',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        QuranLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
        Locale('ar'),
      ],
      home: const _QuranHome(),
    );
  }
}

class _QuranHome extends StatelessWidget {
  const _QuranHome();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColors.background(isDark);
    final text = AppColors.text(isDark);
    final accent = AppColors.accent(isDark);
    final sub = AppColors.subtext(isDark);
    final divider = AppColors.divider(isDark);

    return QuranLibraryScreen(
      parentContext: context,
      isDark: isDark,
      withPageView: true,
      useDefaultAppBar: true,
      isShowAudioSlider: true,
      appLanguageCode: 'en',

      // ── Core colors ───────────────────────────────────────────────────────
      backgroundColor: bg,
      textColor: text,
      ayahSelectedBackgroundColor: accent.withValues(alpha: 0.18),
      ayahSelectedFontColor: accent,
      ayahIconColor: accent,

      // ── Top bar ───────────────────────────────────────────────────────────
      topBarStyle: QuranTopBarStyle(
        backgroundColor: AppColors.darkBackground,
        textColor: accent,
        accentColor: accent,
        iconColor: accent,
        shadowColor: Colors.black54,
        quranTabText: QuranLocalizations.of(context).quranTabMain,
        tenRecitationsTabText: QuranLocalizations.of(context).tenRecitationsTab,
        tabLabelStyle: TextStyle(
          color: accent,
          fontFamily: AppTheme.arabicUIFont,
          fontSize: 13,
        ),
      ),

      // ── Index / surah & juz tabs ──────────────────────────────────────────
      indexTabStyle: IndexTabStyle(
        textColor: text,
        accentColor: accent,
        labelColor: accent,
        unselectedLabelColor: sub,
        surahNumberDecorationColor: accent,
        labelStyle: TextStyle(
          color: accent,
          fontFamily: AppTheme.arabicUIFont,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: sub,
          fontFamily: AppTheme.arabicUIFont,
        ),
      ),

      // ── Search tab ────────────────────────────────────────────────────────
      searchTabStyle: SearchTabStyle(
        textColor: text,
        accentColor: accent,
        surahChipBgColor: accent.withValues(alpha: 0.15),
        surahChipTextStyle: TextStyle(
          color: accent,
          fontFamily: AppTheme.arabicUIFont,
          fontSize: 12,
        ),
        searchHintStyle: TextStyle(color: sub, fontFamily: AppTheme.arabicUIFont),
        searchTextStyle: TextStyle(color: text, fontFamily: AppTheme.arabicUIFont),
        resultsDividerColor: divider,
      ),

      // ── Bookmarks tab ─────────────────────────────────────────────────────
      bookmarksTabStyle: BookmarksTabStyle.defaults(isDark: isDark, context: context).copyWith(
        textColor: text,
        subtitleTextColor: sub,
        emptyStateIconColor: accent.withValues(alpha: 0.4),
        emptyStateTextColor: sub,
      ),

      // ── Ayah long-press menu ──────────────────────────────────────────────
      ayahMenuStyle: AyahMenuStyle(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderColor: accent.withValues(alpha: 0.5),
        borderWidth: 1.0,
        copyIconColor: accent,
        tafsirIconColor: accent,
        playIconColor: accent,
        playAllIconColor: accent,
        dividerColor: divider,
        copyIconData: Icons.copy_all_rounded,
        tafsirIconData: Icons.article_rounded,
        playIconData: Icons.play_arrow_rounded,
        playAllIconData: Icons.queue_music_rounded,
        bookmarkIconData: Icons.bookmark_rounded,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // ── Surah name banner ─────────────────────────────────────────────────
      surahNameStyle: SurahNameStyle(
        surahNameColor: accent,
        surahNameSize: 22,
      ),

      // ── Surah info bottom sheet ───────────────────────────────────────────
      surahInfoStyle: SurahInfoStyle(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        surahNameColor: accent,
        surahNumberColor: accent,
        surahNumberDecorationColor: accent.withValues(alpha: 0.3),
        primaryColor: accent,
        titleColor: text,
        indicatorColor: accent,
        textColor: text,
        closeIconColor: sub,
      ),

      // ── Banner (surah header ornament) ────────────────────────────────────
      bannerStyle: BannerStyle(
        svgBannerColor: accent,
      ),

      // ── Basmala ───────────────────────────────────────────────────────────
      basmalaStyle: BasmalaStyle(
        basmalaColor: accent,
        basmalaFontSize: 22,
      ),

      // ── Page header / footer labels ───────────────────────────────────────
      topBottomQuranStyle: TopBottomQuranStyle(
        surahNameColor: accent,
        juzTextColor: sub,
        hizbTextColor: sub,
        pageNumberColor: accent,
        sajdaNameColor: accent,
      ),

      // ── Tafsir inline ─────────────────────────────────────────────────────
      ayahTafsirInlineStyle: AyahTafsirInlineStyle(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        ayahTextColor: text,
        tafsirTextColor: text,
        tafsirBackgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        dividerColor: divider,
        readMoreButtonColor: accent,
        readMoreTextStyle: TextStyle(color: accent, fontFamily: AppTheme.arabicUIFont),
        ayahNumberColor: accent,
        optionsBarBackgroundColor: AppColors.darkBackground,
        tafsirSelectorBarColor: AppColors.darkBackground,
        tafsirSelectorTextColor: accent,
        fontSizeIconColor: accent,
        playIconColor: accent,
        playAllIconColor: accent,
        copyIconColor: accent,
      ),

      // ── Snack bar ─────────────────────────────────────────────────────────
      snackBarStyle: SnackBarStyle(
        backgroundColor: AppColors.darkBackground,
        textStyle: TextStyle(color: accent, fontFamily: AppTheme.arabicUIFont),
        actionTextColor: accent,
      ),
    );
  }
}
