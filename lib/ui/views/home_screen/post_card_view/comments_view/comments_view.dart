import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_post/comments_model/comments_model.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/extensions/calculate_time_ago.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/post_view_model/post_view_model.dart';
import 'package:instagram_clone/ui/widgets/custom_text_field.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class CommentsScreen extends StatelessWidget {
  final FirebaseFirestore _cloudFirestore =
      serviceLocator.get<FirebaseFirestore>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (BuildContext context, postProvider, Widget? child) {
        List<Post> currentUserPost =
            ModalRoute.of(context)?.settings.arguments as List<Post>;
        Post post = currentUserPost[0];
        return StreamBuilder(
            stream: _cloudFirestore
                .collection(DbKeys.userPosts)
                .doc(post.postId)
                .collection(DbKeys.comments)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),

                        /// profile picture of a user that posted this current post
                        Container(
                          height: 5.h,
                          width: 10.w,
                          child: ClipOval(
                              child: CachedImage(
                                  post.currentUserProfilePicture)),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        ///  user name of a user that posted this current post
                        Text(
                          post.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        // current post description
                        Expanded(
                          child: Text(
                            currentUserPost[0].description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                ),
                          ),
                        )
                      ],
                    ),

                    Container(
                      child: Text(
                        displayTimeAgoFromTimestamp(currentUserPost[0]
                            .datePublished
                            .toDate()
                            .toString()),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 8.sp,color: Colors.black),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // All comments builder
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            CommentModel commentModel =
                                CommentModel.fromSnap(snapshot.data!.docs[i]);

                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        child: ClipOval(
                                            child: CachedImage(
                                               commentModel
                                                    .postedByProfilePic)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(commentModel.comment,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 7.sp)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    displayTimeAgoFromTimestamp(commentModel
                                        .datePublished
                                        .toDate()
                                        .toString()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 8.sp, color: Colors.black,),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
                resizeToAvoidBottomInset: true,
                bottomNavigationBar: _postCommentNavBar(context, postProvider),
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Comments",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          
                        ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
              );
            });
      },
    );
  }

  Transform _postCommentNavBar(
      BuildContext context, PostViewModel postProvider) {
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            height: 8.h,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 5.h,
                  width: 10.w,
                  child: ClipOval(
                      child: CachedImage(
                       context
                              .read<HomeViewModel>()
                              .firebaseUser!
                              .photoUrl)),
                ),
                Expanded(
                  child: CustomTextField(
                      isPostCommentScreen: true,
                      hintText: Strings.writeYourComment,
                      textInputType: TextInputType.emailAddress,
                      textEditingController:
                          postProvider.commentPostEditingController),
                ),
                TextButton(
                    onPressed: () {
                      List<Post> currentUserPost = ModalRoute.of(context)
                          ?.settings
                          .arguments as List<Post>;

                      Post post = currentUserPost[0];

                      postProvider
                          .postComment(
                              post.postId,
                              postProvider.commentPostEditingController.text
                                  .toUpperCase(),
                              post.uid,
                              post.username,
                              post.currentUserProfilePicture)
                          .then((uploadCommentState) {
                        switch (uploadCommentState) {
                          case UploadCommentState.COMMENT_POSTED:
                          postProvider.commentPostEditingController.clear();
                            break;

                          case UploadCommentState.UNKNOWN_ERROR:
                            break;
                          default:
                        }
                      });
                    },
                    child: Text(
                      "Post",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,

                          ),
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
