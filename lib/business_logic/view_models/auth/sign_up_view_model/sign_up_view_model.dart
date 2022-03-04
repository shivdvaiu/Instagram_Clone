import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/business_logic/models/user_model/user_model.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/firebase/firebase_methods.dart';
import 'package:instagram_clone/business_logic/utils/services/image_picker/pick_image.dart';
import 'package:instagram_clone/business_logic/utils/services/upload_image_service/upload_image_service.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class SignUpViewModel extends BaseModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;

  /// User profile picture
  Uint8List? image;

  final Logger logger = Logger();

  Future<SignUpState> signUpUserUsingFirebase({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    if (isValidated() == SignUpState.VALIDATED_TRUE) {
      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl = await uploadImageToStorage(DbKeys.usersProfilePics,
            image!, false, _firebaseStorage, _firebaseAuth);

        UserModel userModel = UserModel(
            bio: bio,
            email: email.trim(),
            photoUrl: photoUrl,
            uid: userCredential.user!.uid,
            followers: [],
            following: [],
            username: username.trim(),
            deviceToken: FirebaseMethods.token!);

        _cloudFirestore
            .collection(DbKeys.userCollections)
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());

        return SignUpState.SIGN_UP_SUCCESS;
      } on FirebaseAuthException catch (e) {
        logger.log(Level.error, e.toString());
        if (e.code == Constants.weakpassword) {
          logger.log(Level.error, Strings.weakPassword);

          return SignUpState.WEAK_PASSWORD;
        } else if (e.code == Constants.alreadyHaveAccount) {
          logger.log(Level.error, Strings.alreadyHaveAccount);
          return SignUpState.ALREADY_HAVE_ACCOUNT;
        }
      } catch (e) {
        logger.log(Level.error, e.toString());
        return SignUpState.UNKNOWN_ERROR;
      }
    }

    return isValidated();
  }

  void logOut() async {
    setViewState(ViewState.Busy);
    await _firebaseAuth.signOut();

    setViewState(ViewState.Ideal);
  }

  /// Upload Image to Firebase Storage

  /// Pick Image Using image picker plugin
  selectImage() async {
    image = await pickImage(ImageSource.gallery);
    notifyListeners();
  }

  /// Clear All Filled Information

  resetUserSignUpInfo() {
    image = null;
    emailController.clear();
    passwordConfirmController.clear();
    bioController.clear();
    passwordController.clear();
    userNameController.clear();
    notifyListeners();
  }

  /// Validations on sign up page

  SignUpState isValidated() {
    if (image == null) {
      return SignUpState.SELECT_IMAGE;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmController.text.isEmpty ||
        bioController.text.isEmpty ||
        userNameController.text.isEmpty) {
      return SignUpState.VALIDATED_FALSE;
    }

    if (passwordConfirmController.text.trim() !=
        passwordController.text.trim()) {
      return SignUpState.PASSWORD_NOT_SAME;
    }
    return SignUpState.VALIDATED_TRUE;
  }
}
