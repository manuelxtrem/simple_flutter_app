import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/misc.dart';
import 'package:simple_flutter_app/res/text.dart';

class AppTextField extends StatefulWidget {
  final String? title;
  final bool enabled;
  final bool readonly;
  final bool isPassword;
  final bool selectAllOnFocus;
  final String? prefixText;
  final Widget? prefix;
  final String? placeholder;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Map<String, TextStyle>? fieldFormatter;
  final String? initialText;
  final int lines;
  final String? Function(dynamic)? validator;
  final Function(String)? onSubmitted;
  final Function(dynamic)? onChanged;

  const AppTextField({
    Key? key,
    this.title,
    this.controller,
    this.fieldFormatter,
    this.enabled = true,
    this.readonly = false,
    this.isPassword = false,
    this.selectAllOnFocus = false,
    this.prefixText,
    this.placeholder,
    this.prefix,
    this.inputType,
    this.lines = 1,
    this.initialText,
    this.validator,
    this.onSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _ctrl;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _ctrl = widget.controller!;
    } else if (widget.fieldFormatter != null) {
      _ctrl = TextFieldFormatter(widget.fieldFormatter!, text: widget.initialText);
    } else {
      _ctrl = TextEditingController(text: widget.initialText);
    }

    if (widget.selectAllOnFocus) {
      _focusNode.addListener(() {
        if (_focusNode.hasFocus) {
          _ctrl.selection = TextSelection(baseOffset: 0, extentOffset: _ctrl.text.length);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.initialText != null && widget.initialText != _ctrl.text) {
    //   Future.microtask(() => _ctrl.text = widget.initialText!);
    // }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(widget.title!,
                style: TextStyles.textBody3.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                )),
          ),
        FormField(
          validator: (_) => widget.validator != null ? widget.validator!(_ctrl.text) : null,
          onSaved: (_) => widget.onSubmitted != null ? widget.onSubmitted!(_ctrl.text) : null,
          builder: (FormFieldState<dynamic> _field) {
            return TextField(
              controller: _ctrl,
              focusNode: _focusNode,
              keyboardType: widget.inputType,
              enabled: widget.readonly == true ? false : widget.enabled,
              style: TextStyles.textBody3,
              minLines: widget.lines,
              maxLines: widget.lines,
              onChanged: widget.onChanged,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                fillColor: widget.enabled ? Colors.white : Colors.grey.withOpacity(.3),
                filled: true, //!widget.enabled,
                prefixIcon: widget.prefix ??
                    (widget.prefixText != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15, top: 16),
                            child: Text(
                              widget.prefixText!,
                              style: TextStyles.textBody4,
                            ),
                          )
                        : null),
                hintText: widget.placeholder,
                errorText: _field.hasError ? _field.errorText : null,
                disabledBorder: widget.readonly
                    ? _buildDefaultBorder()
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
                      ),
                border: _buildDefaultBorder(),
                enabledBorder: _buildDefaultBorder(),
              ),
            );
          },
        ),
      ],
    );
  }

  OutlineInputBorder _buildDefaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    );
  }
}
