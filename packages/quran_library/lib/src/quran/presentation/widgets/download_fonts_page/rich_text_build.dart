part of '/quran.dart';

class QpcV4RichTextLine extends StatefulWidget {
  const QpcV4RichTextLine({
    super.key,
    required this.pageIndex,
    required this.textColor,
    required this.isDark,
    required this.bookmarks,
    required this.onAyahLongPress,
    required this.bookmarkList,
    required this.ayahIconColor,
    required this.showAyahBookmarkedIcon,
    required this.bookmarksAyahs,
    required this.bookmarksColor,
    this.customBookmarksColor,
    required this.ayahSelectedBackgroundColor,
    required this.context,
    required this.quranCtrl,
    required this.segments,
    required this.isFontsLocal,
    required this.fontsName,
    this.fontFamilyOverride,
    this.fontPackageOverride,
    this.usePaintColoring = true,
    required this.ayahBookmarked,
    this.isAyahBookmarked,
    required this.isCentered,
    this.onPagePress,
  });

  final int pageIndex;
  final Color? textColor;
  final bool isDark;
  final Map<int, List<BookmarkModel>> bookmarks;
  final Function(LongPressStartDetails details, AyahModel ayah)?
      onAyahLongPress;
  final List? bookmarkList;
  final Color? ayahIconColor;
  final bool showAyahBookmarkedIcon;
  final List<int> bookmarksAyahs;
  final Color? bookmarksColor;
  final Color? Function(AyahModel)? customBookmarksColor;
  final Color? ayahSelectedBackgroundColor;
  final BuildContext context;
  final QuranCtrl quranCtrl;
  final List<QpcV4WordSegment> segments;
  final bool isFontsLocal;
  final String fontsName;
  final String? fontFamilyOverride;
  final String? fontPackageOverride;
  final bool usePaintColoring;
  final List<int> ayahBookmarked;
  final bool Function(AyahModel ayah)? isAyahBookmarked;
  final bool isCentered;
  final VoidCallback? onPagePress;

  @override
  State<QpcV4RichTextLine> createState() => _QpcV4RichTextLineState();
}

class _QpcV4RichTextLineState extends State<QpcV4RichTextLine>
    with TickerProviderStateMixin {
  /// كاش الويدجت المبني — يُعاد بناؤه فقط عند تغيّر selection/bookmarks/word_info
  Widget? _cachedWidget;

  /// بصمة البيانات المؤثرة على البناء — عند تغيّرها يُبطل الكاش
  int _lastFingerprint = 0;

  late final AnimationController _highlightAnim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );
  late final Animation<double> _highlightPulse = CurvedAnimation(
    parent: _highlightAnim,
    curve: Curves.easeInOut,
  );

  /// أنيميشن الدخول — يُشغَّل عند انتقال التظليل لآية جديدة على هذا السطر.
  late final AnimationController _enterAnim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late final Animation<double> _enterScale = CurvedAnimation(
    parent: _enterAnim,
    curve: Curves.easeOutCubic,
  );

  /// الآيات المظلّلة حالياً على هذا السطر — لاكتشاف وصول تظليل جديد.
  Set<int> _lastLineUqs = {};

  /// تقدّم تشغيل الصوت للآية المحدّدة على هذا السطر (0.0–1.0، أو -1.0 إذا لم يكن نشطاً).
  /// يُستخدم مباشرة بواسطة [_AyahSelectionRenderBox] دون إعادة بناء الويدجت.
  final ValueNotifier<double> _playbackProgress = ValueNotifier<double>(-1.0);
  StreamSubscription<PackagePositionData>? _positionSub;

  void _subscribeToAudio() {
    _positionSub?.cancel();
    final audioCtrl = AudioCtrl.instance;

    // Cached per-ayah line fractions so we don't recompute on every position tick.
    int? cachedAyahUq;
    double lineStart = 0.0; // global progress at which this line starts filling
    double lineEnd = 1.0; // global progress at which this line is fully filled

    _positionSub = audioCtrl.positionDataStream.listen((data) {
      final playingUq = audioCtrl.state.currentAyahUniqueNumber.value;
      final isOnThisLine = widget.segments.any((s) => s.ayahUq == playingUq);

      if (!isOnThisLine ||
          !audioCtrl.state.isPlaying.value ||
          data.duration == Duration.zero) {
        if (_playbackProgress.value != -1.0) {
          _playbackProgress.value = -1.0;
        }
        return;
      }

      // Recompute line fractions when the playing ayah changes.
      if (cachedAyahUq != playingUq) {
        cachedAyahUq = playingUq;

        // Words of the playing ayah that are on THIS line.
        final lineWords = widget.segments
            .where((s) => s.ayahUq == playingUq)
            .map((s) => s.wordNumber)
            .toList();
        final lineFirstWord = lineWords.reduce(math.min);
        final lineLastWord = lineWords.reduce(math.max);

        // Total word count for this ayah: scan all lines of this page.
        int totalWords = lineLastWord; // fallback if we can't find more
        final pageBlocks = widget.quranCtrl
            .getQpcLayoutBlocksForPageSync(widget.pageIndex + 1);
        for (final block in pageBlocks) {
          if (block is! QpcV4AyahLineBlock) continue;
          for (final seg in block.segments) {
            if (seg.ayahUq == playingUq && seg.wordNumber > totalWords) {
              totalWords = seg.wordNumber;
            }
          }
        }

        // Each line's share is proportional to its word count.
        // lineStart = (lineFirstWord - 1) / totalWords
        // lineEnd   = lineLastWord / totalWords
        lineStart = (lineFirstWord - 1) / totalWords;
        lineEnd = lineLastWord / totalWords;
      }

      // Map global 0→1 progress into this line's 0→1 local progress.
      final globalProgress =
          (data.position.inMicroseconds / data.duration.inMicroseconds)
              .clamp(0.0, 1.0);

      double lineProgress;
      if (globalProgress <= lineStart) {
        lineProgress = 0.0;
      } else if (globalProgress >= lineEnd) {
        lineProgress = 1.0;
      } else {
        final span = lineEnd - lineStart;
        lineProgress = ((globalProgress - lineStart) / span).clamp(0.0, 1.0);
      }

      _playbackProgress.value = lineProgress;
    });
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _playbackProgress.dispose();
    _enterAnim.dispose();
    _highlightAnim.dispose();
    super.dispose();
  }

  /// حساب بصمة سريعة للبيانات التي تؤثر فعلياً على شكل الويدجت
  int _computeFingerprint() {
    final quranCtrl = widget.quranCtrl;
    // الآيات المحددة + الآيات المظللة برمجياً
    final selHash = Object.hashAll(quranCtrl.selectedAyahsByUnequeNumber);
    final extHash = Object.hashAll(quranCtrl.externallyHighlightedAyahs);
    // bookmarks المؤثرة على هذا السطر
    final bmHash = Object.hashAll(widget.bookmarksAyahs);
    final abHash = Object.hashAll(widget.ayahBookmarked);
    final overrideHash = widget.isAyahBookmarked == null
        ? 0
        : Object.hashAll(
            widget.segments.map(
              (s) => Object.hash(
                s.ayahUq,
                widget.isAyahBookmarked!(quranCtrl.getAyahByUq(s.ayahUq)),
              ),
            ),
          );
    // إعدادات العرض
    final isDarkHash = widget.isDark.hashCode;
    final tajweedHash =
        QuranCtrl.instance.state.isTajweedEnabled.value.hashCode;
    final wordSelectedHash =
        WordInfoCtrl.instance.selectedWordRef.value.hashCode;
    // حالة تبويب القراءات العشر
    final tenRecHash = WordInfoCtrl.instance.tabController.index.hashCode;
    // تغيّر بيانات القراءات (عند اكتمال prewarm)
    final recitationsRevisionHash =
        WordInfoCtrl.instance.recitationsDataRevision.hashCode;

    return Object.hash(
        selHash,
        extHash,
        bmHash,
        abHash,
        isDarkHash,
        tajweedHash,
        wordSelectedHash,
        tenRecHash,
        recitationsRevisionHash,
        overrideHash);
  }

  @override
  Widget build(BuildContext context) {
    final wordInfoCtrl = WordInfoCtrl.instance;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // GetBuilder بمعرّف خاص بالصفحة — لا يُعاد بناؤه من update() بدون id
    return GetBuilder<QuranCtrl>(
      id: 'selection_page_${widget.pageIndex}',
      builder: (_) => GetBuilder<WordInfoCtrl>(
        id: 'word_info_data',
        builder: (_) {
          // قراءة القيم داخل الـ builder حتى تعكس آخر حالة عند كل rebuild
          final withTajweed = QuranCtrl.instance.state.isTajweedEnabled.value;
          final isTenRecitations = wordInfoCtrl.isTenRecitations;

          // prewarm القراءات في خلفية
          if (isTenRecitations &&
              !withTajweed &&
              wordInfoCtrl.isKindAvailable(WordInfoKind.recitations)) {
            final surahs = widget.segments.map((s) => s.surahNumber).toSet();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              wordInfoCtrl.prewarmRecitationsSurahs(surahs);
            });
          }

          // فحص البصمة: إذا لم تتغيّر البيانات الفعلية → أعد الكاش
          final fp = _computeFingerprint();
          if (_cachedWidget != null && fp == _lastFingerprint) {
            return _cachedWidget!;
          }
          _lastFingerprint = fp;

          _cachedWidget = LayoutBuilder(
            builder: (ctx, constraints) {
              final fs = isLandscape
                  ? 100.0
                  : PageFontSizeHelper.getFontSize(
                      widget.pageIndex,
                      ctx,
                    ).h;

              return _buildRichText(
                wordInfoCtrl,
                context,
                fs,
                withTajweed: withTajweed,
                isTenRecitations: isTenRecitations,
              );
            },
          );
          return _cachedWidget!;
        },
      ),
    );
  }

  Widget _buildRichText(
    WordInfoCtrl wordInfoCtrl,
    BuildContext context,
    double fs, {
    required bool withTajweed,
    required bool isTenRecitations,
  }) {
    final bookmarksSet = widget.bookmarksAyahs.toSet();
    final ayahCharRanges = <int, TextSelection>{};
    final bookmarkCharRanges = <int, _ColoredTextRange>{};
    TextSelection? wordSelectionRange;
    int charOffset = 0;

    final bookmarksAyahsList = bookmarksSet.toList();
    final allBookmarksList =
        widget.bookmarks.values.expand((list) => list).toList();
    final ayahBookmarkedSet = widget.ayahBookmarked.toSet();

    final spans =
        List<InlineSpan>.generate(widget.segments.length, (segmentIndex) {
      final seg = widget.segments[segmentIndex];
      final uq = seg.ayahUq;
      final isSelectedCombined =
          widget.quranCtrl.selectedAyahsByUnequeNumber.contains(uq) ||
              widget.quranCtrl.externallyHighlightedAyahs.contains(uq);

      final ref = WordRef(
        surahNumber: seg.surahNumber,
        ayahNumber: seg.ayahNumber,
        wordNumber: seg.wordNumber,
      );

      final info = wordInfoCtrl.getRecitationsInfoSync(ref);
      final hasKhilaf = info?.hasKhilaf ?? false;

      final span = _qpcV4SpanSegment(
        context: context,
        pageIndex: widget.pageIndex,
        isSelected: isSelectedCombined,
        showAyahBookmarkedIcon: widget.showAyahBookmarkedIcon,
        fontSize: fs,
        ayahUQNum: uq,
        ayahNumber: seg.ayahNumber,
        glyphs: seg.glyphs,
        showAyahNumber: seg.isAyahEnd,
        wordRef: ref,
        isWordKhilaf: hasKhilaf,
        onLongPressStart: (details) {
          final ayahModel = widget.quranCtrl.getAyahByUq(uq);

          if (widget.onAyahLongPress != null) {
            widget.onAyahLongPress!(details, ayahModel);
            widget.quranCtrl.toggleAyahSelection(uq);
            widget.quranCtrl.state.isShowMenu.value = false;
            return;
          }

          int? bookmarkId;
          for (final b in allBookmarksList) {
            if (b.ayahId == uq) {
              bookmarkId = b.id;
              break;
            }
          }

          if (bookmarkId != null) {
            BookmarksCtrl.instance.removeBookmark(bookmarkId);
            return;
          }

          if (widget.quranCtrl.isMultiSelectMode.value) {
            widget.quranCtrl.toggleAyahSelectionMulti(uq);
          } else {
            widget.quranCtrl.toggleAyahSelection(uq);
          }
          widget.quranCtrl.state.isShowMenu.value = false;

          if (!context.mounted) return;
          final themedTafsirStyle = TafsirTheme.of(context)?.style;
          showAyahMenuDialog(
            context: context,
            isDark: widget.isDark,
            ayah: ayahModel,
            position: details.globalPosition,
            index: segmentIndex,
            pageIndex: widget.pageIndex,
            externalTafsirStyle: themedTafsirStyle,
          );
        },
        textColor: widget.textColor ?? (AppColors.getTextColor(widget.isDark)),
        ayahIconColor: widget.ayahIconColor,
        allBookmarksList: allBookmarksList,
        bookmarksAyahs: widget.isAyahBookmarked != null
            ? const <int>[]
            : bookmarksAyahsList,
        bookmarksColor: widget.bookmarksColor,
        ayahSelectedBackgroundColor: widget.ayahSelectedBackgroundColor,
        isAyahBookmarked: widget.isAyahBookmarked,
        isFontsLocal: widget.isFontsLocal,
        fontsName: widget.fontsName,
        fontFamilyOverride: widget.fontFamilyOverride,
        fontPackageOverride: widget.fontPackageOverride,
        usePaintColoring: widget.usePaintColoring,
        ayahBookmarked: widget.ayahBookmarked,
        isDark: widget.isDark,
        onPagePress: widget.onPagePress,
      );

      final spanStart = charOffset;
      charOffset += _countCharsInSpan(span);

      // تتبع نطاق الكلمة المحددة
      if (wordInfoCtrl.selectedWordRef.value == ref) {
        wordSelectionRange = TextSelection(
          baseOffset: spanStart,
          extentOffset: charOffset,
        );
      }

      if (isSelectedCombined) {
        if (ayahCharRanges.containsKey(uq)) {
          ayahCharRanges[uq] = TextSelection(
            baseOffset: ayahCharRanges[uq]!.baseOffset,
            extentOffset: charOffset,
          );
        } else {
          ayahCharRanges[uq] = TextSelection(
            baseOffset: spanStart,
            extentOffset: charOffset,
          );
        }
      }

      // تتبع نطاقات العلامات المرجعية (bookmarks)
      final isBookmarked = widget.isAyahBookmarked != null
          ? widget.isAyahBookmarked!(widget.quranCtrl.getAyahByUq(uq))
          : (ayahBookmarkedSet.contains(uq) || bookmarksSet.contains(uq));
      if (isBookmarked) {
        final ayah = widget.quranCtrl.getAyahByUq(uq);
        Color bmColor;
        if (widget.customBookmarksColor != null) {
          bmColor = widget.customBookmarksColor!(ayah) ??
              widget.bookmarksColor ??
              const Color(0xffCDAD80).withValues(alpha: 0.3);
        } else if (widget.isAyahBookmarked != null) {
          bmColor = widget.bookmarksColor ??
              const Color(0xffCDAD80).withValues(alpha: 0.3);
        } else if (widget.bookmarksColor != null) {
          bmColor = widget.bookmarksColor!;
        } else if (ayahBookmarkedSet.contains(uq) &&
            widget.bookmarksColor != null) {
          bmColor = widget.bookmarksColor!;
        } else {
          final bm = allBookmarksList.cast<BookmarkModel?>().firstWhere(
                (b) => b!.ayahId == uq,
                orElse: () => null,
              );
          bmColor = bm != null
              ? Color(bm.colorCode).withValues(alpha: 0.3)
              : const Color(0xffCDAD80).withValues(alpha: 0.3);
        }

        if (bookmarkCharRanges.containsKey(uq)) {
          bookmarkCharRanges[uq] = _ColoredTextRange(
            range: TextSelection(
              baseOffset: bookmarkCharRanges[uq]!.range.baseOffset,
              extentOffset: charOffset,
            ),
            color: bmColor,
          );
        } else {
          bookmarkCharRanges[uq] = _ColoredTextRange(
            range: TextSelection(
              baseOffset: spanStart,
              extentOffset: charOffset,
            ),
            color: bmColor,
          );
        }
      }

      return span;
    });

    final richText = RichText(
      textDirection: TextDirection.rtl,
      textAlign: widget.isCentered ? TextAlign.center : TextAlign.justify,
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
      text: TextSpan(children: spans),
    );

    final hasSelection = ayahCharRanges.isNotEmpty;
    final hasBookmarks = bookmarkCharRanges.isNotEmpty;
    final hasWordSelection = wordSelectionRange != null;

    if (!hasSelection && !hasBookmarks && !hasWordSelection) {
      _highlightAnim.stop();
      _lastLineUqs = {};
      _positionSub?.cancel();
      _positionSub = null;
      if (_playbackProgress.value != -1.0) _playbackProgress.value = -1.0;
      return richText;
    }

    // Fire the enter animation whenever a new ayah UQ appears on this line.
    final currentLineUqs = ayahCharRanges.keys.toSet();
    final hasNewUq = currentLineUqs.any((uq) => !_lastLineUqs.contains(uq));
    if (hasNewUq) {
      _enterAnim.forward(from: 0.0);
    }
    _lastLineUqs = currentLineUqs;

    // Start / keep running the pulse animation whenever there is something to highlight.
    if (!_highlightAnim.isAnimating) {
      _highlightAnim.repeat(reverse: true);
    }

    // Subscribe to audio progress whenever there is an ayah selection on this line.
    if (hasSelection && _positionSub == null) {
      _subscribeToAudio();
    } else if (!hasSelection) {
      _positionSub?.cancel();
      _positionSub = null;
      if (_playbackProgress.value != -1.0) _playbackProgress.value = -1.0;
    }

    return _AyahSelectionWidget(
      selectedRanges: ayahCharRanges.values.toList(),
      selectionColor: widget.ayahSelectedBackgroundColor ??
          const Color(0xffCDAD80).withValues(alpha: 0.25),
      bookmarkRanges: bookmarkCharRanges.values.toList(),
      wordSelectionRange: wordSelectionRange,
      highlightAnimation: _highlightPulse,
      enterAnimation: _enterScale,
      playbackProgressNotifier: _playbackProgress,
      child: richText,
    );
  }
}

/// يعدّ عدد الأحرف في [InlineSpan] بشكل تسلسلي (بما في ذلك [WidgetSpan] كحرف واحد).
int _countCharsInSpan(InlineSpan span) {
  if (span is TextSpan) {
    int count = span.text?.length ?? 0;
    if (span.children != null) {
      for (final child in span.children!) {
        count += _countCharsInSpan(child);
      }
    }
    return count;
  }
  if (span is WidgetSpan) {
    return 1;
  }
  return 0;
}

/// نموذج يحمل نطاق نصي مع لون مخصص.
class _ColoredTextRange {
  final TextSelection range;
  final Color color;
  const _ColoredTextRange({required this.range, required this.color});
}

/// ويدجت يرسم خلفية التحديد والعلامات المرجعية خلف النص القرآني لكل آية على حدة.
class _AyahSelectionWidget extends SingleChildRenderObjectWidget {
  final List<TextSelection> selectedRanges;
  final Color selectionColor;
  final List<_ColoredTextRange> bookmarkRanges;
  final TextSelection? wordSelectionRange;
  final Animation<double> highlightAnimation;

  /// أنيميشن الدخول عند انتقال التظليل لآية جديدة (0.0 → 1.0 مرة واحدة).
  final Animation<double> enterAnimation;

  /// تقدّم تشغيل الصوت (0.0–1.0). القيمة -1.0 تعني لا يوجد تشغيل نشط.
  final ValueNotifier<double> playbackProgressNotifier;

  const _AyahSelectionWidget({
    required this.selectedRanges,
    required this.selectionColor,
    this.bookmarkRanges = const [],
    this.wordSelectionRange,
    required this.highlightAnimation,
    required this.enterAnimation,
    required this.playbackProgressNotifier,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _AyahSelectionRenderBox(
      selectedRanges: selectedRanges,
      selectionColor: selectionColor,
      bookmarkRanges: bookmarkRanges,
      wordSelectionRange: wordSelectionRange,
      highlightAnimation: highlightAnimation,
      enterAnimation: enterAnimation,
      playbackProgressNotifier: playbackProgressNotifier,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _AyahSelectionRenderBox renderObject) {
    renderObject
      ..selectedRanges = selectedRanges
      ..selectionColor = selectionColor
      ..bookmarkRanges = bookmarkRanges
      ..wordSelectionRange = wordSelectionRange
      ..highlightAnimation = highlightAnimation
      ..enterAnimation = enterAnimation
      ..playbackProgressNotifier = playbackProgressNotifier;
  }
}

/// [RenderProxyBox] يرسم مستطيلات مستديرة خلف نطاقات الآيات المحددة
/// باستخدام [RenderParagraph.getBoxesForSelection].
class _AyahSelectionRenderBox extends RenderProxyBox {
  _AyahSelectionRenderBox({
    required List<TextSelection> selectedRanges,
    required Color selectionColor,
    List<_ColoredTextRange> bookmarkRanges = const [],
    TextSelection? wordSelectionRange,
    required Animation<double> highlightAnimation,
    required Animation<double> enterAnimation,
    required ValueNotifier<double> playbackProgressNotifier,
  })  : _selectedRanges = selectedRanges,
        _selectionColor = selectionColor,
        _bookmarkRanges = bookmarkRanges,
        _wordSelectionRange = wordSelectionRange,
        _highlightAnimation = highlightAnimation,
        _enterAnimation = enterAnimation,
        _playbackProgressNotifier = playbackProgressNotifier;

  static const _wordSelectionColor =
      Color(0xffCDAD80); // بدون alpha — يُطبّق عند الرسم

  List<TextSelection> _selectedRanges;
  set selectedRanges(List<TextSelection> value) {
    if (listEquals(_selectedRanges, value)) return;
    _selectedRanges = value;
    markNeedsPaint();
  }

  Color _selectionColor;
  set selectionColor(Color value) {
    if (_selectionColor == value) return;
    _selectionColor = value;
    markNeedsPaint();
  }

  List<_ColoredTextRange> _bookmarkRanges;
  set bookmarkRanges(List<_ColoredTextRange> value) {
    _bookmarkRanges = value;
    markNeedsPaint();
  }

  TextSelection? _wordSelectionRange;
  set wordSelectionRange(TextSelection? value) {
    if (_wordSelectionRange == value) return;
    _wordSelectionRange = value;
    markNeedsPaint();
  }

  Animation<double> _highlightAnimation;
  set highlightAnimation(Animation<double> value) {
    if (_highlightAnimation == value) return;
    if (attached) {
      _highlightAnimation.removeListener(markNeedsPaint);
    }
    _highlightAnimation = value;
    if (attached) {
      _highlightAnimation.addListener(markNeedsPaint);
    }
    markNeedsPaint();
  }

  Animation<double> _enterAnimation;
  set enterAnimation(Animation<double> value) {
    if (_enterAnimation == value) return;
    if (attached) {
      _enterAnimation.removeListener(markNeedsPaint);
    }
    _enterAnimation = value;
    if (attached) {
      _enterAnimation.addListener(markNeedsPaint);
    }
    markNeedsPaint();
  }

  ValueNotifier<double> _playbackProgressNotifier;
  set playbackProgressNotifier(ValueNotifier<double> value) {
    if (_playbackProgressNotifier == value) return;
    if (attached) {
      _playbackProgressNotifier.removeListener(markNeedsPaint);
    }
    _playbackProgressNotifier = value;
    if (attached) {
      _playbackProgressNotifier.addListener(markNeedsPaint);
    }
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _highlightAnimation.addListener(markNeedsPaint);
    _enterAnimation.addListener(markNeedsPaint);
    _playbackProgressNotifier.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _highlightAnimation.removeListener(markNeedsPaint);
    _enterAnimation.removeListener(markNeedsPaint);
    _playbackProgressNotifier.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child is RenderParagraph) {
      final animVal = _highlightAnimation.value;
      final enterVal = _enterAnimation.value;
      final progress = _playbackProgressNotifier.value;
      // 1) علامات مرجعية (أسفل طبقة)
      if (_bookmarkRanges.isNotEmpty) {
        _paintColoredRanges(
            context, offset, _bookmarkRanges, animVal, enterVal);
      }
      // 2) تحديد الكلمة
      if (_wordSelectionRange != null) {
        _paintMergedBoxes(
          child! as RenderParagraph,
          context,
          offset,
          [_wordSelectionRange!],
          _wordSelectionColor,
          animVal,
          enterVal,
        );
      }
      // 3) تحديد الآية (أعلى طبقة) — مع تأثير شريط التقدّم عند التشغيل
      if (_selectedRanges.isNotEmpty) {
        _paintSelectionBackgrounds(
            context, offset, animVal, enterVal, progress);
      }
    }
    super.paint(context, offset);
  }

  /// رسم خلفيات التحديد خلف الآيات المحدّدة.
  void _paintSelectionBackgrounds(PaintingContext context, Offset offset,
      double animVal, double enterVal, double progress) {
    _paintMergedBoxes(child! as RenderParagraph, context, offset,
        _selectedRanges, _selectionColor, animVal, enterVal,
        playbackProgress: progress);
  }

  /// رسم خلفيات العلامات المرجعية - كل نطاق بلونه الخاص.
  void _paintColoredRanges(PaintingContext context, Offset offset,
      List<_ColoredTextRange> ranges, double animVal, double enterVal) {
    final paragraph = child! as RenderParagraph;
    for (final cr in ranges) {
      _paintMergedBoxes(
          paragraph, context, offset, [cr.range], cr.color, animVal, enterVal);
    }
  }

  /// دمج المستطيلات على نفس السطر ورسم RRect مستدير مع تأثيرات فاخرة.
  void _paintMergedBoxes(
    RenderParagraph paragraph,
    PaintingContext context,
    Offset offset,
    List<TextSelection> ranges,
    Color baseColor,
    double animVal,
    double enterVal, {
    double playbackProgress = -1.0,
  }) {
    const padding = EdgeInsets.only(right: 4, top: 0, bottom: -6);

    for (final range in ranges) {
      final boxes = paragraph.getBoxesForSelection(
        range,
        boxHeightStyle: BoxHeightStyle.max,
      );
      if (boxes.isEmpty) continue;

      final mergedRects = <Rect>[];
      Rect? current;
      double? currentTop;
      const lineTolerance = 2.0;

      for (final box in boxes) {
        final rect = box.toRect();
        if (current == null) {
          current = rect;
          currentTop = rect.top;
        } else if ((rect.top - currentTop!).abs() < lineTolerance) {
          current = Rect.fromLTRB(
            math.min(current.left, rect.left),
            math.min(current.top, rect.top),
            math.max(current.right, rect.right),
            math.max(current.bottom, rect.bottom),
          );
        } else {
          mergedRects.add(current);
          current = rect;
          currentTop = rect.top;
        }
      }
      if (current != null) mergedRects.add(current);

      for (final rect in mergedRects) {
        final padded = padding.inflateRect(rect).shift(offset);
        final rRect =
            RRect.fromRectAndRadius(padded, const Radius.circular(16));

        // أنيميشن الدخول: scale من المركز (0.88 → 1.0) + fade-in للألفا.
        if (enterVal < 1.0) {
          final scale = 0.88 + 0.12 * enterVal;
          final center = padded.center;
          final canvas = context.canvas;
          canvas.save();
          canvas.translate(center.dx, center.dy);
          canvas.scale(scale, scale);
          canvas.translate(-center.dx, -center.dy);
          paintFancyHighlight(
            canvas,
            rRect,
            baseColor,
            animVal,
            playbackProgress: playbackProgress,
            alphaScale: enterVal,
          );
          canvas.restore();
        } else {
          paintFancyHighlight(
            context.canvas,
            rRect,
            baseColor,
            animVal,
            playbackProgress: playbackProgress,
          );
        }
      }
    }
  }
}
