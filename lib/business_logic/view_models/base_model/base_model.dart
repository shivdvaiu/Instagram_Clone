import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/enums/enums.dart';



class BaseModel extends ChangeNotifier { 
  
  ViewState _viewState = ViewState.Ideal;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

   AuthState _authState = AuthState.SignIn;

  AuthState get authState => _authState;

  setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }


}

