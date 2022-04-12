import 'dart:ui';

import 'package:flutter/material.dart';

class UploadView extends StatelessWidget {
  const UploadView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(child: FlutterLogo()),
      Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),

              )),
        ),
      ],
    );
  }
}