import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:instagram_clone/ui/views/add_post_screen/add_post_screen.dart';
import 'package:instagram_clone/ui/views/favourites_screen/favourites_screen.dart';
import 'package:instagram_clone/ui/views/home_screen/home_screen_body.dart';
import 'package:instagram_clone/ui/views/home_screen/home_view.dart';
import 'package:instagram_clone/ui/views/profile_screen/profile_screen.dart';
import 'package:instagram_clone/ui/views/search_screen/search_screen.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = serviceLocator.get<FirebaseAuth>();
  final FirebaseFirestore firestore = serviceLocator.get<FirebaseFirestore>();

  UserModel? firebaseUser;

  fetchUserModel() async {
    await firestore
        .collection(DbKeys.userCollections)
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((userInfoDocument) {
      firebaseUser = UserModel.fromSnap(userInfoDocument);
      notifyListeners();
    });
  }

  int currentIndex = 0;

  get getCurrentPageIndex => currentIndex;

  set changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> allScreens = [
    HomeScreenBody(),
    SearchScreen(),
    AddPostScreen(),
    FavouritesScreen(),
    ProfileScreen()
  ];
}
