import 'package:flutter/material.dart';

class TextFieldWrapper extends ChangeNotifier {
  var _controller = TextEditingController();

  TextEditingController get controller {
    return this._controller;
  }

  set controller(TextEditingController value) {
    this._controller = value;
    notifyListeners();
  }

  String _errorText = "";

  String get errorText {
    return this._errorText;
  }

  set errorText(String value) {
    this._errorText = value;
    notifyListeners();
  }

  TextFieldWrapper() {
    controller = TextEditingController();
  }

  factory TextFieldWrapper.withValue({
    TextEditingController? controller,
    String? errorText,
  }) {
    final wrap = TextFieldWrapper();
    wrap.controller = controller ?? TextEditingController();
    wrap.errorText = errorText ?? "";
    return wrap;
  }
}
