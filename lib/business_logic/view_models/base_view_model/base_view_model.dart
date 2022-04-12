import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/views/home_screen/chat_view/chat_view.dart';
import 'package:instagram_clone/ui/views/home_screen/home_screen_body.dart';
import 'package:instagram_clone/ui/views/home_screen/notification_view/notification_view.dart';
import 'package:instagram_clone/ui/views/home_screen/profile_view/profile_view.dart';
import 'package:instagram_clone/ui/views/home_screen/upload_view/upload_view.dart';

class BaseViewModel extends ChangeNotifier {
  int currentBottomNavIndex = 0;

  get getCurrentBottomNavIndex => currentBottomNavIndex;

  set setCurrentBottomNavIndex(int index) {
    currentBottomNavIndex = index;
    notifyListeners();
  }

  List<Widget> allViews = [
    HomeView(),
    ChatView(),
   UploadView(),
    NotificationsView(),
    ProfileView(),
  ];


}
