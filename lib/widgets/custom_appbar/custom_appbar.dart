import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


///Appbar with title under leading
class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  ///Title of appbar
  final String title;
  ///Elevation of appbar
  final double elevation;
  ///Height of title
  static const double titleHeight = 32.0;
  final bool canBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.elevation = 0, this.canBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.white,
      leading: canBack ? IconButton(
        icon: SvgPicture.asset('assets/icons_svg/ic_arrow_left.svg'),
        onPressed: () {
          Navigator.pop(context);
        },
      ) : null,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: ProjectTextStyles.ui_22Medium
                  .copyWith(color: ColorPalette.black),
            ),
          ),
        ],
      ),
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}
