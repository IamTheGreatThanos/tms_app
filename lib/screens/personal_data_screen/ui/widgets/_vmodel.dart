import 'package:country_code_picker/country_code_picker.dart';
import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/constants.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalDataVModel extends Cubit<_StateVModel> {
  late final name = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
  );
  late final lastName = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
  );
  late final companyName = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
  );
  late final email = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
  );
  late final phoneNumber = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: CountryCodePicker(
          onChanged: (value) {},
          initialSelection: 'KZ',
          favorite: ['+7', 'KZ'],
          flagWidth: 19,
          padding: EdgeInsets.zero,
          alignLeft: true,
          showDropDownButton: true,
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: AppTextField(
          keyboardType: TextInputType.phone,
          fillColor: ColorPalette.white,
          enabledBorder: defaultBorder,
          focusedBorder: defaultBorder,
          inputFormatters: [maskPhoneFormatter],
        ),
      ),
    ],
  );

  late final referalCode = AppTextField(
    fillColor: ColorPalette.lightGrey,
    readonly: true,
    style: ProjectTextStyles.ui_16Medium.copyWith(
      color: ColorPalette.darkGrey,
    ),
    controller:
        TextEditingController(text: "SATTI-N000001-D01202114-T1229-C1..."),
  );
  late final country = DropdownButtonFormField(
    iconSize: 24,
    value: countryValue,
    decoration: const InputDecoration(
      hintStyle: ProjectTextStyles.ui_16Medium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: ColorPalette.commonGrey,
          width: 1,
        ),
      ),
      filled: true,
      contentPadding: EdgeInsets.all(16),
      fillColor: Colors.white,
    ),
    items: countries.map((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Выберите страну';
      }
      return null;
    },
    onChanged: (e) {
      countryValue = e.toString();
    },
  );
  late final city = DropdownButtonFormField(
    iconSize: 24,
    value: cityValue,
    decoration: const InputDecoration(
      hintStyle: ProjectTextStyles.ui_16Medium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: ColorPalette.commonGrey,
          width: 1,
        ),
      ),
      filled: true,
      contentPadding: EdgeInsets.all(16),
      fillColor: Colors.white,
    ),
    items: cities.map((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Выберите город';
      }
      return null;
    },
    onChanged: (e) {
      countryValue = e.toString();
    },
  );

  late final currentPassword = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
    obscureText: true,
    onChanged: updateIsPasswordValidated,
    isVisibleObscureButton: true,
  );
  late final newPassword = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
    obscureText: true,
    validator: (value) => _passwordValidator(value!),
    onChanged: updateIsPasswordValidated,
    isVisibleObscureButton: true,
  );

  late final repeatPassword = AppTextField(
    fillColor: ColorPalette.white,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
    obscureText: true,
    validator: (value) => _passwordValidator(value!),
    onChanged: updateIsPasswordValidated,
    isVisibleObscureButton: true,
  );

  PersonalDataVModel() : super(
    const _StateVModel(
      isValidated: false,
    ),
  );

  List<String> _passwordValidator(String value) {
    List<String> output = [];
    if (value.isEmpty) {
      output.add(S.current.fill_field);
    }
    if (newPassword.controller.text != repeatPassword.controller.text) {
      output.add(S.current.passwordNotMatching);
    }
    return output;
  }

  void updateIsPasswordValidated(String? value) {
    newPassword.validated;
    repeatPassword.validated;
    emit(
      _StateVModel(
        isValidated: newPassword.controller.text.isNotEmpty &&
            repeatPassword.controller.text.isNotEmpty &&
            newPassword.controller.text == repeatPassword.controller.text,
      ),
    );
  }

  List<String> countries = ["Казахстан"];
  List<String> cities = [
    "Алматы",
    "Астана",
    "Кокшетау",
    "Шымкент",
  ];
  late String countryValue = countries.first;
  late String cityValue = cities.first;

  InputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(
      color: ColorPalette.commonGrey,
      width: 1.0,
    ),
  );
}

class _StateVModel {
  const _StateVModel({
    required this.isValidated,
  });

  final bool isValidated;
}
