import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/auth/login_view_model.dart/login_view_model.dart';
import 'package:instagram_clone/business_logic/view_models/auth/sign_up_view_model/sign_up_view_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt serviceLocator = GetIt.instance;
Future<dynamic> setupServiceLocator() async {
  
  serviceLocator.registerLazySingleton(() => LoginViewModel());

  serviceLocator.registerLazySingleton(() => SignUpViewModel());
serviceLocator.registerLazySingleton(()=> Logger());
serviceLocator.registerSingletonAsync(() =>SharedPreferences.getInstance());
serviceLocator.registerLazySingleton(() => FirebaseMessaging.instance);
serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);

  return Future.value(true);
}
