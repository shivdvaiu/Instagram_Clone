import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseModel {
  TextEditingController loginEmailEditingController = TextEditingController();
  TextEditingController loginPasswordEditingController =
      TextEditingController();

  Future<SignInState> signInWithEmailAndPassword(
      {required String email, required password}) async {
    log(email);
    log(password);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == Constants.userNotFound) {
        return SignInState.USER_NOT_FOUND;
      } else if (e.code == Constants.wrongPassword) {
        return SignInState.WRONG_PASSWORD;
      } else if (e.code == Constants.invalidEmail) {
        return SignInState.INVALID_EMAIL;
      } else {
        log(e.code);
        return SignInState.UNKNOWN_ERROR;
      }
    }

    return SignInState.SIGN_IN_SUCCESS;
  }

  clearLoginInfo() {
    loginEmailEditingController.clear();
    loginPasswordEditingController.clear();
  }

  setUserLoggedIn() {
    StorageService().saveToDisk(DbKeys.isUserLoggedIn, true);
  }
}
