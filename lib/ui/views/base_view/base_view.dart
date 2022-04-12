import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/view_models/base_view_model/base_view_model.dart';
import 'package:instagram_clone/ui/views/home_screen/home_screen_body.dart';
import 'package:instagram_clone/ui/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BaseViewModel>(
      builder: (BuildContext context, baseViewProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Stack(fit: StackFit.expand, children: [
              baseViewProvider
                  .allViews[baseViewProvider.getCurrentBottomNavIndex],
              ...[
                if (baseViewProvider.getCurrentBottomNavIndex == 2)
                  Positioned.fill(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6.0,
                          sigmaY: 6.0,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        )),
                  ),
                if (baseViewProvider.getCurrentBottomNavIndex == 2)
                  _uploadBox(context)
              ],
              Positioned(left: 0, right: 0, bottom: 6, child: MyBottomNavBar()),
            ]),
          ),
        );
      },
    );
  }

  Positioned _uploadBox(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 40,
      right: 40,
      child: Container(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Upload",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){

                    Navigator.pushNamed(context, Routes.addPost);
                  },
                  child: _buildContainers(
                    context,
                    "Photo",
                    Icons.perm_media_outlined,
                  ),
                ),
                _buildContainers(
                  context,
                  "Status",
                  Icons.sms_outlined,
                ),
                _buildContainers(
                  context,
                  "Video",
                  Icons.play_arrow_outlined,
                )
              ],
            ),
          )
        ]),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        height: 20.h,
        width: double.infinity,
      ),
    );
  }

  Container _buildContainers(
      BuildContext context, String option, IconData icon) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .secondary
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(18)),
        height: 10.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadiantGradientMask(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              option,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 8.sp,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        width: 18.w);
  }
}
