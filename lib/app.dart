import 'dart:math' show max;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_library/quran_library.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/tajweed/tajweed_screen.dart';
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
      supportedLocales: const [Locale('en'), Locale('de'), Locale('ar')],
      home: const _HomeScreen(),
    );
  }
}

// ── Circular reveal page transition ─────────────────────────────────────────
// A ripple circle expands from the tap point, revealing the new page.
// On pop the circle contracts back to the same origin point.

class _CircularRevealClipper extends CustomClipper<Path> {
  const _CircularRevealClipper({required this.fraction, required this.center});

  final double fraction; // 0.0 → 1.0
  final Offset center;

  @override
  Path getClip(Size size) {
    // Maximum radius needed to cover every corner from the tap point.
    final maxRadius = [
      (center - Offset.zero).distance,
      (center - Offset(size.width, 0)).distance,
      (center - Offset(0, size.height)).distance,
      (center - Offset(size.width, size.height)).distance,
    ].reduce(max);

    final radius = maxRadius * fraction;
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(_CircularRevealClipper old) =>
      old.fraction != fraction || old.center != center;
}

class _CircularRevealRoute<T> extends PageRouteBuilder<T> {
  _CircularRevealRoute({
    required WidgetBuilder builder,
    required this.tapPosition,
  }) : super(
          pageBuilder: (context, a, b) => builder(context),
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 420),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
              reverseCurve: Curves.easeInOutCubic.flipped,
            );
            return AnimatedBuilder(
              animation: curved,
              builder: (context, child) => ClipPath(
                clipper: _CircularRevealClipper(
                  fraction: curved.value,
                  center: tapPosition,
                ),
                child: child,
              ),
              child: child,
            );
          },
        );

  final Offset tapPosition;
}

// ── Staggered entrance animation helper ─────────────────────────────────────

class _Staggered extends StatefulWidget {
  const _Staggered({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<_Staggered> createState() => _StaggeredState();
}

class _StaggeredState extends State<_Staggered>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    final delay = widget.index * 0.12; // 0, 0.12, 0.24 …
    final start = delay.clamp(0.0, 0.8);
    final end = (start + 0.55).clamp(0.0, 1.0);
    final interval = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(interval);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(interval);

    // Start after a tiny frame delay so the scaffold is laid out first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ── Home Screen ──────────────────────────────────────────────────────────────

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColors.background(isDark);
    final text = AppColors.text(isDark);
    final accent = AppColors.accent(isDark);
    final sub = AppColors.subtext(isDark);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App bar ───────────────────────────────────────────────────
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              backgroundColor: AppColors.darkBackground,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 14),
                title: Text(
                  l10n.homeAppBarTitle,
                  style: TextStyle(
                    fontFamily: AppTheme.arabicUIFont,
                    color: accent,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Quran section ─────────────────────────────────────
                  _Staggered(
                    index: 0,
                    child: _SectionHeader(
                        label: l10n.sectionQuran, color: accent),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _Staggered(
                          index: 1,
                          child: _MainTile(
                            icon: Icons.menu_book_rounded,
                            title: l10n.tileQuranReaderTitle,
                            subtitle: l10n.tileQuranReaderSubtitle,
                            accent: accent,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                            onTap: (pos) => Navigator.of(context).push(
                              _CircularRevealRoute(
                                tapPosition: pos,
                                builder: (ctx) => const _QuranHome(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Staggered(
                          index: 2,
                          child: _MainTile(
                            icon: Icons.record_voice_over_rounded,
                            title: l10n.tileTajweedTitle,
                            subtitle: l10n.tileTajweedSubtitle,
                            accent: accent,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                            onTap: (pos) => Navigator.of(context).push(
                              _CircularRevealRoute(
                                tapPosition: pos,
                                builder: (ctx) => const TajweedScreen(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Azkar section ─────────────────────────────────────
                  _Staggered(
                    index: 3,
                    child: _SectionHeader(
                        label: l10n.sectionAzkar, color: accent),
                  ),
                  const SizedBox(height: 12),
                  _Staggered(
                    index: 4,
                    child: _AzkarPlaceholderTile(
                        accent: accent, text: text, sub: sub, isDark: isDark),
                  ),

                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable widgets ─────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTheme.arabicUIFont,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

// ── Main tile with press animation ───────────────────────────────────────────

class _MainTile extends StatefulWidget {
  const _MainTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.text,
    required this.sub,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final Color text;
  final Color sub;
  final bool isDark;
  final ValueChanged<Offset> onTap; // global tap position for reveal origin

  @override
  State<_MainTile> createState() => _MainTileState();
}

class _MainTileState extends State<_MainTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
    _glow = Tween<double>(begin: 0.25, end: 0.85).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _down(TapDownDetails d) => _ctrl.forward();

  void _up(TapUpDetails d) {
    _ctrl.reverse();
    widget.onTap(d.globalPosition);
  }

  void _cancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(widget.isDark);

    return GestureDetector(
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.accent.withValues(alpha: _glow.value),
                  width: lerpDouble(1.0, 1.8, _ctrl.value)!,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.accent.withValues(
                        alpha: lerpDouble(0.0, 0.22, _ctrl.value)!),
                    blurRadius: lerpDouble(0, 18, _ctrl.value)!,
                    spreadRadius: lerpDouble(0, 2, _ctrl.value)!,
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, color: widget.accent, size: 26),
            ),
            const SizedBox(height: 14),
            Text(
              widget.title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: AppTheme.arabicUIFont,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: AppTheme.arabicUIFont,
                fontSize: 12,
                color: widget.sub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AzkarPlaceholderTile extends StatelessWidget {
  const _AzkarPlaceholderTile({
    required this.accent,
    required this.text,
    required this.sub,
    required this.isDark,
  });

  final Color accent;
  final Color text;
  final Color sub;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(isDark);
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accent.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  l10n.tileAzkarTitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: AppTheme.arabicUIFont,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.tileAzkarSubtitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: AppTheme.arabicUIFont,
                    fontSize: 12,
                    color: sub,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.wb_sunny_rounded, color: accent, size: 26),
          ),
        ],
      ),
    );
  }
}

// ── Quran reader screen ───────────────────────────────────────────────────────

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
        searchHintStyle: TextStyle(
          color: sub,
          fontFamily: AppTheme.arabicUIFont,
        ),
        searchTextStyle: TextStyle(
          color: text,
          fontFamily: AppTheme.arabicUIFont,
        ),
        resultsDividerColor: divider,
      ),

      // ── Bookmarks tab ─────────────────────────────────────────────────────
      bookmarksTabStyle:
          BookmarksTabStyle.defaults(isDark: isDark, context: context).copyWith(
            textColor: text,
            subtitleTextColor: sub,
            emptyStateIconColor: accent.withValues(alpha: 0.4),
            emptyStateTextColor: sub,
          ),

      // ── Ayah long-press menu ──────────────────────────────────────────────
      ayahMenuStyle: AyahMenuStyle(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
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
      surahNameStyle: SurahNameStyle(surahNameColor: accent, surahNameSize: 22),

      // ── Surah info bottom sheet ───────────────────────────────────────────
      surahInfoStyle: SurahInfoStyle(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
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
      bannerStyle: BannerStyle(svgBannerColor: accent),

      // ── Basmala ───────────────────────────────────────────────────────────
      basmalaStyle: BasmalaStyle(basmalaColor: accent, basmalaFontSize: 22),

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
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        ayahTextColor: text,
        tafsirTextColor: text,
        tafsirBackgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        dividerColor: divider,
        readMoreButtonColor: accent,
        readMoreTextStyle: TextStyle(
          color: accent,
          fontFamily: AppTheme.arabicUIFont,
        ),
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
