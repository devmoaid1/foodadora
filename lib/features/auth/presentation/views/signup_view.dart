import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/core/widgets/keyboard_dismissible_screen.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/widgets/foodadora_app_bar.dart';
import '../viewmodels/signup_viewModel.dart';
import '../widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissibleScreen(
      screen: ViewModelBuilder<SignUpViewModel>.nonReactive(
        viewModelBuilder: () => signUpViewModel,
        disposeViewModel: false,
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.loadingState,
            progressIndicator: const CircularProgressIndicator(),
            child: Scaffold(
                appBar: const FoodadoraAppBar(isWithBack: true),
                body: SignUpViewBody(formKey: _formKey)),
          );
        },
      ),
    );
  }
}
