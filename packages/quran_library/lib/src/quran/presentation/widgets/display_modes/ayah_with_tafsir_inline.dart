part of '/quran.dart';

/// وضع عرض آيات الصفحة مع تفسير كل آية (عمودي وأفقي)
class AyahWithTafsirInline extends StatelessWidget {
  const AyahWithTafsirInline({
    super.key,
    required this.quranCtrl,
    required this.isDark,
    required this.languageCode,
    required this.onPageChanged,
    required this.onPagePress,
    required this.parentContext,
    this.style,
    this.bannerStyle,
    this.surahNameStyle,
    this.onSurahBannerPress,
    this.basmalaStyle,
    this.audioStyle,
    this.ayahDownloadManagerStyle,
    this.ayahBookmarked,
    this.isAyahBookmarked,
    this.showAyahBookmarkedIcon = true,
    this.bookmarksColor,
    this.customBookmarksColor,
    this.usePageView = true,
    this.withOptionsBar = true,
    this.showAyahNumber = false,
  });

  final QuranCtrl quranCtrl;
  final bool isDark;
  final String languageCode;
  final Function(int pageNumber)? onPageChanged;
  final VoidCallback? onPagePress;
  final BuildContext parentContext;
  final AyahTafsirInlineStyle? style;
  final BannerStyle? bannerStyle;
  final SurahNameStyle? surahNameStyle;
  final Function(SurahNamesModel surah)? onSurahBannerPress;
  final BasmalaStyle? basmalaStyle;
  final AyahAudioStyle? audioStyle;
  final AyahDownloadManagerStyle? ayahDownloadManagerStyle;
  final List<int>? ayahBookmarked;
  final bool Function(AyahModel ayah)? isAyahBookmarked;
  final bool showAyahBookmarkedIcon;
  final Color? bookmarksColor;
  final Color? Function(AyahModel)? customBookmarksColor;
  final bool usePageView;
  final bool? withOptionsBar;
  final bool? showAyahNumber;

  @override
  Widget build(BuildContext context) {
    final s = style ??
        (AyahTafsirInlineTheme.of(context)?.style ??
            AyahTafsirInlineStyle.defaults(isDark: isDark, context: context));

    if (!usePageView) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          final currentPage = quranCtrl.state.currentPageNumber.value;
          final pageIndex = (currentPage - 1).clamp(0, 603);
          return _AyahTafsirInlinePage(
            key: ValueKey('inline_page_$pageIndex'),
            pageIndex: pageIndex,
            isDark: isDark,
            style: s,
            languageCode: languageCode,
            bannerStyle: bannerStyle,
            surahNameStyle: surahNameStyle,
            onSurahBannerPress: onSurahBannerPress,
            basmalaStyle: basmalaStyle,
            audioStyle: audioStyle,
            ayahDownloadManagerStyle: ayahDownloadManagerStyle,
            ayahBookmarked: ayahBookmarked ?? const [],
            isAyahBookmarked: isAyahBookmarked,
            showAyahBookmarkedIcon: showAyahBookmarkedIcon,
            bookmarksColor: bookmarksColor,
            customBookmarksColor: customBookmarksColor,
            withOptionsBar: withOptionsBar,
            showAyahNumber: showAyahNumber,
          );
        }),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PatchedPreloadPageView.builder(
        preloadPagesCount: 1,
        padEnds: false,
        itemCount: 604,
        controller: quranCtrl.getPageController(context),
        physics: const ClampingScrollPhysics(),
        onPageChanged: (pageIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            if (onPageChanged != null) onPageChanged!(pageIndex);
            quranCtrl.state.currentPageNumber.value = pageIndex + 1;
            quranCtrl.saveLastPage(pageIndex + 1);
          });
        },
        pageSnapping: true,
        itemBuilder: (ctx, index) => InkWell(
          onTap: () {
            if (onPagePress != null) {
              onPagePress!();
            } else {
              quranCtrl.showControlToggle();
              QuranCtrl.instance.state.isShowMenu.value = false;
            }
          },
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: _AyahTafsirInlinePage(
            pageIndex: index,
            isDark: isDark,
            style: s,
            languageCode: languageCode,
            bannerStyle: bannerStyle,
            surahNameStyle: surahNameStyle,
            onSurahBannerPress: onSurahBannerPress,
            basmalaStyle: basmalaStyle,
            audioStyle: audioStyle,
            ayahDownloadManagerStyle: ayahDownloadManagerStyle,
            ayahBookmarked: ayahBookmarked ?? const [],
            isAyahBookmarked: isAyahBookmarked,
            showAyahBookmarkedIcon: showAyahBookmarkedIcon,
            bookmarksColor: bookmarksColor,
            customBookmarksColor: customBookmarksColor,
            withOptionsBar: withOptionsBar,
            showAyahNumber: showAyahNumber,
          ),
        ),
      ),
    );
  }
}

/// صفحة واحدة في وضع الآية مع التفسير
class _AyahTafsirInlinePage extends StatefulWidget {
  const _AyahTafsirInlinePage({
    super.key,
    required this.pageIndex,
    required this.isDark,
    required this.style,
    required this.languageCode,
    this.bannerStyle,
    this.surahNameStyle,
    this.onSurahBannerPress,
    this.basmalaStyle,
    this.audioStyle,
    this.ayahDownloadManagerStyle,
    required this.ayahBookmarked,
    this.isAyahBookmarked,
    this.showAyahBookmarkedIcon = true,
    this.bookmarksColor,
    this.customBookmarksColor,
    this.withOptionsBar = true,
    this.showAyahNumber = false,
  });

  final int pageIndex;
  final bool isDark;
  final AyahTafsirInlineStyle style;
  final String languageCode;
  final BannerStyle? bannerStyle;
  final SurahNameStyle? surahNameStyle;
  final Function(SurahNamesModel surah)? onSurahBannerPress;
  final BasmalaStyle? basmalaStyle;
  final AyahAudioStyle? audioStyle;
  final AyahDownloadManagerStyle? ayahDownloadManagerStyle;
  final List<int> ayahBookmarked;
  final bool Function(AyahModel ayah)? isAyahBookmarked;
  final bool showAyahBookmarkedIcon;
  final Color? bookmarksColor;
  final Color? Function(AyahModel)? customBookmarksColor;
  final bool? withOptionsBar;
  final bool? showAyahNumber;

  @override
  State<_AyahTafsirInlinePage> createState() => _AyahTafsirInlinePageState();
}

class _AyahTafsirInlinePageState extends State<_AyahTafsirInlinePage>
    with AutomaticKeepAliveClientMixin {
  late Future<void> _tafsirFuture;
  late int _lastRadioValue;
  bool _lastIsDark = false;

  final ScrollController _scrollController = ScrollController();
  Worker? _audioWorker;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _lastRadioValue = TafsirCtrl.instance.radioValue.value;
    _lastIsDark = widget.isDark;
    _tafsirFuture = _loadTafsir(widget.pageIndex + 1);
    _setupAudioScrollWorker();
  }

  void _setupAudioScrollWorker() {
    final audioState = AudioCtrl.instance.state;
    _audioWorker = ever(audioState.currentAyahUniqueNumber, (int uqNumber) {
      if (!mounted) return;
      final pageAyahs =
          QuranCtrl.instance.getPageAyahsByIndex(widget.pageIndex);
      final index = pageAyahs.indexWhere((a) => a.ayahUQNumber == uqNumber);
      if (index == -1) return;
      // Estimate scroll offset; the list will clamp at maxScrollExtent.
      const estimatedItemHeight = 280.0;
      final targetOffset = index * estimatedItemHeight;
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rebuild when the theme brightness changes so children get fresh colors.
    final currentIsDark = Theme.of(context).brightness == Brightness.dark;
    if (currentIsDark != _lastIsDark) {
      _lastIsDark = currentIsDark;
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant _AyahTafsirInlinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentRadio = TafsirCtrl.instance.radioValue.value;
    if (oldWidget.pageIndex != widget.pageIndex ||
        _lastRadioValue != currentRadio) {
      final sourceChanged = _lastRadioValue != currentRadio;
      _lastRadioValue = currentRadio;
      _tafsirFuture =
          _loadTafsir(widget.pageIndex + 1, forceReload: sourceChanged);
    }
    if (widget.isDark != _lastIsDark) {
      _lastIsDark = widget.isDark;
    }
  }

  @override
  void dispose() {
    _audioWorker?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadTafsir(int pageNumber, {bool forceReload = false}) async {
    final tafsirCtrl = TafsirCtrl.instance;
    if (tafsirCtrl.selectedTafsir.isTafsir) {
      if (forceReload || tafsirCtrl.tafseerList.isEmpty) {
        await tafsirCtrl.fetchData(pageNumber);
      }
    } else {
      if (forceReload || tafsirCtrl.translationList.isEmpty) {
        await tafsirCtrl.fetchTranslate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final quranCtrl = QuranCtrl.instance;

    return FutureBuilder<void>(
      future: _tafsirFuture,
      builder: (context, snapshot) {
        final pageAyahs = quranCtrl.getPageAyahsByIndex(widget.pageIndex);
        if (pageAyahs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            widget.style.headerWidget ??
                _InlineTafsirHeader(
                  isDark: widget.isDark,
                  style: widget.style,
                  languageCode: widget.languageCode,
                ),
            Expanded(
              child: GetBuilder<TafsirCtrl>(
                id: 'change_font_size',
                builder: (ctrl) {
                  final isTafsir = ctrl.selectedTafsir.isTafsir;
                  final language = ctrl
                      .tafsirAndTranslationsItems[ctrl.radioValue.value].name;

                  final tafsirMap = <int, TafsirTableData>{};
                  if (isTafsir) {
                    for (final t in ctrl.tafseerList) {
                      tafsirMap[t.id] = t;
                    }
                  }

                  final translationMap = <String, TranslationModel>{};
                  if (!isTafsir) {
                    for (final t in ctrl.translationList) {
                      translationMap['${t.surahNumber}:${t.ayahNumber}'] = t;
                    }
                  }

                  return GetBuilder<BookmarksCtrl>(
                    id: 'bookmarks',
                    builder: (bookmarksCtrl) {
                      final bookmarksSet = bookmarksCtrl.bookmarksAyahsSet;
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: pageAyahs.length,
                        addAutomaticKeepAlives: true,
                        cacheExtent: 600,
                        itemBuilder: (context, index) {
                          final ayah = pageAyahs[index];
                          final tafsir = isTafsir
                              ? (tafsirMap[ayah.ayahUQNumber] ??
                                  const TafsirTableData(
                                    id: 0,
                                    tafsirText: '',
                                    ayahNum: 0,
                                    pageNum: 0,
                                    surahNum: 0,
                                  ))
                              : const TafsirTableData(
                                  id: 0,
                                  tafsirText: '',
                                  ayahNum: 0,
                                  pageNum: 0,
                                  surahNum: 0,
                                );

                          final translation = !isTafsir
                              ? translationMap[
                                  '${ayah.surahNumber}:${ayah.ayahNumber}']
                              : null;

                          final surahNum = ayah.surahNumber ?? 0;
                          final surah = (surahNum > 0 &&
                                  surahNum <= quranCtrl.surahs.length)
                              ? quranCtrl.surahs[surahNum - 1]
                              : quranCtrl
                                  .getCurrentSurahByPageNumber(ayah.page);

                          return RepaintBoundary(
                            child: _InlineAyahTafsirItem(
                              ayah: ayah,
                              tafsir: tafsir,
                              surah: surah,
                              isDark: widget.isDark,
                              style: widget.style,
                              tafsirCtrl: ctrl,
                              pageIndex: widget.pageIndex,
                              languageCode: widget.languageCode,
                              bannerStyle: widget.bannerStyle,
                              surahNameStyle: widget.surahNameStyle,
                              onSurahBannerPress: widget.onSurahBannerPress,
                              basmalaStyle: widget.basmalaStyle,
                              audioStyle: widget.audioStyle,
                              ayahDownloadManagerStyle:
                                  widget.ayahDownloadManagerStyle,
                              ayahBookmarked: widget.ayahBookmarked,
                              isAyahBookmarked: widget.isAyahBookmarked,
                              showAyahBookmarkedIcon:
                                  widget.showAyahBookmarkedIcon,
                              bookmarksColor: widget.bookmarksColor,
                              customBookmarksColor: widget.customBookmarksColor,
                              withOptionsBar: widget.withOptionsBar,
                              showAyahNumber: widget.showAyahNumber,
                              translation: translation,
                              bookmarksSet: bookmarksSet,
                              language: language,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

/// شريط تغيير التفسير العلوي لوضع الآية مع التفسير
class _InlineTafsirHeader extends StatelessWidget {
  const _InlineTafsirHeader({
    required this.isDark,
    required this.style,
    required this.languageCode,
  });

  final bool isDark;
  final AyahTafsirInlineStyle style;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: style.backgroundColor ?? AppColors.getBackgroundColor(isDark),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(
            width: 5,
            color: style.dividerColor ?? Colors.teal,
          ),
        ),
      ),
      child: Row(
        children: [
          GetBuilder<TafsirCtrl>(
              id: 'actualTafsirContent',
              builder: (_) => ChangeTafsirDialog(
                  tafsirStyle: TafsirTheme.of(context)?.style ??
                      TafsirStyle.defaults(isDark: isDark, context: context),
                  isDark: isDark)),
          const Spacer(),
          style.fontSizeWidget ??
              fontSizeDropDown(
                height: 30.0,
                tafsirStyle: TafsirTheme.of(context)?.style ??
                    TafsirStyle.defaults(isDark: isDark, context: context),
                isDark: isDark,
              ),
        ],
      ),
    );
  }
}

/// عنصر آية واحدة مع التفسير في وضع العرض المدمج
class _InlineAyahTafsirItem extends StatefulWidget {
  const _InlineAyahTafsirItem({
    required this.ayah,
    required this.tafsir,
    required this.surah,
    required this.isDark,
    required this.style,
    required this.tafsirCtrl,
    required this.pageIndex,
    required this.languageCode,
    this.bannerStyle,
    this.surahNameStyle,
    this.onSurahBannerPress,
    this.basmalaStyle,
    this.audioStyle,
    this.ayahDownloadManagerStyle,
    required this.ayahBookmarked,
    this.isAyahBookmarked,
    this.showAyahBookmarkedIcon = true,
    this.bookmarksColor,
    this.customBookmarksColor,
    this.withOptionsBar = true,
    this.showAyahNumber = false,
    this.translation,
    required this.bookmarksSet,
    required this.language,
  });

  final AyahModel ayah;
  final TafsirTableData tafsir;
  final SurahModel surah;
  final bool isDark;
  final AyahTafsirInlineStyle style;
  final TafsirCtrl tafsirCtrl;
  final int pageIndex;
  final String languageCode;
  final BannerStyle? bannerStyle;
  final SurahNameStyle? surahNameStyle;
  final Function(SurahNamesModel surah)? onSurahBannerPress;
  final BasmalaStyle? basmalaStyle;
  final AyahAudioStyle? audioStyle;
  final AyahDownloadManagerStyle? ayahDownloadManagerStyle;
  final List<int> ayahBookmarked;
  final bool Function(AyahModel ayah)? isAyahBookmarked;
  final bool showAyahBookmarkedIcon;
  final Color? bookmarksColor;
  final Color? Function(AyahModel)? customBookmarksColor;
  final bool? withOptionsBar;
  final bool? showAyahNumber;
  final TranslationModel? translation;
  final Set<int> bookmarksSet;
  final String language;

  @override
  State<_InlineAyahTafsirItem> createState() => _InlineAyahTafsirItemState();
}

class _InlineAyahTafsirItemState extends State<_InlineAyahTafsirItem> {
  bool _actionsVisible = false;

  @override
  Widget build(BuildContext context) {
    final effectiveDark = Theme.of(context).brightness == Brightness.dark;
    final isTafsir = widget.tafsirCtrl.selectedTafsir.isTafsir;
    final fontSize = widget.tafsirCtrl.fontSizeArabic.value;

    // Recompute defaults from the live theme so colors always reflect current
    // brightness, even when the passed style was baked with a different isDark.
    final liveDefaults =
        AyahTafsirInlineStyle.defaults(isDark: effectiveDark, context: context);
    final s = liveDefaults.copyWith(
      backgroundColor: widget.style.backgroundColor,
      ayahTextColor: widget.style.ayahTextColor,
      tafsirTextColor: widget.style.tafsirTextColor,
      tafsirBackgroundColor: widget.style.tafsirBackgroundColor,
      dividerColor: widget.style.dividerColor,
      dividerThickness: widget.style.dividerThickness,
      tafsirMaxLines: widget.style.tafsirMaxLines,
      tafsirCollapsedHeight: widget.style.tafsirCollapsedHeight,
      readMoreText: widget.style.readMoreText,
      readLessText: widget.style.readLessText,
      readMoreButtonColor: widget.style.readMoreButtonColor,
      readMoreTextStyle: widget.style.readMoreTextStyle,
      ayahPadding: widget.style.ayahPadding,
      tafsirPadding: widget.style.tafsirPadding,
      ayahNumberColor: widget.style.ayahNumberColor,
      tafsirSelectorBarColor: widget.style.tafsirSelectorBarColor,
      tafsirSelectorTextColor: widget.style.tafsirSelectorTextColor,
      fontSizeIconColor: widget.style.fontSizeIconColor,
      fontSizeWidget: widget.style.fontSizeWidget,
      headerWidget: widget.style.headerWidget,
      optionsBarWidget: widget.style.optionsBarWidget,
      playIconData: widget.style.playIconData,
      playIconColor: widget.style.playIconColor,
      iconSize: widget.style.iconSize,
      playAllIconData: widget.style.playAllIconData,
      playAllIconColor: widget.style.playAllIconColor,
      copyIconData: widget.style.copyIconData,
      copyIconColor: widget.style.copyIconColor,
      bookmarkColorCodes: widget.style.bookmarkColorCodes,
      iconHorizontalPadding: widget.style.iconHorizontalPadding,
      bookmarkIconData: widget.style.bookmarkIconData,
      tafsirBackgroundBorderRadius: widget.style.tafsirBackgroundBorderRadius,
    );

    final sAudio = widget.audioStyle ??
        AyahAudioStyle.defaults(isDark: effectiveDark, context: context);
    final sDownloadManager = widget.ayahDownloadManagerStyle ??
        AyahDownloadManagerStyle.defaults(
            isDark: effectiveDark, context: context);

    final colors =
        s.bookmarkColorCodes ?? const [0xAAFFD354, 0xAAF36077, 0xAA00CD00];

    final primaryColor = Theme.of(context).colorScheme.primary;

    // Obx reacts to audio state changes without rebuilding the whole page.
    return Obx(() {
      final isPlaying = AudioCtrl.instance.state.isPlaying.value;
      final playingUq = AudioCtrl.instance.state.currentAyahUniqueNumber.value;
      final isCurrentAyah = isPlaying && playingUq == widget.ayah.ayahUQNumber;

      return GestureDetector(
        onTap: () {
          if (widget.withOptionsBar == true) {
            setState(() => _actionsVisible = !_actionsVisible);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: s.ayahPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isCurrentAyah
                ? primaryColor.withValues(alpha: .12)
                : s.backgroundColor ??
                    AppColors.getBackgroundColor(effectiveDark),
            border: Border(
              bottom: BorderSide(
                color: s.dividerColor ??
                    (effectiveDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade300),
                width: s.dividerThickness ?? 1.0,
              ),
              right: isCurrentAyah
                  ? BorderSide(color: primaryColor, width: 4)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.ayah.ayahNumber == 1)
                SurahHeaderWidget(
                  widget.surah.surahNumber,
                  bannerStyle: widget.bannerStyle ??
                      BannerStyle().copyWith(bannerSvgHeight: 35.w),
                  surahNameStyle: widget.surahNameStyle ??
                      SurahNameStyle(
                        surahNameSize: 35.w,
                        surahNameColor: AppColors.getTextColor(effectiveDark),
                      ),
                  onSurahBannerPress: widget.onSurahBannerPress,
                  isDark: effectiveDark,
                ),
              if (widget.ayah.ayahNumber == 1 &&
                  widget.surah.surahNumber != 9 &&
                  widget.surah.surahNumber != 1)
                BasmallahWidget(
                  surahNumber: widget.surah.surahNumber,
                  basmalaStyle: widget.basmalaStyle ??
                      BasmalaStyle(
                        basmalaColor: AppColors.getTextColor(effectiveDark),
                        basmalaFontSize: 23.0.w,
                        verticalPadding: 0.0,
                      ),
                ),
              // Ayah text — always visible
              GetSingleAyah(
                surahNumber: widget.surah.surahNumber,
                ayahNumber: widget.ayah.ayahNumber,
                fontSize: fontSize,
                isBold: false,
                ayahs: widget.ayah,
                isSingleAyah: false,
                showAyahNumber: true,
                isDark: effectiveDark,
                pageIndex: widget.pageIndex + 1,
                textColor: s.ayahTextColor,
                textAlign: TextAlign.center,
                enabledTajweed: QuranCtrl.instance.state.isTajweedEnabled.value,
              ),
              // Actions bar — shown only when the ayah is tapped
              if (widget.withOptionsBar == true && _actionsVisible)
                (s.optionsBarWidget
                        ?.call(widget.ayah, widget.surah, widget.pageIndex)) ??
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: s.optionsBarBackgroundColor ??
                            primaryColor.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AudioCtrl.instance.playAyah(
                                context,
                                widget.ayah.ayahUQNumber,
                                playSingleAyah: true,
                                ayahAudioStyle: sAudio,
                                ayahDownloadManagerStyle: sDownloadManager,
                                isDarkMode: effectiveDark,
                              );
                              log('Second Menu Child Tapped: ${widget.ayah.ayahUQNumber}');
                            },
                            child: Icon(s.playIconData,
                                color: s.playIconColor, size: s.iconSize),
                          ),
                          SizedBox(width: s.iconHorizontalPadding ?? 4.0),
                          GestureDetector(
                            onTap: () {
                              AudioCtrl.instance.playAyah(
                                context,
                                widget.ayah.ayahUQNumber,
                                playSingleAyah: false,
                                ayahAudioStyle: sAudio,
                                ayahDownloadManagerStyle: sDownloadManager,
                                isDarkMode: effectiveDark,
                              );
                              log('Second Menu Child Tapped: ${widget.ayah.ayahUQNumber}');
                            },
                            child: Icon(s.playAllIconData,
                                color: s.playAllIconColor, size: s.iconSize),
                          ),
                          SizedBox(width: s.iconHorizontalPadding ?? 4.0),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.ayah.text));
                            },
                            child: Icon(s.copyIconData,
                                color: s.copyIconColor, size: s.iconSize),
                          ),
                          SizedBox(width: s.iconHorizontalPadding ?? 4.0),
                          for (final colorCode in colors) ...{
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: s.iconHorizontalPadding ?? 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  final bmCtrl = BookmarksCtrl.instance;
                                  final existing = bmCtrl.bookmarks[colorCode]
                                      ?.cast<BookmarkModel?>()
                                      .firstWhere(
                                        (b) =>
                                            b!.ayahId ==
                                            widget.ayah.ayahUQNumber,
                                        orElse: () => null,
                                      );
                                  if (existing != null) {
                                    bmCtrl.removeBookmark(existing.id);
                                  } else {
                                    bmCtrl.saveBookmark(
                                      surahName: widget.surah.arabicName,
                                      ayahNumber: widget.ayah.ayahNumber,
                                      ayahId: widget.ayah.ayahUQNumber,
                                      page: widget.ayah.page,
                                      colorCode: colorCode,
                                    );
                                  }
                                },
                                child: Icon(s.bookmarkIconData,
                                    color: Color(colorCode), size: s.iconSize),
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
              const SizedBox(height: 10),
              // Tafsir / translation
              Container(
                width: double.infinity,
                padding: s.tafsirPadding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: s.tafsirBackgroundColor ??
                      (effectiveDark
                          ? Colors.grey.shade900.withValues(alpha: .5)
                          : Colors.grey.shade100.withValues(alpha: .7)),
                  borderRadius: BorderRadius.circular(
                      s.tafsirBackgroundBorderRadius ?? 12.0),
                ),
                child: _buildTafsirContent(
                  context: context,
                  isTafsir: isTafsir,
                  fontSize: fontSize,
                  effectiveDark: effectiveDark,
                  resolvedStyle: s,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTafsirContent({
    required BuildContext context,
    required bool isTafsir,
    required double fontSize,
    required bool effectiveDark,
    required AyahTafsirInlineStyle resolvedStyle,
  }) {
    final rawText =
        isTafsir ? widget.tafsir.tafsirText : widget.translation?.text;
    final hasContent = rawText != null && rawText.isNotEmpty;

    if (!hasContent) {
      return Text(
        QuranLocalizations.of(context).noTafsirAvailable,
        style: TextStyle(
          color: effectiveDark ? Colors.grey.shade400 : Colors.grey.shade600,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    final textColor = resolvedStyle.tafsirTextColor ??
        (effectiveDark ? Colors.grey.shade300 : Colors.grey.shade800);

    return _ExpandableTafsirText(
      rawText: rawText,
      isDark: effectiveDark,
      fontSize: fontSize,
      textColor: textColor,
      textDirection: context.alignmentLayoutWPassLang(
          widget.language, TextDirection.rtl, TextDirection.ltr),
      maxLines: resolvedStyle.tafsirMaxLines ?? 4,
      readMoreText:
          resolvedStyle.readMoreText ?? QuranLocalizations.of(context).readMore,
      readLessText:
          resolvedStyle.readLessText ?? QuranLocalizations.of(context).readLess,
      readMoreButtonColor: resolvedStyle.readMoreButtonColor,
      readMoreTextStyle: resolvedStyle.readMoreTextStyle,
      translation: !isTafsir ? widget.translation : null,
    );
  }
}

/// ويدجت عرض التفسير/الترجمة بأداء عالي
class _ExpandableTafsirText extends StatefulWidget {
  const _ExpandableTafsirText({
    required this.rawText,
    required this.isDark,
    required this.fontSize,
    required this.textColor,
    required this.textDirection,
    this.maxLines = 4,
    this.readMoreText = 'اقرأ المزيد',
    this.readLessText = 'اقرأ أقل',
    this.readMoreButtonColor,
    this.readMoreTextStyle,
    this.translation,
  });

  final String rawText;
  final bool isDark;
  final double fontSize;
  final Color textColor;
  final TextDirection textDirection;
  final int maxLines;
  final String readMoreText;
  final String readLessText;
  final Color? readMoreButtonColor;
  final TextStyle? readMoreTextStyle;
  final TranslationModel? translation;

  @override
  State<_ExpandableTafsirText> createState() => _ExpandableTafsirTextState();
}

class _ExpandableTafsirTextState extends State<_ExpandableTafsirText> {
  bool _expanded = false;
  List<TextSpan>? _parsedSpans;
  String? _strippedText;

  static final _htmlTagRegex = RegExp(r'<[^>]*>');
  static final _multiSpaceRegex = RegExp(r'\s+');

  String get _stripped {
    return _strippedText ??= widget.rawText
        .replaceAll(_htmlTagRegex, ' ')
        .replaceAll(_multiSpaceRegex, ' ')
        .trim();
  }

  List<TextSpan> _getFullSpans() {
    if (_parsedSpans != null) return _parsedSpans!;
    var spans = widget.rawText
        .toFlutterText(widget.isDark)
        .map((e) => e is TextSpan ? e : const TextSpan())
        .toList()
        .cast<TextSpan>();
    if (widget.translation != null) {
      final footnotes = widget.translation!.orderedFootnotesWithNumbers;
      if (footnotes.isNotEmpty) {
        final footnoteSpans = <TextSpan>[
          const TextSpan(text: '\n\n'),
          TextSpan(
            text: QuranLocalizations.of(context).footnotesHeader,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize * 0.95,
              color: widget.textColor,
            ),
          ),
        ];
        for (final footnoteEntry in footnotes) {
          final number = footnoteEntry.key;
          final footnoteData = footnoteEntry.value;
          footnoteSpans.add(TextSpan(
            children: [
              TextSpan(
                text: '($number) ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize * 0.9,
                  color: widget.textColor,
                ),
              ),
              TextSpan(
                text: '${footnoteData.value}\n\n',
                style: TextStyle(
                  fontSize: widget.fontSize * 0.85,
                  color: widget.textColor,
                  height: 1.4,
                ),
              ),
            ],
          ));
        }
        spans = [...spans, ...footnoteSpans];
      }
    }
    _parsedSpans = spans;
    return spans;
  }

  @override
  void didUpdateWidget(covariant _ExpandableTafsirText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rawText != widget.rawText ||
        oldWidget.translation != widget.translation) {
      _parsedSpans = null;
      _strippedText = null;
      _expanded = false;
    } else if (oldWidget.isDark != widget.isDark ||
        oldWidget.textColor != widget.textColor) {
      _parsedSpans = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        widget.readMoreButtonColor ?? Theme.of(context).colorScheme.primary;
    final buttonStyle = widget.readMoreTextStyle ??
        TextStyle(
          color: buttonColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        );

    final textStyle = TextStyle(
      color: widget.textColor,
      fontSize: widget.fontSize,
      height: 1.5,
    );

    if (_expanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: _getFullSpans(), style: textStyle),
            textDirection: widget.textDirection,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.visible,
          ),
          _buildToggleButton(widget.readLessText, buttonStyle, buttonColor,
              Icons.expand_less_rounded),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _stripped,
          maxLines: widget.maxLines,
          overflow: TextOverflow.ellipsis,
          textDirection: widget.textDirection,
          textAlign: TextAlign.justify,
          style: textStyle,
        ),
        _buildToggleButton(widget.readMoreText, buttonStyle, buttonColor,
            Icons.expand_more_rounded),
      ],
    );
  }

  Widget _buildToggleButton(
    String text,
    TextStyle buttonStyle,
    Color buttonColor,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: buttonStyle),
            Icon(icon, color: buttonColor, size: 18),
          ],
        ),
      ),
    );
  }
}
