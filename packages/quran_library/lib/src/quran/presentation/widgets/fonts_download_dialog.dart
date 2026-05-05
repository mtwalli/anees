part of '/quran.dart';

class FontsDownloadDialog extends StatelessWidget {
  final DownloadFontsDialogStyle? downloadFontsDialogStyle;
  final String? languageCode;
  final bool isDark;
  final bool? isFontsLocal;
  final QuranTopBarStyle? topBarStyle;

  FontsDownloadDialog(
      {super.key,
      this.downloadFontsDialogStyle,
      this.topBarStyle,
      this.languageCode,
      this.isFontsLocal,
      this.isDark = false});

  final quranCtrl = QuranCtrl.instance;

  @override
  Widget build(BuildContext context) {
    final QuranTopBarStyle defaults = topBarStyle ??
        QuranTopBarStyle.defaults(isDark: isDark, context: context);
    return IconButton(
      onPressed: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                backgroundColor: downloadFontsDialogStyle?.backgroundColor,
                contentPadding: EdgeInsets.zero,
                content: FontsDownloadWidget(
                  downloadFontsDialogStyle: downloadFontsDialogStyle,
                  languageCode: languageCode,
                  isDark: isDark,
                  isFontsLocal: isFontsLocal ?? false,
                  ctrl: quranCtrl,
                ),
              )),
      icon: downloadFontsDialogStyle?.iconWidget ??
          Icon(
            Icons.more_vert_rounded,
            size: defaults.iconSize,
            color: defaults.iconColor ?? Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
