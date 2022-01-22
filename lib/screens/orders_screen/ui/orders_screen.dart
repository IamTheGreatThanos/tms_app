import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/personal_info_verification.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/_utils/app_router.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<String> cities = [
    "Нур-Султан",
    "Алмата",
    "Шымкент",
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/svg/location.svg"),
                    SizedBox(
                      width: 150,
                      child: DropdownButtonFormField(
                        iconSize: 0,
                        value: selectedValue,
                        decoration: InputDecoration(
                          suffixIcon: SvgPicture.asset(
                            "assets/images/svg/dropdown_arrow.svg",
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            maxWidth: 24,
                            maxHeight: 24,
                          ),
                          isDense: false,
                          hintStyle: ProjectTextStyles.ui_16Medium,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: Colors.white,
                        ),
                        items: cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Выберите город';
                          }
                          return null;
                        },
                        onChanged: (e) {
                          selectedValue = e.toString();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/images/svg/filter.svg"),
                    const SizedBox(
                      width: 22,
                    ),
                    SvgPicture.asset("assets/images/svg/notifications.svg"),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ColorPalette.commonBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorPalette.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: SvgPicture.asset(
                      "assets/images/svg/user_confirmation.svg",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S.of(context).confirm_identity,
                    style: ProjectTextStyles.ui_20Medium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    S.of(context).get_access,
                    style: ProjectTextStyles.ui_16Medium
                        .copyWith(color: ColorPalette.darkGrey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.push(
                        context,
                        PersonalInfoVerification(),
                        rootNavigator: true,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: ColorPalette.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              S.of(context).do_verification,
                              style: ProjectTextStyles.ui_16Medium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 3,
                              right: 15,
                              child: SvgPicture.asset(
                                  "assets/images/svg/arrow_right.svg"))
                        ],
                      ),
                    ),
                  ),
                  // MainButton(
                  //   onTap: () {},
                  //   title: S.of(context).do_verification,
                  // )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  S.of(context).no_orders,
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: ColorPalette.commonGrey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
