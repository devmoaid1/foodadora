import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:foodadora/core/widgets/keyboard_dismissible_screen.dart';

import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/widgets/foodadora_app_bar.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissibleScreen(
      screen: ViewModelBuilder<LoginViewModel>.nonReactive(
          viewModelBuilder: () => Get.find<LoginViewModel>(),
          disposeViewModel: false,
          builder: (context, model, child) => Scaffold(
                appBar: const FoodadoraAppBar(isWithBack: true),
                body: LoginViewBody(formKey: _formKey),
              )),
    );
  }
}
