import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_post/user_post_model.dart';
import 'package:instagram_clone/ui/widgets/shimmer_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class UserMedia extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: [
                
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(DbKeys.userPosts)
                        .orderBy('datePublished')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Post post = Post.fromSnap(snapshot.data!.docs[index]);

                          return CachedImage(post.postUrl,radius: 7,);
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.count(
                            (index % 2 == 0) ? 1 : 1, (index % 2 == 0) ? 1 : 1),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      );
                    },
                  ),
                ),
              ],
            ));
      }
    });
  }
}