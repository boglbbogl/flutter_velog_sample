import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/ui/sns_tag/sns_tag_service.dart';

class CustomTagController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<String> words = text.split(" ");
    List<TextSpan> children = [];
    bool isTag = false;
    TextStyle style = const TextStyle(color: Colors.white, fontSize: 16);
    for (final String word in words) {
      if (!isTag && SnsTagService.current.value == word) {
        children.add(TextSpan(
            text: "$word ",
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              backgroundColor:
                  SnsTagService.isBack ? Colors.white : Colors.transparent,
            )));
        isTag = true;
      } else {
        children.add(TextSpan(text: "$word ", style: style));
      }
    }
    return TextSpan(children: children);
  }
}
