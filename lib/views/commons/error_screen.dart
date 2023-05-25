import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/icons_anim.dart';
import 'package:simple_flutter_app/res/text.dart';
import 'package:simple_flutter_app/res/utils.dart';
import 'package:simple_flutter_app/views/commons/button.dart';

class EmptyListNotice extends StatelessWidget {
  final String title;
  final String? subtitle;
  final AppAnimIcon? icon;
  final double? iconSize;
  final String? buttonText;
  final Function? buttonPressed;

  const EmptyListNotice(
      {Key? key,
      required this.title,
      this.subtitle,
      this.icon,
      this.iconSize,
      this.buttonText,
      this.buttonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? errorDescription = subtitle;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: icon != null
                ? icon!.draw(
                    size: iconSize ?? 150,
                  )
                : AppAnimIcon.notFound.draw(
                    size: iconSize ?? 150,
                  )),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.textTitle1,
        ),
        const SizedBox(height: 10),
        !Utils.isEmptyOrNull(errorDescription)
            ? Text(
                errorDescription!,
                textAlign: TextAlign.center,
                style: TextStyles.textBody3,
              )
            : Container(),
        const SizedBox(height: 30),
        !Utils.isEmptyOrNull(buttonText)
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppButton(
                  text: buttonText!,
                  onPressed: () => buttonPressed!(),
                ),
              )
            : Container(),
      ],
    );
  }
}
