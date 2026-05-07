part of '/quran.dart';

class QuranOrTenRecitationsTabBar extends StatelessWidget {
  const QuranOrTenRecitationsTabBar({
    super.key,
    required this.bgColor,
    required this.defaults,
    required this.isDark,
  });

  final Color bgColor;
  final QuranTopBarStyle defaults;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = defaults.accentColor ?? scheme.primary;
    final blendBase = isDark ? Colors.black : Colors.white;
    final tabBg = defaults.accentColor != null
        ? Color.alphaBlend(accent.withValues(alpha: 0.25), blendBase)
        : scheme.surfaceContainerHighest;
    final tabIndicator = defaults.accentColor != null
        ? Color.alphaBlend(accent.withValues(alpha: 0.55), blendBase)
        : scheme.primaryContainer;
    final selectedLabelColor =
        defaults.accentColor ?? scheme.onPrimaryContainer;
    final unselectedLabelColor = scheme.onSurfaceVariant;

    return !QuranCtrl.instance.state.isTajweedEnabled.value
        ? SizedBox(
            height: 45,
            width: 250,
            child: Material(
              color: tabBg,
              borderRadius: BorderRadius.circular(defaults.borderRadius ?? 12),
              elevation: 0,
              child: TabBar(
                automaticIndicatorColorAdjustment: false,
                indicatorSize: TabBarIndicatorSize.tab,
                controller: WordInfoCtrl.instance.tabController,
                onTap: (index) async {
                  // عند اختيار "القراءات العشر" تأكد من أن البيانات محمّلة.
                  if (index == 1 &&
                      !WordInfoCtrl.instance
                          .isKindAvailable(WordInfoKind.recitations)) {
                    // TabBar يغيّر التبويب قبل onTap، لذا نرجع مباشرة للتبويب الأول.
                    WordInfoCtrl.instance.tabController.animateTo(0);

                    final fallbackRef =
                        WordInfoCtrl.instance.selectedWordRef.value ??
                            const WordRef(
                              surahNumber: 1,
                              ayahNumber: 1,
                              wordNumber: 1,
                            );

                    await showWordInfoBottomSheet(
                      context: context,
                      ref: fallbackRef,
                      initialKind: WordInfoKind.recitations,
                      isDark: isDark,
                    );

                    if (WordInfoCtrl.instance
                        .isKindAvailable(WordInfoKind.recitations)) {
                      WordInfoCtrl.instance.tabController.animateTo(1);
                    }
                  }
                },
                indicator: BoxDecoration(
                  color: tabIndicator,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorPadding: const EdgeInsets.all(4),
                labelColor: selectedLabelColor,
                unselectedLabelColor: unselectedLabelColor,
                labelStyle: defaults.tabLabelStyle,
                tabs: [
                  Tab(text: defaults.quranTabText),
                  Tab(text: defaults.tenRecitationsTabText),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
