import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWithButton extends StatelessWidget {
  final String title;
  final String tappableTitle;
  final VoidCallback onTap;
  const RichTextWithButton({Key? key, required this.title, required this.tappableTitle, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: ProjectTextStyles.ui_14Regular.copyWith(
            color: ColorPalette.gray,
          ),
          children: [
            TextSpan(text: title),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = onTap,
              text: ' ' + tappableTitle,
              style: ProjectTextStyles.ui_14Semi.copyWith(
                color: ColorPalette.main,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
