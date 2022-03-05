import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String postedByProfilePic;
  final String postedByName;
  final String postedByUid;
  final String comment;
  final String commentId;
  final dynamic datePublished;

  CommentModel(
      {required this.postedByProfilePic,
      required this.postedByName,
      required this.postedByUid,
      required this.comment,
      required this.commentId,
      required this.datePublished});

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
        postedByProfilePic: snapshot['postedByProfilePic'],
        postedByName: snapshot['postedByName'],
        postedByUid: snapshot['postedByUid'],
        comment: snapshot['comment'],
        commentId: snapshot['commentId'],
        datePublished: snap['datePublished']);
  }

  Map<String, dynamic> toJson() => {
        'postedByProfilePic': postedByProfilePic,
        'postedByName': postedByName,
        'postedByUid': postedByUid,
        'comment': comment,
        'commentId': commentId,
        'datePublished': datePublished
      };
}
