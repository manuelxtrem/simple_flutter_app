import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';

class CupertinoContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final VoidCallback? onDismiss;

  const CupertinoContainer({Key? key, required this.child, this.height = 200, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + 20,
      color: Colors.white,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          child,
          Positioned(
            right: 0,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              // color: Colors.transparent,
              // splashColor: Colors.transparent,
              // highlightColor: Colors.transparent,
              onPressed: () {
                if (onDismiss != null) {
                  onDismiss!();
                }
                Navigator.pop(context);
              },
              child: Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primarySwatch)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateWheel extends StatelessWidget {
//  final int value;
  final ValueChanged<DateTime>? onChange;
  final ValueChanged<DateTime>? onDismiss;

  final int period;
  final int? minuteInterval;
  final CupertinoDatePickerMode? mode;
  final DateTime initialDate;
  final DateTime? startDate;

//  final int max;

  const _DateWheel({
    Key? key,
    this.onChange,
    this.onDismiss,
    required this.period,
    required this.initialDate,
    this.minuteInterval = 1,
    this.mode = CupertinoDatePickerMode.date,
    this.startDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final start = startDate ?? DateTime.now().subtract(const Duration(days: 1));
    final limit = start.add(Duration(days: period));

    DateTime dt = initialDate;

    return CupertinoContainer(
      child: CupertinoDatePicker(
        minimumDate: start,
        maximumDate: limit,
        maximumYear: limit.year,
        minimumYear: start.year,
        mode: mode!,
        minuteInterval: minuteInterval!,
        initialDateTime: dt,
        onDateTimeChanged: (DateTime value) {
          dt = value;
          if (onChange != null) {
            onChange!(value);
          }
        },
      ),
      onDismiss: () {
        if (onDismiss != null) {
          onDismiss!(dt);
        }
      },
    );
  }
}

class WheelModal {
  static dateWheelModal(
    BuildContext context, {
    int period = 365 * 10, // 10 years
    ValueChanged<DateTime>? onChange,
    ValueChanged<DateTime>? onDismiss,
    required DateTime initialDate,
    DateTime? startDate,
    int minuteInterval = 1,
    CupertinoDatePickerMode? mode = CupertinoDatePickerMode.date,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return _DateWheel(
          onChange: onChange,
          period: period,
          mode: mode,
          minuteInterval: minuteInterval,
          onDismiss: onDismiss,
          initialDate: initialDate,
          startDate: startDate,
        );
      },
    );
  }
}
