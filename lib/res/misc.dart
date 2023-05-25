import 'package:flutter/material.dart';
import 'package:simple_flutter_app/res/colors.dart';

extension LimitAppendList<T> on List<T> {
  void appendWithLimits(T item, {required int limit}) {
    if (length >= limit) {
      removeAt(0);
    }
    add(item);
  }

  void prependWithLimits(T item, {required int limit}) {
    if (length >= limit) {
      removeAt(length - 1);
    }
    insert(0, item);
  }
}

extension ColorManipulation on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

class TextFieldFormatter extends TextEditingController {
  final Map<String, TextStyle> map;
  final Pattern pattern;

  TextFieldFormatter(this.map, {String? text})
      : pattern = RegExp(
            map.keys.map((key) {
              return key;
            }).join('|'),
            multiLine: true),
        super(text: text);

  static Map<String, TextStyle> defaultTextFieldColorizerPattern() => {
        r'_(.*?)\_': const TextStyle(fontStyle: FontStyle.italic),
        '~(.*?)~': const TextStyle(decoration: TextDecoration.lineThrough),
        r'\*(.*?)\*': const TextStyle(fontWeight: FontWeight.bold),
        r'```(.*?)```': TextStyle(color: AppColors.primary),
      };

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context, TextStyle? style, required bool withComposing}) {
    final List<InlineSpan> children = [];
    late String patternMatched;
    String? formatText;
    TextStyle? myStyle;
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[match[0]] ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text).forEach((element) {
                  if (element.group(0) == match[0]) {
                    patternMatched = e;
                    ret = true;
                  }
                });
                return ret;
              },
            )];

        if (patternMatched == r"_(.*?)\_") {
          formatText = match[0]?.replaceAll("_", " ");
        } else if (patternMatched == r'\*(.*?)\*') {
          formatText = match[0]?.replaceAll("*", " ");
        } else if (patternMatched == "~(.*?)~") {
          formatText = match[0]?.replaceAll("~", " ");
        } else if (patternMatched == r'```(.*?)```') {
          formatText = match[0]?.replaceAll("```", "   ");
        } else {
          formatText = match[0];
        }
        children.add(TextSpan(
          text: formatText,
          style: style?.merge(myStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
