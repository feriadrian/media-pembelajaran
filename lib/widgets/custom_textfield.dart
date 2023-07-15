import 'package:flutter/material.dart';
import 'package:skripsi/config/config.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    this.validator,
    this.hintText,
    this.controller,
    this.isWrap = false,
    this.obscureText = true,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.icon,
    this.onTapPassWord,
    this.keyboard,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  final bool isWrap;
  final bool readOnly;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final Function()? onTapPassWord;
  final bool obscureText;
  final Icon? icon;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TextFormField(
      keyboardType: keyboard,
      obscureText: icon != null ? obscureText : false,
      onTap: onTap,
      minLines: isWrap ? 3 : 1,
      maxLines: isWrap ? 6 : 1,
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      decoration: icon != null
          ? InputDecoration(
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: onTapPassWord,
                child: icon,
              ),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                vertical: getHeight(12),
                horizontal: getWidht(24),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : InputDecoration(
              isDense: true,
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                vertical: getHeight(12),
                horizontal: getWidht(24),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
    );
  }
}
