import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/routes/routes.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/extensions/calculate_time_ago.dart';
import 'package:instagram_clone/business_logic/utils/services/snack_bar/snack_bar.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/post_view_model/post_view_model.dart';
import 'package:instagram_clone/ui/widgets/like_animation.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
          Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.white),
        // ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CachedImage(userPost.currentUserProfilePicture,radius: 40,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userPost.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // widget.snap['uid'].toString() == user.uid
                  //     ? IconButton(
                  //         onPressed: () {
                  //           showDialog(
                  //             useRootNavigator: false,
                  //             context: context,
                  //             builder: (context) {
                  //               return Dialog(
                  //                 child: ListView(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         vertical: 16),
                  //                     shrinkWrap: true,
                  //                     children: [
                  //                       'Delete',
                  //                     ]
                  //                         .map(
                  //                           (e) => InkWell(
                  //                               child: Container(
                  //                                 padding:
                  //                                     const EdgeInsets.symmetric(
                  //                                         vertical: 12,
                  //                                         horizontal: 16),
                  //                                 child: Text(e),
                  //                               ),
                  //                               onTap: () {
                  //                                 deletePost(
                  //                                   widget.snap['postId']
                  //                                       .toString(),
                  //                                 );
                  //                                 // remove the dialog box
                  //                                 Navigator.of(context).pop();
                  //                               }),
                  //                         )
                  //                         .toList()),
                  //               );
                  //             },
                  //           );
                  //         },
                  //         icon: const Icon(Icons.more_vert),
                  //       )
                  //     : Container(),
                ],
              ),
            ),

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedImage(
                  
                     userPost.postUrl,
                    isRound: false,
                    height: 40.h,
                  radius: 0,
                    width: double.infinity,
            
                  ),
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
            ),
            // LIKE, COMMENT SECTION OF THE POST
            Row(
              children: <Widget>[
                LikeAnimation(
                  isAnimating: userPost.likes.contains(
                      context.read<HomeViewModel>().firebaseUser!.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: userPost.likes.contains(
                            context.read<HomeViewModel>().firebaseUser!.uid)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                          ),
                    onPressed: () {
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
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                  onPressed: () {
                     Navigator.pushNamed(context, Routes.commentsScreen,
                                arguments: [userPost]);
                  },
                ),
                IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    onPressed: () {}),
                // Expanded(
                //     child: Align(
                //   alignment: Alignment.bottomRight,
                //   child: IconButton(
                //       icon: const Icon(Icons.bookmark_border),
                //       onPressed: () {}),
                // ))
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(userPost.likes.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 10.sp))),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 12.sp),
                        children: [
                          TextSpan(
                            text: userPost.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: userPost.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: _cloudFirestore
                          .collection(DbKeys.userPosts)
                          .doc(userPost.postId)
                          .collection(DbKeys.comments)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Text(
                              'View all 0 comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 10.sp),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          );
                        }
                        return InkWell(
                          child: Container(
                            child: Text(
                              'View all ${snapshot.data!.docs.length} comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 10.sp),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.commentsScreen,
                                arguments: [userPost]);
                          },
                        );
                      }),
                  Container(
                    child: Text(
                      displayTimeAgoFromTimestamp(
                          userPost.datePublished.toDate().toString()),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 8.sp),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
