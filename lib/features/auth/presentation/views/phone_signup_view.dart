// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/widgets/keyboard_dismissible_screen.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/utilites/screen_sizes.dart';
import '../viewmodels/signup_viewModel.dart';
import '../widgets/phone_signup_view_body.dart';

class PhoneSignUpScreen extends StatelessWidget {
  final UserCredential? user;
  PhoneSignUpScreen({Key? key, this.user}) : super(key: key);
  final _phoneFormKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissibleScreen(
      screen: ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => signUpViewModel,
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.loadingState,
            progressIndicator: const CircularProgressIndicator(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                toolbarHeight: blockSizeVertical(context) * 10,
                backgroundColor: Colors.white,
                title: Padding(
                  padding: EdgeInsets.all(blockSizeHorizontal(context)),
                  child: Image.asset(
                    'assets/images/sublogo.png',
                    height: blockSizeVertical(context) * 8.5,
                  ),
                ),
                elevation: 0,
              ),
              body:
                  PhoneSignUpViewBody(phoneFormKey: _phoneFormKey, user: user),
            ),
          );
        },
      ),
    );
  }
}
