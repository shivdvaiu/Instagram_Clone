import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';

class LoginViewModel extends BaseModel {
  TextEditingController loginTextEditingController = TextEditingController();
  TextEditingController loginPasswordEditingController =
      TextEditingController();

  signInWithEmailAndPassword({required String email, required password}) async {
    try {
      setViewState(ViewState.Busy);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      setViewState(ViewState.Ideal);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        
      }
    }
  }
}
