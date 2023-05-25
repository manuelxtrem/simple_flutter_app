import 'package:flutter/material.dart';

import 'base_dialog.dart';

enum DialogAction { positive, negative, cancel }

class Dialogs {
  static Future showSingleMessageDialog(
    BuildContext context, {
    String? title,
    required String message,
    String? buttonText,
  }) async {
    return await Navigator.of(context).push(AlertDialogue(
      title: title ?? 'Alert',
      message: message,
      positiveText: buttonText ?? 'Okay',
      positiveAction: (_) {
        Navigator.of(context).pop();
      },
    ));
  }

  static Future<DialogAction?> showDoubleMessageDialog(
    BuildContext context, {
    String? title,
    required String message,
    String? positiveText,
    String? negativeText,
  }) async {
    return await Navigator.of(context).push(AlertDialogue(
      title: title ?? 'Alert',
      message: message,
      positiveText: positiveText ?? 'Yes',
      positiveAction: (_) {
        Navigator.of(context).pop(DialogAction.positive);
      },
      negativeText: negativeText ?? 'No',
      negativeAction: (_) {
        Navigator.of(context).pop(DialogAction.negative);
      },
    ));
  }

  static Future<DialogAction?> showTripleMessageDialog(
    BuildContext context, {
    String? title,
    required String message,
    String? positiveText,
    String? negativeText,
    String? cancelText,
  }) async {
    return await Navigator.of(context).push(AlertDialogue(
      title: title ?? 'Alert',
      message: message,
      positiveText: positiveText ?? 'Yes',
      positiveAction: (_) {
        Navigator.of(context).pop(DialogAction.positive);
      },
      negativeText: negativeText ?? 'No',
      negativeAction: (_) {
        Navigator.of(context).pop(DialogAction.negative);
      },
      cancelText: cancelText ?? 'Cancel',
      cancelAction: (_) {
        Navigator.of(context).pop(DialogAction.cancel);
      },
    ));
  }

  Future showAlertDialogue(
    BuildContext context, {
    required String title,
    String? message,
    Widget? messageWidget,
    required String positiveText,
    String? negativeText,
    required ValueChanged<BuildContext> positiveAction,
    ValueChanged<BuildContext>? negativeAction,
  }) async {
    assert(message != null || messageWidget != null);
    return await Navigator.of(context).push(AlertDialogue(
      title: title,
      message: message,
      messageWidget: messageWidget,
      positiveText: positiveText,
      negativeText: negativeText,
      positiveAction: positiveAction,
      negativeAction: negativeAction,
    ));
  }

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget widget, {bool dismissible = true}) {
    return showModalBottomSheet<T?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      isDismissible: dismissible,
      enableDrag: dismissible,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget,
        );
      },
    );
  }
}
