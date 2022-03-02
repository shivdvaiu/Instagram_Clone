import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final EdgeInsetsGeometry padding;
  MyElevatedButton(
      {required this.onPressed,
      required this.buttonName,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondaryVariant,
          padding: padding),
      onPressed: onPressed,
      child: Text(buttonName,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white)),
    );
  }
}
