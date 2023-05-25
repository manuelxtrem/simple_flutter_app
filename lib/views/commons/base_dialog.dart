import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/misc.dart';
import 'package:simple_flutter_app/res/text.dart';

class AlertDialogue<T> extends ModalRoute<T> {
  static const id = "alert_dialogue";

  final String title;
  final String? message;
  final Widget? messageWidget;
  final String positiveText;
  final String? negativeText;
  final String? cancelText;
  final ValueChanged<BuildContext> positiveAction;
  final ValueChanged<BuildContext>? negativeAction;
  final ValueChanged<BuildContext>? cancelAction;
  final bool closable;

  final Widget Function(BuildContext context)? builder;

  AlertDialogue({
    required this.title,
    this.message,
    this.messageWidget,
    required this.positiveText,
    this.negativeText,
    this.cancelText,
    required this.positiveAction,
    this.negativeAction,
    this.cancelAction,
    this.closable = true,
    this.builder,
  }) : super(settings: const RouteSettings(name: AlertDialogue.id));

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: builder != null ? builder!(context) : _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (closable) {
          Navigator.pop(context);
        }
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: 343,
                    padding: const EdgeInsets.fromLTRB(26, 0, 26, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: TextStyles.textTitle1),
                            const SizedBox(height: 15),
                            messageWidget ??
                                Text(
                                  message!,
                                  style: TextStyles.textBody1.copyWith(fontWeight: FontWeight.w300),
                                ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            if (cancelText != null)...[
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      cancelAction != null ? cancelAction!(context) : null,
                                  child: Text(
                                    cancelText!,
                                    style: TextStyles.textBody2
                                        .copyWith(color: AppColors.secondarySwatch.shade800),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: 1,
                                color: Colors.black.lighten(),
                                height: 25,
                              ),
                            ],
                            if (negativeText != null)...[
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      negativeAction != null ? negativeAction!(context) : null,
                                  child: Text(
                                    negativeText!,
                                    style: TextStyles.textBody2
                                        .copyWith(color: AppColors.secondarySwatch.shade200),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: 1,
                                color: Colors.black.lighten(),
                                height: 25,
                              ),
                            ],
                            Expanded(
                              child: TextButton(
                                onPressed: () => positiveAction(context),
                                child: Text(
                                  positiveText,
                                  style: TextStyles.textBody2
                                      .copyWith(color: AppColors.primarySwatch.shade700),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
