import 'dart:ui';

import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/personal_data_screen/ui/widgets/_vmodel.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/_vmodel.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/custom_app_bar.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({Key? key}) : super(key: key);

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final PersonalDataVModel _vmodel = PersonalDataVModel();

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).personal_data,
      ),
      backgroundColor: ColorPalette.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            children: [
              const Center(
                child: _BuildAvatar(),
              ),
              const SizedBox(
                height: 20,
              ),
              _BuildPersonalData(
                vmodel: _vmodel,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).contacts,
                      style: ProjectTextStyles.ui_20Medium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).email,
                      style: ProjectTextStyles.ui_16Medium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _vmodel.email,
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).phone_number,
                      style: ProjectTextStyles.ui_16Medium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _vmodel.phoneNumber,
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).password,
                      style: ProjectTextStyles.ui_20Medium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).current_password,
                      style: ProjectTextStyles.ui_16Medium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _vmodel.currentPassword,
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).new_password,
                      style: ProjectTextStyles.ui_16Medium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _vmodel.newPassword,
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).repeat_password,
                      style: ProjectTextStyles.ui_16Medium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _vmodel.repeatPassword,
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MainButton(onTap: (){},
                color: ColorPalette.green,
                title: "Сохранить",
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildAvatar extends StatelessWidget {
  const _BuildAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Stack(
        children: [
          const SizedBox(
            width: 105,
            height: 105,
          ),
          Image.asset(
            "assets/images/png/profile_photo.png",
            width: 105,
            height: 105,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 78,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(50, 50, 50, 0.4),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                ),
              )),
          Positioned.fill(
              bottom: 6,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/svg/camera.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      S.of(context).load_data,
                      textAlign: TextAlign.center,
                      style: ProjectTextStyles.ui_10Regular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.white,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class _BuildPersonalData extends StatelessWidget {
  final PersonalDataVModel vmodel;

  const _BuildPersonalData({Key? key, required this.vmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).personal_data,
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).first_name,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.name,
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).last_name,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.lastName,
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).country,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.country,
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).city,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.city,
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).company_name,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.companyName,
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).referal_code,
            style: ProjectTextStyles.ui_16Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          vmodel.referalCode,
        ],
      ),
    );
  }
}
