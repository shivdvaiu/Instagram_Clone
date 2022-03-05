import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';

class FollowViewModel extends ChangeNotifier {
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;

  Future<FollowUserState> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap = await _cloudFirestore
          .collection(DbKeys.userCollections)
          .doc(uid)
          .get();
      List following = (snap.data()! as dynamic)[DbKeys.following];

      if (following.contains(followId)) {
        await _cloudFirestore
            .collection(DbKeys.userCollections)
            .doc(followId)
            .update({
          DbKeys.followers: FieldValue.arrayRemove([uid])
        });

        await _cloudFirestore
            .collection(DbKeys.userCollections)
            .doc(uid)
            .update({
          DbKeys.following: FieldValue.arrayRemove([followId])
        });
      } else {
        await _cloudFirestore
            .collection(DbKeys.userCollections)
            .doc(followId)
            .update({
          DbKeys.followers: FieldValue.arrayUnion([uid])
        });

        await _cloudFirestore
            .collection(DbKeys.userCollections)
            .doc(uid)
            .update({
          DbKeys.following: FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      return FollowUserState.UNKNOWN_ERROR;
    }

    return FollowUserState.USER_FOLLOWED;
  }
}
