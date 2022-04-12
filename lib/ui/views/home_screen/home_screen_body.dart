import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/ui/views/home_screen/post_card_view/post_card_view.dart';
import 'package:instagram_clone/ui/widgets/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // StorageService().saveToDisk(DbKeys.isUserLoggedIn, false);
      //   final FacebookAuth _facebookLogin = FacebookAuth.instance;
      //   _facebookLogin.logOut();
    context.read<HomeViewModel>().fetchUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /// Chats and edit
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText("Social",
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primaryContainer
                        ],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.4),
                              blurRadius: 3.0,
                              offset: Offset(1, 3)),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.8),
                          size: 32,
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 2.h,
            ),

            _horizontalUsersContainers(),

            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(DbKeys.userPosts)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PostCard(
                            userPost:
                                Post.fromSnap(snapshot.data!.docs[index]))),
                  );
                },
              ),
            ),
            SizedBox(height: 100,)
          ]),
        ),
      ),
    );
  }

  // Widget _usersCard(BuildContext context) {
  Container _horizontalUsersContainers() {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: Constants.usersModelTwo.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(2),
                      child: DecoratedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Container(
                              child: Image.network(
                                  Constants
                                      .usersModelTwo[index].userNetworkImage,
                                  fit: BoxFit.cover),
                              height: 7.h,
                              width: 15.w,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ))),
              SizedBox(
                height: 4,
              ),
              Expanded(
                child: Text(
                  Constants.usersModelTwo[index].userName,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 9.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _cardBottom(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              RadiantGradientMask(
                  child: Icon(
                Icons.chat,
                color: Colors.white,
              )),
              SizedBox(
                width: 10,
              ),
              Text(
                "12",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 10.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(
                width: 20,
              ),
              RadiantGradientMask(
                  child: Icon(Icons.favorite, color: Colors.white)),
              Text(
                "10",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 10.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(
                width: 20,
              ),
              RadiantGradientMask(child: Icon(Icons.send, color: Colors.white)),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          RadiantGradientMask(
            child: Icon(
              Icons.bookmark_outlined,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: ([
                Color.fromARGB(255, 211, 224, 243),
                Color(0xffDFE9FA),
              ]))),
      height: 50,
    );
  }

  SizedBox _verticalSpace() => SizedBox(height: 20);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Color(0xff8a4cff),
          Color.fromARGB(255, 142, 168, 209),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}



  // StreamBuilder(
              //   stream:
              //       FirebaseFirestore.instance.collection(DbKeys.userPosts).snapshots(),
              //   builder: (context,
              //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
      
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     return ListView.builder(
              //       cacheExtent: 9999,
              //       itemCount: snapshot.data!.docs.length,
              //       itemBuilder: (ctx, index) => Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: PostCard(
              //               userPost: Post.fromSnap(snapshot.data!.docs[index]))),
              //     );
              //   },
              // ),