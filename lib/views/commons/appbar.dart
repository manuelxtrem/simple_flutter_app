import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/enums.dart';
import 'package:simple_flutter_app/res/text.dart';

class BlurredAppBar {
  static PreferredSizeWidget build(
    BuildContext context, {
    LeadButtonType leadButtonType = LeadButtonType.none,
    List<Widget>? actions,
    VoidCallback? onLeadButtonPressed,
    double opacity = 0.4,
    PreferredSize? bottom,
    bool darkenBlur = false,
    String? title,
  }) {
    final appBar = AppBar(
      title: title != null
          ? Text(title,
              style: TextStyles.textSubtitle1
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w700))
          : null,
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.background.withOpacity(opacity),
      leading: IconButton(
          icon: Icon(() {
            switch (leadButtonType) {
              case LeadButtonType.back:
                return Icons.arrow_back;
              case LeadButtonType.close:
                return Icons.close;
              default:
                return null;
            }
          }(), color: Colors.black, size: 22),
          onPressed: () {
            if (onLeadButtonPressed != null) {
              onLeadButtonPressed();
              return;
            }

            if (leadButtonType != LeadButtonType.none) {
              Navigator.pop(context);
            }
          }),
      actions: actions,
      bottom: bottom,
    );
    return PreferredSize(
      preferredSize: appBar.preferredSize,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ClipRect(
          child: Container(
            color: darkenBlur ? Colors.black38 : Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: appBar,
            ),
          ),
        ),
      ),
    );
  }
}
