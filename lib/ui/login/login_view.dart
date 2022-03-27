import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/ui/login/login_viewmodel.dart';

import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/screen_sizes.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: model.isLoading,
                progressIndicator: const CircularProgressIndicator(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: (screenHeight(context) / 100) * 1,
                          horizontal: (screenWidth(context) / 100) * 5),
                      child: Center(
                        child: Column(
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/images/logo.png',
                              ),
                              width: (screenWidth(context) / 100) * 50,
                            ),
                            SizedBox(height: (screenHeight(context) / 100) * 3),
                            Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
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
                                      icon: LineIcons.envelope,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.email(context),
                                        FormBuilderValidators.required(context,
                                            errorText: "email is empty")
                                      ]),
                                    ),
                                    FoodadoraTextField(
                                      name: "password",
                                      label: 'Password',
                                      icon: LineIcons.key,
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
                              label: 'Signin',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: const Color(0xff3b5998),
                                  child: Image.asset(
                                    'assets/icons/facebook.png',
                                    color: Colors.white,
                                    width: (screenWidth(context) / 100) * 9,
                                  ),
                                  padding: EdgeInsets.all(
                                      (screenWidth(context) / 100) * 3),
                                  shape: const CircleBorder(),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    model.googleSignin();
                                  },
                                  elevation: 2.0,
                                  fillColor: Colors.white,
                                  child: Image.asset(
                                    'assets/icons/google.png',
                                    width: (screenWidth(context) / 100) * 9,
                                  ),
                                  padding: EdgeInsets.all(
                                      (screenWidth(context) / 100) * 3),
                                  shape: const CircleBorder(),
                                ),
                              ],
                            )
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
        child: Divider(color: Colors.black),
      ),
      Text(
        "  OR  ",
        style: TextStyle(
          color: Colors.black,
          fontSize: (screenWidth(context) / 100) * 4,
        ),
      ),
      const Expanded(
          child: Divider(
        color: Colors.black,
      )),
    ]),
  );
}
