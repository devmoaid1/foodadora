import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/ui/login/login_viewmodel.dart';

import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/enums.dart';
import '../widgets/foodadora_button.dart';
import '../widgets/social_button.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: foodadoraAppBar(context, withBack: true),
              body: ModalProgressHUD(
                inAsyncCall: model.isLoading,
                progressIndicator: const CircularProgressIndicator.adaptive(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: (screenHeight(context) / 100) * 1,
                          horizontal: (screenWidth(context) / 100) * 5),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.raleway(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: (screenWidth(context) / 100) * 6),
                            ),
                            SizedBox(height: (screenHeight(context) / 100) * 2),
                            FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    FoodadoraTextField(
                                      name: "email",
                                      label: 'Email',
                                      inputType: TextInputType.emailAddress,
                                      iconPath: Assets.emailIcon,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.email(context),
                                        FormBuilderValidators.required(context,
                                            errorText: "email is empty")
                                      ]),
                                    ),
                                    FoodadoraTextField(
                                      name: "password",
                                      label: 'Password',
                                      iconPath: Assets.passwordIcon,
                                      inputType: TextInputType.text,
                                      isObsecure: true,
                                      textInputAction: TextInputAction.done,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.minLength(
                                            context, 8,
                                            errorText: "Password is too short"),
                                        FormBuilderValidators.required(context,
                                            errorText: "Password is Empty")
                                      ]),
                                    ),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('New User?'),
                                  onPressed: () {
                                    model.navigateToSignUpScreen();
                                  },
                                ),
                                TextButton(
                                    child: const Text('Forgot Password?'),
                                    onPressed: () {}),
                              ],
                            ),
                            SizedBox(height: (screenHeight(context) / 100) * 2),
                            FoodadoraButton(
                              label: 'Login',
                              color: activeColor,
                              onPressed: () async {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  final email =
                                      _formKey.currentState!.value['email'];
                                  final password =
                                      _formKey.currentState!.value['password'];

                                  model.emailLogin(
                                      email: email, password: password);
                                }
                              },
                            ),
                            SizedBox(height: (screenHeight(context) / 100) * 2),
                            _buildOrRow(context),
                            verticalSpaceRegular,
                            if (Platform.isIOS)
                              SocialButton(
                                  onPressed: model.googleSignin,
                                  type: SocialTypes.apple),
                            verticalSpaceRegular,
                            SocialButton(
                                onPressed: model.googleSignin,
                                type: SocialTypes.google),
                            verticalSpaceRegular,
                            SocialButton(
                                onPressed: model.googleSignin,
                                type: SocialTypes.facebook),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

Padding _buildOrRow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: (screenWidth(context) / 100) * 10,
        vertical: (screenHeight(context) / 100) * 2),
    child: Row(children: <Widget>[
      const Expanded(
        child: Divider(color: textColor),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          "OR",
          style: GoogleFonts.raleway(
            color: textColor,
            fontSize: (screenWidth(context) / 100) * 4,
          ),
        ),
      ),
      const Expanded(
          child: Divider(
        color: Colors.black,
      )),
    ]),
  );
}
