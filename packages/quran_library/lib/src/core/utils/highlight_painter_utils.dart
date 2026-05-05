part of '/quran.dart';

/// Draws a fancy highlight box with glow, gradient fill, border stroke,
/// and alpha-pulse driven by [animValue] (0.0 – 1.0).
///
/// Layer order (back → front):
///   1. Blur glow (spread slightly beyond the rect)
///   2. Top-to-bottom gradient fill
///   3. Thin stroke border
void paintFancyHighlight(
  Canvas canvas,
  RRect rRect,
  Color baseColor,
  double animValue,
) {
  // ── 1. Glow ────────────────────────────────────────────────────────────────
  final glowPaint = Paint()
    ..color = baseColor.withValues(alpha: 0.30 + 0.15 * animValue)
    ..maskFilter =
        MaskFilter.blur(BlurStyle.normal, 6.0 + 2.0 * animValue);
  canvas.drawRRect(rRect.inflate(2.0), glowPaint);

  // ── 2. Gradient fill ───────────────────────────────────────────────────────
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      baseColor.withValues(alpha: 0.50 + 0.10 * animValue),
      baseColor.withValues(alpha: 0.28 + 0.07 * animValue),
    ],
  );
  final fillPaint = Paint()
    ..shader = gradient.createShader(rRect.outerRect);
  canvas.drawRRect(rRect, fillPaint);

  // ── 3. Stroke border ───────────────────────────────────────────────────────
  final strokePaint = Paint()
    ..color = baseColor.withValues(alpha: 0.60 + 0.20 * animValue)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  canvas.drawRRect(rRect, strokePaint);
}
