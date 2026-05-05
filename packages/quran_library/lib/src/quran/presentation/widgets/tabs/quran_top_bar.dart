part of '/quran.dart';

class _QuranTopBar extends StatelessWidget {
  final String languageCode;
  final bool isDark;
  final SurahAudioStyle? style;
  final bool? isFontsLocal;
  final DownloadFontsDialogStyle? downloadFontsDialogStyle;
  final Color? backgroundColor;
  final bool? isSingleSurah;
  final bool? isPagesView;

  const _QuranTopBar(
    this.languageCode,
    this.isDark, {
    this.style,
    this.isFontsLocal,
    this.downloadFontsDialogStyle,
    this.backgroundColor,
    this.isSingleSurah = false,
    this.isPagesView = false,
  });

  @override
  Widget build(BuildContext context) {
    // Centralized theming (read from theme or fallback to defaults)
    final QuranTopBarStyle defaults = QuranTopBarTheme.of(context)?.style ??
        QuranTopBarStyle.defaults(isDark: isDark, context: context);

    final TajweedMenuStyle tajweedStyle = TajweedMenuTheme.of(context)?.style ??
        TajweedMenuStyle.defaults(isDark: isDark, context: context);
    final Color bgColor = backgroundColor ??
        (defaults.backgroundColor ?? AppColors.getBackgroundColor(isDark));

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: defaults.height ?? 55,
        padding:
            defaults.padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(defaults.borderRadius ?? 12),
          boxShadow: [
            BoxShadow(
              color:
                  (defaults.shadowColor ?? Colors.black.withValues(alpha: .2)),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            if (defaults.showBackButton ?? false)
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: defaults.iconSize,
                  color: defaults.iconColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            if (defaults.showMenuButton ?? true)
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  size: defaults.iconSize,
                  color: defaults.iconColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  QuranCtrl.instance.searchFocusNode.requestFocus();
                  _showMenuBottomSheet(context, defaults);
                },
              ),
            if ((defaults.showMenuButton ?? true) &&
                (QuranCtrl.instance.state.fontsSelected.value == 0))
              IconButton(
                icon: Icon(
                  Icons.color_lens_rounded,
                  size: defaults.iconSize,
                  color: defaults.iconColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  _showDialog(context, tajweedStyle);
                },
              ),
            const Spacer(),
            if (defaults.customTopBarWidgets != null)
              ...defaults.customTopBarWidgets!,
            const Spacer(),
            Row(
              children: [
                if (defaults.showAutoScrollButton ?? true)
                  Obx(() {
                    final isAutoScrollActive =
                        AutoScrollCtrl.instance.state.isActive.value;
                    return QuranCtrl.instance.state.displayMode.value ==
                            QuranDisplayMode.defaultMode
                        ? IconButton(
                            icon: Icon(
                              Icons.move_down_rounded,
                              size: defaults.iconSize,
                              color: isAutoScrollActive
                                  ? (defaults.iconColor ??
                                      Theme.of(context).colorScheme.primary)
                                  : (defaults.iconColor ??
                                          Theme.of(context).colorScheme.primary)
                                      .withValues(alpha: 0.5),
                            ),
                            onPressed: () {
                              final ctrl = AutoScrollCtrl.instance;
                              if (ctrl.state.isActive.value) {
                                ctrl.stopAutoScroll();
                              } else {
                                final currentPage = QuranCtrl
                                    .instance.state.currentPageNumber.value;
                                ctrl.startAutoScroll(currentPage);
                              }
                            },
                          )
                        : const SizedBox.shrink();
                  }),
                if (defaults.showAudioButton ?? true)
                  IconButton(
                    icon: Icon(
                      Icons.library_music_rounded,
                      size: defaults.iconSize,
                      color: defaults.iconColor ??
                          Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async {
                      await AudioCtrl.instance.state.audioPlayer.stop();
                      QuranCtrl.instance.state.isShowMenu.value = false;
                      // await AudioCtrl.instance.lastAudioSource();
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SurahAudioScreen(
                              isDark: isDark,
                              style: style ??
                                  SurahAudioStyle.defaults(
                                      isDark: isDark, context: context),
                              languageCode: languageCode,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                if ((defaults.showFontsButton ?? true) && (!isSingleSurah!) ||
                    (isPagesView!))
                  FontsDownloadDialog(
                    downloadFontsDialogStyle: downloadFontsDialogStyle ??
                        DownloadFontsDialogStyle.defaults(isDark, context),
                    languageCode: languageCode,
                    isFontsLocal: isFontsLocal,
                    isDark: isDark,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, TajweedMenuStyle defaults) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: backgroundColor ??
            defaults.backgroundColor ??
            AppColors.getBackgroundColor(isDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaults.borderRadius ?? 16),
        ),
        contentPadding: EdgeInsets.zero,
        content: TajweedMenuWidget(isDark: isDark, languageCode: languageCode),
      ),
    );
  }

  void _showMenuBottomSheet(BuildContext context, QuranTopBarStyle defaults) {
    // التقط الأنماط من الـ Theme قبل الدخول لحدود bottom sheet
    final indexTabStyle = IndexTabTheme.of(context)?.style ??
        IndexTabStyle.defaults(isDark: isDark, context: context);
    final searchTabStyle = SearchTabTheme.of(context)?.style ??
        SearchTabStyle.defaults(isDark: isDark, context: context);
    final bookmarksTabStyle = BookmarksTabTheme.of(context)?.style ??
        BookmarksTabStyle.defaults(isDark: isDark, context: context);

    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor ??
          defaults.backgroundColor ??
          AppColors.getBackgroundColor(isDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(defaults.borderRadius ?? 20)),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: UiHelper.currentOrientation(
            double.infinity, MediaQuery.sizeOf(context).width * 0.5, context),
      ),
      builder: (ctx) => _MenuBottomSheet(
        isDark: isDark,
        languageCode: languageCode,
        backgroundColor: backgroundColor,
        style: defaults,
        indexTabStyle: indexTabStyle,
        searchTabStyle: searchTabStyle,
        bookmarksTabStyle: bookmarksTabStyle,
        isSingleSurah: isSingleSurah!,
      ),
    );
  }
}

// BottomSheet container with main TabBar
class _MenuBottomSheet extends StatelessWidget {
  final bool isDark;
  final String languageCode;
  final Color? backgroundColor;
  final QuranTopBarStyle style;
  final IndexTabStyle indexTabStyle;
  final SearchTabStyle searchTabStyle;
  final BookmarksTabStyle bookmarksTabStyle;
  final bool isSingleSurah;

  const _MenuBottomSheet({
    required this.isDark,
    required this.languageCode,
    this.backgroundColor,
    required this.style,
    required this.indexTabStyle,
    required this.searchTabStyle,
    required this.bookmarksTabStyle,
    this.isSingleSurah = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = style.textColor ?? AppColors.getTextColor(isDark);
    final Color accentColor =
        style.accentColor ?? Theme.of(context).colorScheme.primary;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color tabBgColor = style.accentColor != null
        ? accentColor.withValues(alpha: 0.1)
        : scheme.surfaceContainerLow;
    final Color indicatorColor = style.accentColor != null
        ? accentColor.withValues(alpha: 0.2)
        : scheme.primaryContainer;
    final Color selectedLabelColor =
        style.accentColor ?? scheme.onPrimaryContainer;
    final Color unselectedLabelColor = scheme.onSurfaceVariant;

    return DefaultTabController(
      length: isSingleSurah ? 2 : 3,
      child: SafeArea(
        top: false,
        child: Container(
          height: UiHelper.currentOrientation(
              MediaQuery.of(context).size.height * 0.8,
              MediaQuery.of(context).size.height * .9,
              context),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Drag handle + header
              Container(
                width: 44,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color:
                      (style.handleColor ?? textColor.withValues(alpha: 0.25)),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: Material(
                  color: tabBgColor,
                  borderRadius: BorderRadius.circular(12),
                  child: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorPadding:
                        style.indicatorPadding ?? const EdgeInsets.all(4),
                    padding: EdgeInsets.zero,
                    labelColor: selectedLabelColor,
                    unselectedLabelColor: unselectedLabelColor,
                    indicatorColor: indicatorColor,
                    indicatorWeight: .5,
                    labelStyle: QuranLibrary().cairoStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w700, height: 1.3),
                    unselectedLabelStyle:
                        QuranLibrary().cairoStyle.copyWith(fontSize: 15),
                    tabs: [
                      if (!isSingleSurah)
                        Tab(
                            text: style.tabIndexLabel ??
                                QuranLocalizations.of(context).tabIndex),
                      Tab(
                          text: style.tabSearchLabel ??
                              QuranLocalizations.of(context).tabSearch),
                      Tab(
                          text: style.tabBookmarksLabel ??
                              QuranLocalizations.of(context).tabBookmarks),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: TabBarView(
                  children: [
                    if (!isSingleSurah)
                      _IndexTab(
                        isDark: isDark,
                        languageCode: languageCode,
                        style: indexTabStyle,
                      ),
                    _SearchTab(
                      isDark: isDark,
                      languageCode: languageCode,
                      style: searchTabStyle,
                    ),
                    _BookmarksTab(
                      isDark: isDark,
                      languageCode: languageCode,
                      style: bookmarksTabStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
