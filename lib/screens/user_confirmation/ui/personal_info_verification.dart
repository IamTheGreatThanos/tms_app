import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/user_confirmation/bloc/bloc_verification.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalInfoVerification extends StatefulWidget {
  const PersonalInfoVerification({Key? key}) : super(key: key);

  @override
  _PersonalInfoVerificationState createState() =>
      _PersonalInfoVerificationState();
}

class _PersonalInfoVerificationState extends State<PersonalInfoVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.of(context).verification,
          style: ProjectTextStyles.ui_20Medium,
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/images/svg/arrow_back.svg",
            color: ColorPalette.black,
          ),
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop();
          },
        ),
        bottom: const _BuildProgress(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            BlocConsumer<BlocVerification, StateBlocVerification>(
                builder: (context, state) {
                  if (state is StateVerificationFirstStep) {
                    return const _BuildFirstStep();
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {}),
            const Spacer(),
            BlocConsumer<BlocVerification, StateBlocVerification>(
                builder: (context, state) {
                  return _BuildFooter(state: state);
                },
                listener: (context, state) {})
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
                      backgroundColor: ColorPalette.fieldGrey,
                      valueColor: const AlwaysStoppedAnimation(ColorPalette.blue),
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(52);
}

class _BuildFirstStep extends StatelessWidget {
  const _BuildFirstStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          hintText: S.of(context).first_name,
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          hintText: S.of(context).last_name,
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          hintText: S.of(context).date_of_birth,
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          hintText: S.of(context).iin,
        ),
      ],
    );
  }
}

class _BuildFooter extends StatelessWidget {
  final state;

  const _BuildFooter({Key? key, required this.state}) : super(key: key);

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
                    onTap: () {},
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
            onTap: () {},
          ),
        )
      ]),
    );
  }
}
