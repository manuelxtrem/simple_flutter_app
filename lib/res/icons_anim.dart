import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class AppAnimIcon {
  final String value;

  const AppAnimIcon(this.value);

  Widget draw({double? size}) => Lottie.asset(
        value,
        width: size ?? 24,
        height: size ?? 24,
      );

  static const AppAnimIcon addFiles = AppAnimIcon('assets/lottie/82533-add-files-button.json');
  static const AppAnimIcon notFound = AppAnimIcon('assets/lottie/93134-not-found.json');
}
