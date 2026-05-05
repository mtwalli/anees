part of '/quran.dart';

extension FontSizeExtension on Widget {
  Widget fontSizeDropDown({
    double? height,
    Color? color,
    bool isDark = false,
    TafsirStyle? tafsirStyle,
  }) {
    final box = GetStorage();
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: tafsirStyle?.fontSizeIconWidget ??
          Semantics(
            button: true,
            enabled: true,
            label: 'Change Font Size',
            child: Icon(
              Icons.text_increase,
              size: 34,
              color: AppColors.getTextColor(isDark),
            ),
          ),
      color: tafsirStyle?.fontSizeBackgroundColor,
      iconSize: tafsirStyle?.fontSizeIconSize,
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Material(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerLow
                .withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10),
            child: Obx(
              () => SizedBox(
                height: 30,
                width: MediaQuery.sizeOf(context).width,
                child: Slider(
                  value: TafsirCtrl.instance.fontSizeArabic.value,
                  max: 50,
                  min: 20,
                  onChanged: (value) {
                    TafsirCtrl.instance.fontSizeArabic.value = value;
                    box.write(_StorageConstants().fontSize, value);
                    TafsirCtrl.instance.update(['change_font_size']);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
