part of '/quran.dart';

/// Draws a fancy highlight box with glow, gradient fill, border stroke,
/// and alpha-pulse driven by [animValue] (0.0 – 1.0).
///
/// [playbackProgress] controls a karaoke-style sweep fill (0.0–1.0).
/// Pass -1.0 (or any negative) to disable the sweep and use uniform fill.
/// The sweep fills from right to left (RTL Arabic direction).
///
/// Layer order (back → front):
///   1. Blur glow (spread slightly beyond the rect)
///   2. Top-to-bottom gradient fill (clipped to swept region if playback active)
///   3. Dimmed fill for the unswept region (when playback active)
///   4. Thin stroke border
void paintFancyHighlight(
  Canvas canvas,
  RRect rRect,
  Color baseColor,
  double animValue, {
  double playbackProgress = -1.0,
}) {
  final bool sweeping = playbackProgress >= 0.0;

  // ── 1. Glow ────────────────────────────────────────────────────────────────
  final glowPaint = Paint()
    ..color = baseColor.withValues(alpha: 0.30 + 0.15 * animValue)
    ..maskFilter =
        MaskFilter.blur(BlurStyle.normal, 6.0 + 2.0 * animValue);
  canvas.drawRRect(rRect.inflate(2.0), glowPaint);

  final outer = rRect.outerRect;

  if (sweeping) {
    // Arabic text is RTL: progress sweeps right-to-left.
    // progress=0 → nothing swept (right edge = right edge)
    // progress=1 → fully swept (sweep covers entire rect)
    final double sweepRight = outer.right;
    final double sweepLeft = outer.right - outer.width * playbackProgress;

    final sweptRect = Rect.fromLTRB(
      sweepLeft,
      outer.top,
      sweepRight,
      outer.bottom,
    );

    // ── 2a. Bright fill — swept region ──────────────────────────────────────
    final sweptGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        baseColor.withValues(alpha: 0.55 + 0.10 * animValue),
        baseColor.withValues(alpha: 0.32 + 0.07 * animValue),
      ],
    );
    canvas.save();
    canvas.clipRRect(rRect);
    final sweptFillPaint = Paint()
      ..shader = sweptGradient.createShader(sweptRect);
    canvas.drawRect(sweptRect, sweptFillPaint);

    // ── 2b. Dim fill — unswept region ────────────────────────────────────────
    if (sweepLeft > outer.left) {
      final unsweptRect = Rect.fromLTRB(
        outer.left,
        outer.top,
        sweepLeft,
        outer.bottom,
      );
      final dimPaint = Paint()
        ..color = baseColor.withValues(alpha: 0.12 + 0.03 * animValue);
      canvas.drawRect(unsweptRect, dimPaint);
    }
    canvas.restore();
  } else {
    // ── 2. Uniform gradient fill ─────────────────────────────────────────────
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        baseColor.withValues(alpha: 0.50 + 0.10 * animValue),
        baseColor.withValues(alpha: 0.28 + 0.07 * animValue),
      ],
    );
    final fillPaint = Paint()..shader = gradient.createShader(outer);
    canvas.drawRRect(rRect, fillPaint);
  }

  // ── 3. Stroke border ───────────────────────────────────────────────────────
  final strokePaint = Paint()
    ..color = baseColor.withValues(alpha: 0.60 + 0.20 * animValue)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  canvas.drawRRect(rRect, strokePaint);
}
