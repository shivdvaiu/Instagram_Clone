import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldLight extends StatelessWidget {
  final TextEditingController controller;
  final bool isObsecure;
  final String hintText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType textInputType;

  const TextFieldLight(
      {Key? key,
      required this.controller,
      this.isObsecure = false,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputType = TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    final inputBorder = OutlineInputBorder(
      borderSide:
          Divider.createBorderSide(context, color: Colors.white, width: 1.5),
    );

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xffeaefff),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: TextField(
        cursorColor: colorScheme.background,
        onChanged: (value) {},
        style: textTheme.bodyText2!
            .copyWith(fontSize: 10.sp, color: colorScheme.primary),
        controller: controller,
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: textTheme.bodyText2!.copyWith(
              fontSize: 12,
              letterSpacing: 0.50,
              color: colorScheme.secondaryContainer),
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: false,
        ),
        keyboardType: textInputType,
        obscureText: isObsecure,
      ),
    );
  }
}
