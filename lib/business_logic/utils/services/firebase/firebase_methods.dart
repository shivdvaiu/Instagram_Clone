import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:instagram_clone/business_logic/view_models/home_view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class FirebaseMethods extends ChangeNotifier {
  final FirebaseFirestore firestore = serviceLocator.get<FirebaseFirestore>();
  final FirebaseAuth firebaseAuth = serviceLocator.get<FirebaseAuth>();
  final FirebaseMessaging firebaseMessaging =
      serviceLocator.get<FirebaseMessaging>();

  /// Firebase cloud messaging device token
  static String? fcmToken;
  getFirebaseDeviceToken() async {

    fcmToken = await FirebaseMessaging.instance.getToken();
    notifyListeners();
    log("fcm token is $fcmToken");
  }


  
}
