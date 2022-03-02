import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 10.w,vertical: 10),
      child: Container(
           decoration: BoxDecoration( color: Theme.of(context).colorScheme.secondaryVariant,borderRadius: BorderRadius.circular(2)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10.sp,color: Theme.of(context).colorScheme.secondaryVariant),
            controller: textEditingController,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10.sp),
              hintText: hintText,
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
            ),
            keyboardType: textInputType,
            obscureText: isPass,
          ),
        ),
      ),
    );
  }
}
