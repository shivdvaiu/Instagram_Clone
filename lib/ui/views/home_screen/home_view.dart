import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/theme_view_model/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, homeViewProvider, Widget? child) =>
          Scaffold(
        body: homeViewProvider.allScreens[homeViewProvider.getCurrentPageIndex],
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor:Theme.of(context).colorScheme.background,
       activeColor: Theme.of(context).colorScheme.surface,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,

              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: '',
            ),
          ],
          onTap: (index) {
            if(index==3){

              context.read<ThemeViewModel>().changeTheme();
            }
            homeViewProvider.changePage = index;


          },
          currentIndex: homeViewProvider.getCurrentPageIndex,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
