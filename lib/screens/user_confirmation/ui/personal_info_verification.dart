import 'dart:io';

import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/user_confirmation/bloc/bloc_verification.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/id_verification.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/successful_screen.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/custom_app_bar.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '_vmodel.dart';

class PersonalInfoVerification extends StatefulWidget {
  const PersonalInfoVerification({Key? key}) : super(key: key);

  @override
  _PersonalInfoVerificationState createState() =>
      _PersonalInfoVerificationState();
}

class _PersonalInfoVerificationState extends State<PersonalInfoVerification> {
  PersonalInfoVModel? _vmodel;

  @override
  void initState() {
    super.initState();
    _vmodel = PersonalInfoVModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).verification,
        rootNavigator: true,
        bottom: const _BuildProgress(),
        height: 110,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 16.0,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocConsumer<BlocVerification, StateBlocVerification>(
                        builder: (context, state) {
                          if (state is StateVerificationFirstStep) {
                            return _BuildFirstStep(vmodel: _vmodel!);
                          }
                          if (state is StateVerificationSecondStep) {
                            return _BuildSecondStep(
                              vmodel: _vmodel!,
                              state: state,
                            );
                          }
                          if (state is StateVerificationThirdStep) {
                            return _BuildThirdStep();
                          }
                          if (state is StateVerificationFourthStep) {
                            return _BuildFourthStep(vmodel: _vmodel!);
                          }
                          return const SizedBox.shrink();
                        },
                        listener: (context, state) {}),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BlocConsumer<BlocVerification, StateBlocVerification>(
                    builder: (context, state) {
                      return _BuildFooter(
                        state: state,
                        vmodel: _vmodel!,
                      );
                    },
                    listener: (context, state) {}))
          ],
        ),
      ),
    );
  }
}

class _BuildProgress extends StatelessWidget implements PreferredSizeWidget {
  const _BuildProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BlocVerification, StateBlocVerification>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  ClipRRect(
                    child: LinearProgressIndicator(
                      value: _progressValue(state),
                      backgroundColor: ColorPalette.lightGrey,
                      valueColor:
                          const AlwaysStoppedAnimation(ColorPalette.blue),
                      minHeight: 6,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).personal_data,
                        style: ProjectTextStyles.ui_16Medium.copyWith(
                          color: ColorPalette.blue,
                        ),
                      ),
                      Text(
                        S.of(context).steps_count(_progressValue(state) == 0.25
                            ? 1
                            : _progressValue(state) == 0.5
                                ? 2
                                : _progressValue(state) == 0.75
                                    ? 3
                                    : 4),
                        style: ProjectTextStyles.ui_16Medium.copyWith(
                          color: ColorPalette.blue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  double _progressValue(state) {
    if (state is StateVerificationFirstStep) {
      return 0.25;
    }
    if (state is StateVerificationSecondStep) {
      return 0.5;
    }
    if (state is StateVerificationThirdStep) {
      return 0.75;
    }
    if (state is StateVerificationFourthStep) {
      return 1;
    }
    return 0;
  }

  @override
  Size get preferredSize => const Size.fromHeight(52);
}

class _BuildFirstStep extends StatelessWidget {
  final PersonalInfoVModel vmodel;

  const _BuildFirstStep({Key? key, required this.vmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vmodel.firstName,
        const SizedBox(
          height: 10,
        ),
        vmodel.lastName,
        const SizedBox(
          height: 10,
        ),
        vmodel.dateOfBirth,
        const SizedBox(
          height: 10,
        ),
        vmodel.iin,
      ],
    );
  }
}

class _BuildSecondStep extends StatelessWidget {
  final PersonalInfoVModel vmodel;
  final StateVerificationSecondStep state;

  const _BuildSecondStep({Key? key, required this.vmodel, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vmodel.carRightsNumber,
        const SizedBox(
          height: 10,
        ),
        vmodel.carRightsExpire,
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: ColorPalette.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              state.idImages == null
                  ? Image.asset(
                      "assets/images/png/identifications.png",
                      height: 90,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            height: 90,
                            child: Image.file(File(state.idImages!.first))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            height: 90,
                            child: Image.file(
                              File(state.idImages!.last),
                            )),
                      ],
                    ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: S.of(context).make_photo,
                        style: ProjectTextStyles.ui_16Medium
                            .copyWith(color: ColorPalette.darkGrey)),
                    TextSpan(
                        text: S.of(context).facial_side,
                        style: ProjectTextStyles.ui_16Medium
                            .copyWith(color: ColorPalette.blue)),
                    TextSpan(
                        text: S.of(context).and_from,
                        style: ProjectTextStyles.ui_16Medium
                            .copyWith(color: ColorPalette.darkGrey)),
                    TextSpan(
                        text: S.of(context).back_side,
                        style: ProjectTextStyles.ui_16Medium
                            .copyWith(color: ColorPalette.blue)),
                    TextSpan(
                        text: S.of(context).side_of_rights,
                        style: ProjectTextStyles.ui_16Medium
                            .copyWith(color: ColorPalette.darkGrey)),
                  ])),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  AppRouter.push(
                    context,
                    IdVerificationScreen(),
                    rootNavigator: true,
                  ).then((value) {
                    if (value is List<String>) {
                      context
                          .read<BlocVerification>()
                          .add(EventVerificationSecondStep(idImages: value));
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: ColorPalette.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).photograph,
                          style: ProjectTextStyles.ui_16Medium.copyWith(
                            color: ColorPalette.blue,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 3,
                          right: 15,
                          child: SvgPicture.asset(
                            "assets/images/svg/arrow_right.svg",
                            color: ColorPalette.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BuildThirdStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
              color: ColorPalette.lightGrey,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Image.asset("assets/images/png/verification_image.png"),
              const SizedBox(
                height: 15,
              ),
              Text(
                S.of(context).make_rights_with_face_photo,
                style: ProjectTextStyles.ui_16Medium.copyWith(
                  color: ColorPalette.darkGrey,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.blue),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).photograph,
                          style: ProjectTextStyles.ui_16Medium.copyWith(
                            color: ColorPalette.blue,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 3,
                          right: 15,
                          child: SvgPicture.asset(
                            "assets/images/svg/arrow_right.svg",
                            color: ColorPalette.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BuildFourthStep extends StatelessWidget {
  final PersonalInfoVModel vmodel;

  const _BuildFourthStep({Key? key, required this.vmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vmodel.carType,
        const SizedBox(
          height: 10,
        ),
        vmodel.carIssueDate,
        const SizedBox(
          height: 10,
        ),
        vmodel.carDimensions,
        const SizedBox(
          height: 10,
        ),
        vmodel.governmentNumber,
        const SizedBox(
          height: 10,
        ),
        vmodel.registrationCertificate,
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: ColorPalette.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                S.of(context).load_photo,
                style: ProjectTextStyles.ui_16Medium.copyWith(
                  color: ColorPalette.darkGrey,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.blue),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).load_data,
                          style: ProjectTextStyles.ui_16Medium.copyWith(
                            color: ColorPalette.blue,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 3,
                          right: 15,
                          child: SvgPicture.asset(
                            "assets/images/svg/arrow_right.svg",
                            color: ColorPalette.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}

class _BuildFooter extends StatelessWidget {
  final state;
  final PersonalInfoVModel vmodel;

  const _BuildFooter({Key? key, required this.state, required this.vmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        state is! StateVerificationFirstStep &&
                state is! StateVerificationInitial
            ? Row(
                children: [
                  MainButton(
                    buttonHeight: 55,
                    width: 55,
                    onTap: () {
                      if (state is StateVerificationSecondStep) {
                        context
                            .read<BlocVerification>()
                            .add(EventVerificationFirstStep());
                      }
                      if (state is StateVerificationThirdStep) {
                        context
                            .read<BlocVerification>()
                            .add(EventVerificationSecondStep());
                      }
                      if (state is StateVerificationFourthStep) {
                        context
                            .read<BlocVerification>()
                            .add(EventVerificationThirdStep());
                      }
                    },
                    borderRadius: 10,
                    borderColor: ColorPalette.blue,
                    color: Colors.transparent,
                    icon: "assets/images/svg/arrow_left.svg",
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                ],
              )
            : const SizedBox(),
        Expanded(
          child: MainButton(
            title: S.of(context).next_step,
            onTap: () {
              if (state is StateVerificationFirstStep
                  // && vmodel.firstStepValidated
                  ) {
                context
                    .read<BlocVerification>()
                    .add(EventVerificationSecondStep());
              }
              if (state is StateVerificationSecondStep
                  // && vmodel.secondStepValidated
                  ) {
                context
                    .read<BlocVerification>()
                    .add(EventVerificationThirdStep());
              }
              if (state is StateVerificationThirdStep) {
                context
                    .read<BlocVerification>()
                    .add(EventVerificationFourthStep());
              }
              if (state is StateVerificationFourthStep
                  // && vmodel.lastStepValidated
              ) {
                AppRouter.push(context, SuccessfulScreen());
                // context
                //     .read<BlocVerification>()
                //     .add(EventVerificationFourthStep());
              }
            },
          ),
        )
      ]),
    );
  }
}
