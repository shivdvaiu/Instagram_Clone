import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:uuid/uuid.dart';

class PostViewModel extends ChangeNotifier {
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;
  final TextEditingController commentPostEditingController = new TextEditingController();

  bool isAnimating = false;

  Future<UploadCommentState> postComment(String postId, String text, String uid,
      String name, String profilePic) async {

    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _cloudFirestore
            .collection(DbKeys.userPosts)
            .doc(postId)
            .collection(DbKeys.comments)
            .doc(commentId)
            .set({
          'postedByProfilePic': profilePic,
          'postedByName': name,
          'postedByUid': uid,
          'comment': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        return UploadCommentState.UNKNOWN_ERROR;
      }
    } catch (err) {}
    return UploadCommentState.COMMENT_POSTED;
  }

  /// For like user post
  Future<LikePostState> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _cloudFirestore.collection(DbKeys.userPosts).doc(postId).update({
          DbKeys.likes: FieldValue.arrayRemove([uid])
        });
      } else {
        _cloudFirestore.collection('posts').doc(postId).update({
          DbKeys.likes: FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      return LikePostState.UNKNOWN_ERROR;
    }
    return LikePostState.POST_LIKED;
  }

  Future<DeletePostState> deletePost(String postId) async {
    try {
      await _cloudFirestore.collection('posts').doc(postId).delete();
    } catch (err) {
      return DeletePostState.UNKNOWN_ERROR;
    }
    return DeletePostState.POST_DELETED;
  }

  set setAnimation(bool flag) {
    isAnimating = flag;
    notifyListeners();
  }

  get getAnimationFlag => isAnimating;
}
