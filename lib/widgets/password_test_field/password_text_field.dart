import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///Base password text field inspired by main text field
class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final int? maxLines;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final bool isPasswordField = true;
  final bool isValidationActivated;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.maxLines,
    this.onChanged,
    this.onEditingComplete, this.validate, this.isValidationActivated = true,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validate,
      onEditingComplete: widget.onEditingComplete,
      obscureText: isPasswordHidden,
      enableSuggestions: !widget.isPasswordField,
      autocorrect: !widget.isPasswordField,
      maxLines: widget.isPasswordField ? 1 : widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      style: ProjectTextStyles.ui_14Regular.copyWith(
        color: ColorPalette.black,
      ),
      decoration: InputDecoration(
        errorStyle: widget.isValidationActivated ? null : TextStyle(height: 0,  color: Colors.transparent),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        hintText: widget.hintText,
        suffixIcon: _getSuffixIcon(),
        hintStyle: ProjectTextStyles.ui_14Regular.copyWith(
          color: ColorPalette.lightGray,
          height: 1.0,
        ),
        border: _buildBorder(),
        focusedBorder: _buildBorder(),
        errorBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        focusedErrorBorder: _buildBorder(),
      ),
    );
  }

  Widget? _getSuffixIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          isPasswordHidden = !isPasswordHidden;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.25,
          horizontal: 20.11,
        ),
        child: isPasswordHidden
            ? SvgPicture.asset('assets/icons_svg/ic_hide_password.svg')
            : SvgPicture.asset(
                'assets/icons_svg/ic_hide_password.svg',
                color: ColorPalette.black,
              ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color color = ColorPalette.borderLightGray}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
