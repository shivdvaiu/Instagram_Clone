import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:instagram_clone/business_logic/utils/constants/constants.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_keys/data_base_keys.dart';
import 'package:instagram_clone/business_logic/utils/services/database/database_service/database_service.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginViewModel extends BaseModel {
  final String defaultUserImageUrl =
      'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;
  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  TextEditingController loginEmailEditingController = TextEditingController();
  TextEditingController loginPasswordEditingController =
      TextEditingController();


  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final FacebookAuth _facebookLogin = FacebookAuth.instance;

  final FirebaseFirestore firestore = serviceLocator.get<FirebaseFirestore>();



  setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  Future<void> signOutFacebook() async {
    FacebookAuth.instance.logOut();
  }

    Future<void> signOutApple() async {
    FacebookAuth.instance.logOut();
  }


  logOutFirebaseUser() {
    _firebaseAuth.signOut().then((value) {
      log("Facebook logout Successfully");
    });
  }

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

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googlSignIn.signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        /// firebase
        User userDetails =
            (await _firebaseAuth.signInWithCredential(credential)).user!;

        this._name = userDetails.displayName;
        this._email = userDetails.email;
        this._imageUrl = userDetails.photoURL;

        this._uid = userDetails.uid;
        this._signInProvider = 'google';

        _hasError = false;
        notifyListeners();

        try {
          await firestore
              .collection(DbKeys.userCollections)
              .doc(_firebaseAuth.currentUser!.uid)
              .get()
              .then((doc) {
            if (doc.exists == false) {
              signOutGoogle();
              // logOutFirebaseUser();
              _hasError = true;
              notifyListeners();
              _errorCode = "Google Account Not Found";
            }
          });
        } catch (e) {
          log("in catch");
          _hasError = true;

          notifyListeners();
        }
        if (_hasError == false) {
          StorageService().saveToDisk(DbKeys.isUserLoggedIn, true);
        }

        notifyListeners();
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  signOutGoogle() async {
    await _googlSignIn.signOut();
  }

  clearLoginInfo() {
    loginEmailEditingController.clear();
    loginPasswordEditingController.clear();
  }

  setUserLoggedIn() {
    StorageService().saveToDisk(DbKeys.isUserLoggedIn, true);
  }

  Future signInwithFacebook() async {
    LoginResult facebookLoginResult = await FacebookAuth.instance.login();

    if (facebookLoginResult.status == LoginStatus.success) {
      final _accessToken = await FacebookAuth.instance.accessToken;
      if (_accessToken != null) {
        try {
          final AuthCredential credential =
              FacebookAuthProvider.credential(_accessToken.token);

          /// firebase

          final User user =
              (await _firebaseAuth.signInWithCredential(credential)).user!;

          await user.getIdToken();
          var currentUser = _firebaseAuth.currentUser!;

          this._name = user.displayName;
          this._email = user.email;

          this._imageUrl = user.photoURL;
          log(user.photoURL!);
          this._uid = user.uid;
          this._signInProvider = 'facebook';

          log(user.email.toString());
          try {
            await firestore
                .collection(DbKeys.userCollections)
                .doc(_firebaseAuth.currentUser!.uid)
                .get()
                .then((doc) {
              log("exist");
              log(doc.exists.toString());
              if (doc.exists == false) {
                setError(true);
                _errorCode = "Account Not Found";
                log(_errorCode.toString());
                print(_hasError);
                logOutFirebaseUser();
                notifyListeners();
                signOutFacebook();
              }
            });
          } catch (e) {
            log("in catch");
            setError(true);
            notifyListeners();
          }

          if (_hasError == false) {
            StorageService().saveToDisk(DbKeys.isUserLoggedIn, true);
          }

          notifyListeners();
        } catch (e) {
          setError(true);
          _errorCode = e.toString();
          print(e.toString());
          notifyListeners();
        }
      }
    } else {
      setError(true);
      _errorCode = 'cancel or error';
      notifyListeners();
    }
//   }
  }

  Future signInWithApple() async {
    final _firebaseAuth = FirebaseAuth.instance;
    final result = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    if (result.status == AuthorizationStatus.authorized) {
      try {
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential!.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );

        final authResult = await _firebaseAuth.signInWithCredential(credential);

        final firebaseUser = authResult.user;

        this._uid = firebaseUser!.uid;
        this._name =
            '${appleIdCredential.fullName!.givenName} ${appleIdCredential.fullName!.familyName}';
        this._email = appleIdCredential.email ?? 'null';
        this._imageUrl = firebaseUser.photoURL ?? defaultUserImageUrl;
        this._signInProvider = 'apple';

        try {
          await firestore
              .collection(DbKeys.userCollections)
              .doc(_firebaseAuth.currentUser!.uid)
              .get()
              .then((doc) {
            log("exist");
            log(doc.exists.toString());
            if (doc.exists == false) {
              setError(true);
              _errorCode = "Account Not Found";
              log(_errorCode.toString());
              print(_hasError);
              logOutFirebaseUser();
              notifyListeners();
            
            }
          });
        } catch (e) {
          log("in catch");
          setError(true);
          notifyListeners();
        }

        if (_hasError == false) {
          StorageService().saveToDisk(DbKeys.isUserLoggedIn, true);
        }

        notifyListeners();

        print(firebaseUser);
        _hasError = false;
        notifyListeners();
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else if (result.status == AuthorizationStatus.error) {
      _hasError = true;
      _errorCode = 'Appple Sign In Error! Please try again';
      notifyListeners();
    } else if (result.status == AuthorizationStatus.cancelled) {
      _hasError = true;
      _errorCode = 'Sign In Cancelled!';
      notifyListeners();
    }
  }
}
