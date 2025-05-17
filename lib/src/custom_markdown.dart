import 'package:flutter/material.dart';
import 'markdown_styles.dart';

class CustomMarkdown extends StatelessWidget {
  const CustomMarkdown({super.key, required this.data, this.color});
  final String data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final markdownStyles = MarkdownStyles();

    final lines = data.split('\n');
    final List<TextSpan> spans = [];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        spans.add(const TextSpan(text: '\n'));
        continue;
      }

      TextStyle? style;
      String content = line;

      if (line.startsWith('# ')) {
        style = markdownStyles.h1;
        content = line.substring(2);
      } else if (line.startsWith('## ')) {
        style = markdownStyles.h2;
        content = line.substring(3);
      } else if (line.startsWith('### ')) {
        style = markdownStyles.h3;
        content = line.substring(4);
      } else if (line.startsWith('#### ')) {
        style = markdownStyles.h4;
        content = line.substring(5);
      } else {
        style = markdownStyles.p;
      }

      spans.add(TextSpan(children: _parseInline(content, style)));
      spans.add(const TextSpan(text: '\n'));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  List<InlineSpan> _parseInline(String text, TextStyle baseStyle) {
    final List<InlineSpan> children = [];
    final RegExp exp = RegExp(
      r'(\*\*.*?\*\*|_.*?_|~~.*?~~|`.*?`)',
    );

    int currentIndex = 0;

    final matches = exp.allMatches(text);

    for (final match in matches) {
      if (match.start > currentIndex) {
        children.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: baseStyle,
        ));
      }

      final matchText = match.group(0)!;

      if (matchText.startsWith('**')) {
        children.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: baseStyle.merge(const TextStyle(fontFamily: 'Karla-Bold')),
        ));
      } else if (matchText.startsWith('_')) {
        children.add(TextSpan(
          text: matchText.substring(1, matchText.length - 1),
          style: baseStyle.merge(const TextStyle(fontStyle: FontStyle.italic)),
        ));
      } else if (matchText.startsWith('~~')) {
        children.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: baseStyle
              .merge(const TextStyle(decoration: TextDecoration.lineThrough)),
        ));
      } else if (matchText.startsWith('`')) {
        children.add(TextSpan(
          text: matchText.substring(1, matchText.length - 1),
          style: baseStyle.merge(
            const TextStyle(
              fontFamily: 'monospace',
              backgroundColor: Color(0xFFEEEEEE),
            ),
          ),
        ));
      }

      currentIndex = match.end;
    }

    // Add the remaining plain text
    if (currentIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(currentIndex),
        style: baseStyle,
      ));
    }

    return children;
  }
}
