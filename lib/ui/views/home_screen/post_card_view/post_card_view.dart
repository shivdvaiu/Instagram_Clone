import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/extensions/calculate_time_ago.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/utils/services/push_notifications/firebase_notification.dart';
import 'package:instagram_clone/business_logic/utils/services/snack_bar/snack_bar.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/post_view_model/post_view_model.dart';
import 'package:instagram_clone/ui/views/home_screen/home_screen_body.dart';
import 'package:instagram_clone/ui/widgets/glassmorphism.dart';
import 'package:instagram_clone/ui/widgets/like_animation.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class PostCard extends StatelessWidget {
  final FirebaseFirestore _cloudFirestore =
      serviceLocator.get<FirebaseFirestore>();

  final Post userPost;
  PostCard({required this.userPost});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
        builder: (BuildContext context, postCardProvider, Widget? child) =>
            GestureDetector(
              onDoubleTap: () {
                /// On double tap liking current post
                postCardProvider
                    .likePost(
                        userPost.postId,
                        context.read<HomeViewModel>().firebaseUser!.uid,
                        userPost.likes)
                    .then((likePostState) {
                  switch (likePostState) {
                    case LikePostState.UNKNOWN_ERROR:
                      showSnackBar(context, Strings.unknownError);
                      break;

                    case LikePostState.POST_LIKED:
                      postCardProvider.setAnimation = true;
                      break;
                  }
                });
                postCardProvider.setAnimation = true;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 54.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: ClipOval(
                                        child: CachedImage(
                                            userPost.currentUserProfilePicture),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _topCard(1, context, postCardProvider,
                                            userPost.username),
                                        Text(
                                          userPost.username,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 10.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(fit: StackFit.expand, children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      child: CachedImage(
                                        userPost.postUrl,
                                        radius: 12,
                                      ),
                                      height: 40.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: GlassMorphism(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            height: 6.h,
                                          ),
                                          start: 0.5,
                                          end: 0.3)),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 5,
                                    child: Row(
                            
                                      children: [
                                        Row(children: [
                                          IconButton(
                                            icon: RadiantGradientMask(
                                              child: const Icon(
                                                Icons.comment_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  Routes.commentsScreen,
                                                  arguments: [userPost]);
                                            },
                                          ),
                                          StreamBuilder(
                                              stream: _cloudFirestore
                                                  .collection(
                                                      DbKeys.userPosts)
                                                  .doc(userPost.postId)
                                                  .collection(
                                                      DbKeys.comments)
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          QuerySnapshot<
                                                              Map<String,
                                                                  dynamic>>>
                                                      snapshot) {
                                                if (snapshot
                                                        .connectionState ==
                                                    ConnectionState
                                                        .waiting) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 4),
                                                  );
                                                }
                                                return InkWell(
                                                  child: Container(
                                                    child: _gradientText(
                                                        context,
                                                        snapshot.data!.docs
                                                            .length
                                                            .toString()),
                                                    padding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 4),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes
                                                            .commentsScreen,
                                                        arguments: [
                                                          userPost
                                                        ]);
                                                  },
                                                );
                                              }),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          LikeAnimation(
                                            isAnimating: userPost.likes
                                                .contains(context
                                                    .read<HomeViewModel>()
                                                    .firebaseUser!
                                                    .uid),
                                            smallLike: true,
                                            child: IconButton(
                                              icon: userPost.likes.contains(
                                                      context
                                                          .read<
                                                              HomeViewModel>()
                                                          .firebaseUser!
                                                          .uid)
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                  : RadiantGradientMask(
                                                      child: Icon(
                                                        Icons
                                                            .favorite_border,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                              onPressed: () {
                                                /// On double tap liking current post
                                                postCardProvider
                                                    .likePost(
                                                        userPost.postId,
                                                        context
                                                            .read<
                                                                HomeViewModel>()
                                                            .firebaseUser!
                                                            .uid,
                                                        userPost.likes)
                                                    .then((likePostState) {
                                                  switch (likePostState) {
                                                    case LikePostState
                                                        .UNKNOWN_ERROR:
                                                      showSnackBar(
                                                          context,
                                                          Strings
                                                              .unknownError);
                                                      break;

                                                    case LikePostState
                                                        .POST_LIKED:
                                                      sendMessageUsingFcm(
                                                          fcmToken:
                                                              FirebaseMethods
                                                                  .fcmToken!,
                                                          message:
                                                              "Liked Message",
                                                          title: 'Liked');
                                                      postCardProvider
                                                              .setAnimation =
                                                          true;
                                                      break;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          _gradientText(
                                              context,
                                              userPost.likes.length
                                                  .toString()),
                                         
                                        ]),
                                      Spacer(),
                                        Expanded(
                                          child: _gradientText(
                                              context,
                                              displayTimeAgoFromTimestamp(
                                                  userPost.datePublished
                                                      .toDate()
                                                      .toString())),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Spacer(),
                            // _cardBottom(context)
                          ]),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: postCardProvider.getAnimationFlag ? 1 : 0,
                        child: LikeAnimation(
                          isAnimating: postCardProvider.getAnimationFlag,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 100,
                          ),
                          duration: const Duration(
                            milliseconds: 400,
                          ),
                          onEnd: () {
                            postCardProvider.setAnimation = false;
                          },
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ));
  }

  GradientText _gradientText(BuildContext context, text) {
    return GradientText(
      text,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 10.sp,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold),
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primaryContainer
      ],
    );
  }

  Widget _topCard(
      int index, BuildContext context, postCardProvider, String name) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12.sp,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                height: 2.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueAccent),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Icon(
                      Icons.done_outlined,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          context.read<HomeViewModel>().firebaseUser != null
              ? userPost.uid == context.read<HomeViewModel>().firebaseUser!.uid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                            onTap: () {
                                              postCardProvider
                                                  .deletePost(userPost.postId);

                                              Navigator.of(context).pop();
                                            }),
                                      )
                                      .toList()),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert,color: Colors.black,),
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }
}
