import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:foodadora/ui/widgets/authentication_wrapper/authintication_wrapper_viewmodel.dart';

class AuthenticationWrapper extends StatelessWidget {
  final Widget authedWidget;
  final Widget unAuthedWidget;
  const AuthenticationWrapper({
    Key? key,
    required this.authedWidget,
    required this.unAuthedWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationWrapperViewModel>.reactive(
        onModelReady: (model) => model.getUserStream(),
        viewModelBuilder: () => AuthenticationWrapperViewModel(),
        builder: (context, model, _) => StreamBuilder(
            stream: model.currentUser,
            builder: (context, AsyncSnapshot<User?> snapShot) {
              if (snapShot.data?.uid != null) {
                return authedWidget;
              }

              return unAuthedWidget;
            }));
  }
}
