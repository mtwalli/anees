part of '/quran.dart';

class BuildBottomSection extends StatefulWidget {
  const BuildBottomSection({
    super.key,
    required this.pageIndex,
    required this.isRight,
    required this.languageCode,
  });

  final bool isRight;
  final int pageIndex;
  final String languageCode;

  @override
  State<BuildBottomSection> createState() => _BuildBottomSectionState();
}

class _BuildBottomSectionState extends State<BuildBottomSection> {
  final quranCtrl = QuranCtrl.instance;

  final OverlayPortalController _dragCtrl = OverlayPortalController();
  final GlobalKey<_DragPageIndicatorState> _indicatorKey = GlobalKey();

  late double _dragPage;

  static const double _pxPerPage = 6.0;

  void _onLongPressStart(LongPressStartDetails _) {
    _dragPage = quranCtrl.state.currentPageNumber.value.toDouble();
    _dragCtrl.show();
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final newPage = (_dragPage - details.offsetFromOrigin.dx / _pxPerPage)
        .clamp(1.0, 604.0);
    final newPageInt = newPage.round();
    if (newPageInt != quranCtrl.state.currentPageNumber.value) {
      quranCtrl.jumpToPage(newPageInt - 1);
    }
    // Drive the indicator directly — no setState on parent, no widget recreation
    _indicatorKey.currentState?.morphTo(newPageInt);
  }

  void _onLongPressEnd(LongPressEndDetails _) {
    _dragCtrl.hide();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final topBottomStyle = TopBottomTheme.of(context)?.style ??
        TopBottomQuranStyle.defaults(isDark: isDark, context: context);
    final String effectiveSajdaName =
        topBottomStyle.sajdaName ?? QuranLocalizations.of(context).sajdaLabel;
    final String effectiveHizbName =
        topBottomStyle.hizbName ?? QuranLocalizations.of(context).hizbLabel;
    final Color hizbColor =
        topBottomStyle.hizbTextColor ?? const Color(0xff77554B);
    final Color pageNumberColor =
        topBottomStyle.pageNumberColor ?? const Color(0xff77554B);
    final Color sajdaNameColor =
        topBottomStyle.sajdaNameColor ?? const Color(0xff77554B);

    final hizbText = Text(
      quranCtrl
          .getHizbQuarterDisplayByPage(widget.pageIndex + 1)
          .replaceAll('الحزب', effectiveHizbName)
          .convertNumbersAccordingToLang(languageCode: widget.languageCode),
      style: _getTextStyle(context, hizbColor),
    );

    final pageNumberWidget = OverlayPortal(
      controller: _dragCtrl,
      overlayChildBuilder: (overlayContext) => _DragPageIndicator(
        key: _indicatorKey,
        initialPage: quranCtrl.state.currentPageNumber.value,
        isDark: isDark,
        color: pageNumberColor,
      ),
      child: GestureDetector(
        onLongPressStart: _onLongPressStart,
        onLongPressMoveUpdate: _onLongPressMoveUpdate,
        onLongPressEnd: _onLongPressEnd,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            '${widget.pageIndex + 1}'.convertNumbersAccordingToLang(
                languageCode: widget.languageCode),
            style: _getPageNumberStyle(context, pageNumberColor),
          ),
        ),
      ),
    );

    return widget.isRight
        ? Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: hizbText,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: pageNumberWidget,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const SizedBox().showSajda(context, widget.pageIndex,
                      effectiveSajdaName, sajdaNameColor),
                ),
              ),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const SizedBox().showSajda(context, widget.pageIndex,
                      effectiveSajdaName, sajdaNameColor),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: pageNumberWidget,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: hizbText,
                ),
              ),
            ],
          );
  }

  TextStyle _getPageNumberStyle(BuildContext context, Color color) {
    return TextStyle(
      fontSize: UiHelper.currentOrientation(20.0, 22.0, context),
      fontFamily: 'naskh',
      color: color,
      package: 'quran_library',
    );
  }

  TextStyle _getTextStyle(BuildContext context, Color color) {
    return TextStyle(
      fontSize: UiHelper.currentOrientation(18.0, 22.0, context),
      fontFamily: 'naskh',
      color: color,
      package: 'quran_library',
    );
  }
}

/// Floating pill — created once, updated imperatively via [morphTo].
class _DragPageIndicator extends StatefulWidget {
  const _DragPageIndicator({
    super.key,
    required this.initialPage,
    required this.isDark,
    required this.color,
  });

  final int initialPage;
  final bool isDark;
  final Color color;

  @override
  State<_DragPageIndicator> createState() => _DragPageIndicatorState();
}

class _DragPageIndicatorState extends State<_DragPageIndicator>
    with SingleTickerProviderStateMixin {
  // Pill entrance
  late final AnimationController _entranceCtrl;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  int _displayPage = 0;

  @override
  void initState() {
    super.initState();
    _displayPage = widget.initialPage;

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scale = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutBack);
    _opacity = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _entranceCtrl.forward();
  }

  /// Called by parent whenever the target page changes.
  void morphTo(int targetPage) {
    if (targetPage == _displayPage) return;
    setState(() => _displayPage = targetPage);
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomPadding + 32,
      child: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '$_displayPage',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: widget.isDark ? Colors.black : Colors.white,
                  fontFamily: 'naskh',
                  package: 'quran_library',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
