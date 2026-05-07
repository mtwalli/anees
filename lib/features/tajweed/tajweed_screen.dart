import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

// ── Models ────────────────────────────────────────────────────────────────────

class _SubRule {
  const _SubRule({
    required this.arabicName,
    required this.transliteration,
    required this.arabicDefinition,
    required this.letters,
    this.lettersMnemonic,
    this.harakaat,
    this.exampleArabic,
    this.notes,
    this.colorHex,
  });

  final String arabicName;
  final String transliteration;
  final String arabicDefinition;
  final String letters;
  final String? lettersMnemonic;
  final int? harakaat;
  final String? exampleArabic;
  final String? notes;
  final String? colorHex;

  factory _SubRule.fromJson(Map<String, dynamic> j) => _SubRule(
        arabicName: j['arabic_name'] as String,
        transliteration: j['transliteration'] as String,
        arabicDefinition: j['arabic_definition'] as String,
        letters: j['letters'] as String? ?? '',
        lettersMnemonic: j['letters_mnemonic'] as String?,
        harakaat: j['harakaat'] as int?,
        exampleArabic: j['example_arabic'] as String?,
        notes: j['notes'] as String?,
        colorHex: j['color_hex'] as String?,
      );
}

class _Category {
  const _Category({
    required this.arabicName,
    required this.transliteration,
    required this.arabicDescription,
    required this.subRules,
    this.colorHex,
  });

  final String arabicName;
  final String transliteration;
  final String arabicDescription;
  final List<_SubRule> subRules;
  final String? colorHex;

  factory _Category.fromJson(Map<String, dynamic> j) => _Category(
        arabicName: j['arabic_name'] as String,
        transliteration: j['transliteration'] as String,
        arabicDescription: j['arabic_description'] as String,
        colorHex: j['color_hex'] as String?,
        subRules: (j['sub_rules'] as List<dynamic>)
            .map((e) => _SubRule.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

// ── Color helper ──────────────────────────────────────────────────────────────

Color _hex(String? hex, Color fallback) {
  if (hex == null || hex.isEmpty) return fallback;
  final val = int.tryParse(hex.replaceFirst('#', 'FF'), radix: 16);
  return val != null ? Color(val) : fallback;
}

// ── Main screen ───────────────────────────────────────────────────────────────

class TajweedScreen extends StatefulWidget {
  const TajweedScreen({super.key});

  @override
  State<TajweedScreen> createState() => _TajweedScreenState();
}

class _TajweedScreenState extends State<TajweedScreen> {
  List<_Category>? _categories;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await rootBundle
        .loadString('assets/data/tajweed_rules.json');
    final data = json.decode(raw) as Map<String, dynamic>;
    final cats = (data['categories'] as List<dynamic>)
        .map((e) => _Category.fromJson(e as Map<String, dynamic>))
        .toList();
    if (mounted) setState(() => _categories = cats);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = AppColors.accent(isDark);

    return Scaffold(
      backgroundColor: AppColors.background(isDark),
      appBar: AppBar(
        title: Text(l10n.tajweedScreenTitle),
        backgroundColor: AppColors.darkBackground,
        foregroundColor: accent,
      ),
      body: _categories == null
          ? Center(
              child: CircularProgressIndicator(color: accent),
            )
          : _Body(categories: _categories!, isDark: isDark, accent: accent),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _Body extends StatelessWidget {
  const _Body({
    required this.categories,
    required this.isDark,
    required this.accent,
  });

  final List<_Category> categories;
  final bool isDark;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: categories.length,
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemBuilder: (_, i) => _CategoryCard(
          category: categories[i],
          isDark: isDark,
          accent: accent,
        ),
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatefulWidget {
  const _CategoryCard({
    required this.category,
    required this.isDark,
    required this.accent,
  });

  final _Category category;
  final bool isDark;
  final Color accent;

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _ctrl;
  late final Animation<double> _rotate;
  late final Animation<double> _expand;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _rotate = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
    _expand = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(widget.isDark);
    final text = AppColors.text(widget.isDark);
    final sub = AppColors.subtext(widget.isDark);
    final catColor = _hex(widget.category.colorHex, widget.accent);

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: catColor.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          // ── Header ────────────────────────────────────────────────────
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  RotationTransition(
                    turns: _rotate,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: catColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category.arabicName,
                          style: TextStyle(
                            fontFamily: AppTheme.arabicUIFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.category.transliteration,
                          style: TextStyle(
                            fontFamily: AppTheme.arabicUIFont,
                            fontSize: 11,
                            color: sub,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: catColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.category.subRules.length}',
                      style: TextStyle(
                        fontFamily: AppTheme.arabicUIFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: catColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Description (always visible) ──────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Text(
              widget.category.arabicDescription,
              style: TextStyle(
                fontFamily: AppTheme.arabicUIFont,
                fontSize: 13,
                height: 1.7,
                color: sub,
              ),
            ),
          ),

          // ── Sub-rules (animated expand) ───────────────────────────────
          SizeTransition(
            sizeFactor: _expand,
            child: Column(
              children: [
                Divider(
                  height: 1,
                  color: catColor.withValues(alpha: 0.2),
                ),
                ...widget.category.subRules.map(
                  (sr) => _SubRuleTile(
                    subRule: sr,
                    isDark: widget.isDark,
                    accent: widget.accent,
                    catColor: catColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-rule tile ─────────────────────────────────────────────────────────────

class _SubRuleTile extends StatelessWidget {
  const _SubRuleTile({
    required this.subRule,
    required this.isDark,
    required this.accent,
    required this.catColor,
  });

  final _SubRule subRule;
  final bool isDark;
  final Color accent;
  final Color catColor;

  @override
  Widget build(BuildContext context) {
    final text = AppColors.text(isDark);
    final sub = AppColors.subtext(isDark);
    final bg = AppColors.background(isDark);
    final ruleColor = _hex(subRule.colorHex, catColor);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            right: BorderSide(color: ruleColor, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + transliteration row
            Row(
              children: [
                Expanded(
                  child: Text(
                    subRule.arabicName,
                    style: TextStyle(
                      fontFamily: AppTheme.arabicUIFont,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: text,
                    ),
                  ),
                ),
                if (subRule.harakaat != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: ruleColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${subRule.harakaat} حركات',
                      style: TextStyle(
                        fontFamily: AppTheme.arabicUIFont,
                        fontSize: 11,
                        color: ruleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subRule.transliteration,
              style: TextStyle(
                fontFamily: AppTheme.arabicUIFont,
                fontSize: 11,
                color: sub,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Definition
            Text(
              subRule.arabicDefinition,
              style: TextStyle(
                fontFamily: AppTheme.arabicUIFont,
                fontSize: 13,
                height: 1.7,
                color: text,
              ),
            ),

            // Letters
            if (subRule.letters.isNotEmpty) ...[
              const SizedBox(height: 10),
              _InfoRow(
                label: 'الحروف:',
                value: subRule.letters,
                color: ruleColor,
                isDark: isDark,
              ),
            ],

            // Mnemonic
            if (subRule.lettersMnemonic != null) ...[
              const SizedBox(height: 6),
              _InfoRow(
                label: 'المنظومة:',
                value: subRule.lettersMnemonic!,
                color: sub,
                isDark: isDark,
              ),
            ],

            // Example
            if (subRule.exampleArabic != null) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: ruleColor.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ruleColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  subRule.exampleArabic!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.arabicQuranicFont,
                    fontSize: 18,
                    height: 1.9,
                    color: text,
                  ),
                ),
              ),
            ],

            // Notes
            if (subRule.notes != null) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 14, color: sub),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      subRule.notes!,
                      style: TextStyle(
                        fontFamily: AppTheme.arabicUIFont,
                        fontSize: 12,
                        height: 1.6,
                        color: sub,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Small label+value row ─────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  final String label;
  final String value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final text = AppColors.text(isDark);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTheme.arabicUIFont,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: AppTheme.arabicUIFont,
              fontSize: 12,
              color: text,
            ),
          ),
        ),
      ],
    );
  }
}
