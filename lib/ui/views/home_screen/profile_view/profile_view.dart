import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/utils/services/dialogs/circular_progress_bar.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/ui/views/auth/login_screen.dart';
import 'package:instagram_clone/ui/views/home_screen/profile_view/user_media_view/user_media.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
        builder: (context, homeViewProvider, child) => DefaultTabController(
              length: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.pexels.com/photos/1496372/pexels-photo-1496372.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 84,
                                        width: 84,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                          ]),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: DecoratedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: ClipOval(
                                                  child: Container(
                                                    child: CachedImage(
                                                        homeViewProvider
                                                            .firebaseUser!
                                                            .photoUrl),
                                                    height: 7.h,
                                                    width: 15.w,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ))),
                                    _options(context, "703", "Post"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    _options(context, "115k", "Followers"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    _options(context, "12", "Following"),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 18),
                                        child: Icon(Icons.arrow_downward,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            size: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text(homeViewProvider.firebaseUser!.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 11.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontWeight: FontWeight.bold,
                                        )),
                                // Text( homeViewProvider.firebaseUser!.username,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //             fontSize: 10.sp,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .onPrimary)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TabBar(
                                        indicatorColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        labelColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 11.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontWeight: FontWeight.bold),
                                        unselectedLabelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 11.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                        tabs: [
                                          Tab(
                                            text: "Media",
                                          ),
                                          Tab(
                                            text: "Status",
                                          ),
                                          Tab(
                                            text: "Bio",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    Icon(
                                      Icons.apps_outlined,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(children: [
                                    UserMedia(),
                                    Container(),
                                    Container(
                                      child: Column(children: [
                                        Text(homeViewProvider.firebaseUser!.bio,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  fontSize: 10.sp,
                                                )),
                                      ]),
                                    )
                                  ]),
                                )
                              ]),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xfff9f9f9),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(22),
                                topLeft: Radius.circular(22))),
                        height: 70.h,
                        width: double.infinity,
                      )),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.black,
                          ),
                        ),
                      )),
                  Positioned(
                      top: 40,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    onTap: (){

                                      log(context.read<LoginViewModel>().signInProvider.toString());

                                       var loginView = context.read<LoginViewModel>();
                          homeViewProvider.firebaseAuth.signOut().then((value) {
                          
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);


                            switch (
                                context.read<LoginViewModel>().signInProvider) {
                              case 'google':
                                loginView.signOutGoogle();
                                break;
                              case 'facebook':
                                // loginView.signOutFacebook();
                                break;

                              default:
                            }
                            StorageService()
                                .saveToDisk(DbKeys.isUserLoggedIn, false);
                          });
                                    },
                                    child: Text("Logout"),
                                    value: 1,
                                  ),
                                ];
                              },
                              child: Icon(
                                Icons.more_vert_outlined,
                              )),
                        ),
                      )),
                ],
              ),
            ));
  }

  Widget _options(BuildContext context, String data, title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffffffff), borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(data,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 10.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold)),
            Text(title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 8.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.7),
                    ))
          ]),
        ),
      ),
    );
  }
}
