import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/business_logic/utils/assets/assets.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/ui/views/home_screen/post_card/post_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(DbKeys.userPosts).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: false,
        title: SvgPicture.asset(
          Assets.instaLogo,
          color: Theme.of(context).colorScheme.onPrimary,
          height: 32,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.messenger_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
