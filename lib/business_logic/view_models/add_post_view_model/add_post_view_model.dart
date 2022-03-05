import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/utils/services/upload_image_service/upload_image_service.dart';
import 'package:uuid/uuid.dart';

class AddPostViewModel extends ChangeNotifier {
  TextEditingController captionEditingController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;

  Uint8List? postImageFile;

  Future<UploadPostState> uploadPost(String description, Uint8List file,
      String uid, String username, String profImage) async {
    try {
      String postImageUrl = await uploadImageToStorage(DbKeys.userPosts,
          postImageFile!, true, _firebaseStorage, _firebaseAuth);

      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postImageUrl,
        currentUserProfilePicture: profImage,
        userFcmDeviceToken: FirebaseMethods.fcmToken ?? "",
      );

      _cloudFirestore
          .collection(DbKeys.userPosts)
          .doc(postId)
          .set(post.toJson());
    } catch (err) {
      return UploadPostState.UNKNOWN_ERROR;
    }
    return UploadPostState.POST_UPLOADED;
  }

  set setPostImage(Uint8List postImage) {
    postImageFile = postImage;
    notifyListeners();
  }

  get getPostImage => postImageFile;

  /// Clear current selected post image  and caption
  clearPostInformation() {
    captionEditingController.clear();

    postImageFile = null;

    notifyListeners();
  }
}
