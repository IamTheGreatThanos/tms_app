import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainText extends StatelessWidget {
  final String title;
  final List<String> descriptions;
  final SvgPicture? descriptionIcon;

  const MainText({
    Key? key,
    required this.title,
    required this.descriptions,
    this.descriptionIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: title),
        const SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: descriptions
              .map((description) => _Description(
                    icon: descriptionIcon,
                    description: description,
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: ProjectTextStyles.ui_16Semi.copyWith(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String description;
  final SvgPicture? icon;

  const _Description({Key? key, required this.description, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon ?? const SizedBox.shrink(),
              if (icon != null) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  description,
                  style: ProjectTextStyles.ui_14Regular.copyWith(),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
