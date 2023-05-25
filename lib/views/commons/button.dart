import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/text.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final String text;
  final bool isLoading;
  final bool disabled;
  final Function() onPressed;

  const AppButton({
    Key? key,
    required this.text,
    this.isLoading = false,
    this.disabled = false,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!isLoading && !disabled) onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (color ?? AppColors.secondarySwatch.shade600).withOpacity(disabled ? .6 : 1)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5.0),
        child: isLoading
            ? const LoadingWidget(size: 15, color: Colors.white)
            : Text(
                text,
                style: TextStyles.textTitle2.copyWith(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
