import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/features/auth/presentation/widgets/or_row.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/utilites/app_colors.dart';
import '../../../../app/utilites/enums.dart';
import '../../../../app/utilites/screen_sizes.dart';
import '../../../../core/widgets/foodadora_button.dart';
import '../../../../core/widgets/foodadora_textfield.dart';
import '../../../../core/widgets/social_button.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginViewBody extends ViewModelWidget<LoginViewModel> {
  const LoginViewBody({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return ModalProgressHUD(
      inAsyncCall: viewModel.loadingState,
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
                              FormBuilderValidators.minLength(context, 8,
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
                          viewModel.navigateToSignUpScreen();
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
                        final email = _formKey.currentState!.value['email'];
                        final password =
                            _formKey.currentState!.value['password'];

                        viewModel.emailLogin(email: email, password: password);
                      }
                    },
                  ),
                  SizedBox(height: (screenHeight(context) / 100) * 2),
                  const OrRow(),
                  verticalSpaceRegular,
                  if (Platform.isIOS)
                    SocialButton(
                        onPressed: viewModel.googleSignin,
                        type: SocialTypes.apple),
                  verticalSpaceRegular,
                  SocialButton(
                      onPressed: viewModel.googleSignin,
                      type: SocialTypes.google),
                  verticalSpaceRegular,
                  SocialButton(
                      onPressed: viewModel.googleSignin,
                      type: SocialTypes.facebook),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
