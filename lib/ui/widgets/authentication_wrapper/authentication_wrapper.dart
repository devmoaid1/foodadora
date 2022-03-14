import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/ui/home_navigation/home_navigation_view.dart';
import 'package:foodadora/ui/login/login_view.dart';
import 'package:foodadora/ui/widgets/authentication_wrapper/authintication_wrapper_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationWrapperViewModel>.reactive(
        onModelReady: (model) => model.getUserStream(),
        viewModelBuilder: () => AuthenticationWrapperViewModel(),
        builder: (context, model, _) => StreamBuilder(
            stream: model.currentUser,
            builder: (context, AsyncSnapshot<User?> snapShot) {
              if (snapShot.hasData) {
                return const HomeNavigationView();
              }

              return LoginView();
            }));
  }
}
