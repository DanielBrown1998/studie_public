import 'package:app/core/theme/theme.dart';
import 'package:get/get.dart';

class DefaultDialog {
  static Future<bool?> dialog({
    required String confirmText,
    required String cancelText,
    required String middleText,
    required String titleText,
  }) => Get.defaultDialog(
    textConfirm: confirmText,
    textCancel: cancelText,
    backgroundColor: StudieTheme.whiteSmoke,
    title: titleText,
    titleStyle: StudieTheme.textTheme.bodyLarge,
    middleText: middleText,
    middleTextStyle: StudieTheme.textTheme.bodyMedium,
    confirmTextColor: StudieTheme.whiteSmoke,
    cancelTextColor: StudieTheme.secondaryColor,
    onConfirm: () => Get.back(result: true),
    onCancel: () {},
  );
}
