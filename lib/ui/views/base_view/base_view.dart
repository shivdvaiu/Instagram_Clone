import 'package:flutter/material.dart';
import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/view_models/base_model/base_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext, T, Widget?) builder;
  BaseView({
    required this.builder,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = serviceLocator<T>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      //builder: (context) => model,
      child: Consumer<T>(builder: widget.builder),
      //notifier: model,
      value: model,
    );
  }
}
