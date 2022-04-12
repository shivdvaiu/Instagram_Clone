import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/view_models/base_view_model/base_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyBottomNavBar extends StatelessWidget {
  MyBottomNavBar();
  final List<String> bottomNavOptions = [
    "HOME",
    "CHAT",
    "",
    "ALERT",
    "PROFILE"
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.chat,
    Icons.add_box_outlined,
    Icons.notifications,
    Icons.person_outline_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).colorScheme.onSurface),
              height: 10.h,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    icons.length,
                    (index) => buildNavItem(context, bottomNavOptions[index],
                        icons[index], index))),
          )
        ],
      ),
    );
  }

  Widget buildNavItem(BuildContext context, String text, IconData iconData,
      int currentTabIndex) {
    return Consumer<BaseViewModel>(
        builder: (BuildContext context, baseViewProvider, Widget? child) =>
            GestureDetector(
              onTap: () {
               
                baseViewProvider.setCurrentBottomNavIndex = currentTabIndex;
                
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: baseViewProvider.getCurrentBottomNavIndex ==
                            currentTabIndex
                        ? 25
                        : 0),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// for selected icon
                      ...[
                        if (baseViewProvider.getCurrentBottomNavIndex ==
                            currentTabIndex)
                          _buildCircularIcon(context, iconData),
                        if (baseViewProvider.getCurrentBottomNavIndex ==
                            currentTabIndex)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: GradientText(
                              text,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.primaryContainer
                              ],
                            ),
                          )
                      ],

                      /// For unselected icon
                      ...[
                        if (baseViewProvider.getCurrentBottomNavIndex !=
                            currentTabIndex)
                          Icon(
                            iconData,
                            color: Colors.grey,
                          )
                      ]
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildCircularIcon(BuildContext context, IconData icon) {
    return Container(
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      height: 5.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.surface,
                blurRadius: 5.0,
                offset: Offset(1, 7)),
          ],
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: ([
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer
              ]))),
      width: 5.h,
    );
  }
}
