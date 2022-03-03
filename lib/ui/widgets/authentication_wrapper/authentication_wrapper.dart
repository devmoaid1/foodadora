import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/ui/home/home_view.dart';
import 'package:foodadora/ui/login/login_view.dart';
import 'package:foodadora/ui/profile/profile_view.dart';
import 'package:foodadora/ui/store_details/storeDetails_view.dart';
import 'package:foodadora/ui/widgets/authentication_wrapper/authintication_wrapper_viewModel.dart';
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
                return HomeScreen();
              }

              return LoginView();
            }));
  }
}
