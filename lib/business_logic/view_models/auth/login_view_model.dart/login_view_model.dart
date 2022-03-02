import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController loginTextEditingController = TextEditingController();
  TextEditingController loginPasswordEditingController = TextEditingController();

  bool isLoading = false;

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  removeLoading() {
    isLoading = false;
    notifyListeners();
  }



}
