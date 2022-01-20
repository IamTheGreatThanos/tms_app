import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? icon;

  const PrimaryTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Row(
                  children: [icon!, const SizedBox(width: 12)],
                )
              : const SizedBox.shrink(),
          Text(
            title,
            style:
                ProjectTextStyles.ui_14Semi.copyWith(color: ColorPalette.main),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
