import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeViewProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 17.h,
                ),
                Center(
                  child: Container(
                    height: 20.h,
                    width: 40.w,
                    child: ClipOval(
                      child: CachedImage(
                           homeViewProvider.firebaseUser!.photoUrl),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  homeViewProvider.firebaseUser!.username,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  homeViewProvider.firebaseUser!.email,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 10.sp,
                      ),
                ),
                Text(
                  homeViewProvider.firebaseUser!.bio,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 10.sp,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    trailing: CupertinoSwitch(
                      value: context.read<ThemeViewModel>().isLightMode,
                      onChanged: (value) {
                        context.read<ThemeViewModel>().changeTheme();
                      },
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: Theme.of(context).colorScheme.secondaryVariant,
                    leading: Text(
                      "Change Theme",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      );
    });
  }
}
