import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/user_confirmation/bloc/bloc_verification.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/personal_info_verification.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorPalette.grey,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 10,
          ),
          child: Column(
            children: const[
              _BuildConfirmation(),
              SizedBox(
                height: 16,
              ),
              _BuildUserInfo(),
              SizedBox(
                height: 16,
              ),
              _BuildProfileMenu(),
              SizedBox(
                height: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildConfirmation extends StatelessWidget {
  const _BuildConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                const PersonalInfoVerification(),
                rootNavigator: true,
              ).then((value) {
                context
                    .read<BlocVerification>()
                    .add(EventInitialVerification());
              });
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
                      child:
                          SvgPicture.asset("assets/images/svg/arrow_right.svg"))
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
    );
  }
}

class _BuildUserInfo extends StatelessWidget {
  const _BuildUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                "assets/images/png/profile_photo.png",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Самат Саматов",
                style: ProjectTextStyles.ui_20Medium.copyWith(
                    color: ColorPalette.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: SvgPicture.asset(
                          "assets/images/svg/${index == 4 ? "half_" : ""}filled_star.svg"),
                    );
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Рейтинг 4.78",
                    style: ProjectTextStyles.ui_14Medium.copyWith(
                      color: ColorPalette.commonGrey,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildProfileMenu extends StatelessWidget {
  const _BuildProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        right: 15,
        left: 15,
      ),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BuildMenuItem(
            icon: "personal_data",
            title: S.of(context).personal_data,
            onTap: () {},
          ),
          _BuildMenuItem(
            icon: "ride_history",
            title: S.of(context).ride_history,
            onTap: () {},
          ),
          _BuildMenuItem(
            icon: "documents",
            title: S.of(context).documents,
            onTap: () {},
          ),
          _BuildMenuItem(
            icon: "help",
            title: S.of(context).help,
            onTap: () {},
          ),
          _BuildMenuItem(
            icon: "settings",
            title: S.of(context).settings,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _BuildMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _BuildMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.fieldGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  "assets/images/svg/$icon.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: ProjectTextStyles.ui_16Medium,
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/images/svg/chevrone_right.svg",
            width: 24,
            height: 24,
          )
        ],
      ),
    );
  }
}
