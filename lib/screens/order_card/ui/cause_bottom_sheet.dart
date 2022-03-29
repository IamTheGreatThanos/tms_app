import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

List<String> items = [
  "Перекус - 3 раза в сутки",
  "Сон - 1 раз в сутки",
  "Перерыв на 15 минут - 3 раз в сутки",
  "Другая причина",
  "Передаю заказ другому водителю",
];

void showCauseBottomSheet(BuildContext context) {
  showAppBottomSheet(context,
          initialChildSize: 0.45, useRootNavigator: true, child: BuildCauses());
}

class BuildCauses extends StatefulWidget {
  const BuildCauses({Key? key}) : super(key: key);

  @override
  _BuildCausesState createState() => _BuildCausesState();
}

class _BuildCausesState extends State<BuildCauses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              "Выберите причину остановки",
              style: ProjectTextStyles.ui_20Medium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorPalette.lightGrey,
            ),
            child: Text(
              "Частые опции",
              style: ProjectTextStyles.ui_12Medium
                  .copyWith(color: ColorPalette.darkGrey),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(items[index]);
                  },
                  child: _BuildItem(
                    item: items[index],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: ColorPalette.lightGrey,
                );
              },
              itemCount: items.length)
        ],
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  final String item;

  const _BuildItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            item,
            style: ProjectTextStyles.ui_16Medium,
            overflow: TextOverflow.ellipsis,
          )),
          SvgPicture.asset("assets/images/svg/chevrone_right.svg")
        ],
      ),
    );
  }
}
