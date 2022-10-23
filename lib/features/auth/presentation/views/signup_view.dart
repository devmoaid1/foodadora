import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/core/widgets/keyboard_dismissible_screen.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/utilites/screen_sizes.dart';
import '../../../../core/widgets/foodadora_app_bar.dart';
import '../../../../core/widgets/foodadora_button.dart';
import '../../../../core/widgets/foodadora_textfield.dart';
import '../../../../core/widgets/regex.dart';
import '../viewmodels/signup_viewModel.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissibleScreen(
      screen: ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => signUpViewModel,
        disposeViewModel: false,
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.loadingState,
            progressIndicator: const CircularProgressIndicator(),
            child: Scaffold(
                appBar: foodadoraAppBar(context, withBack: true),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: blockSizeVertical(context) * 3,
                          horizontal: blockSizeHorizontal(context) * 5),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up',
                              style: GoogleFonts.raleway(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: blockSizeHorizontal(context) * 6),
                            ),
                            SizedBox(height: blockSizeVertical(context) * 2),
                            FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    FoodadoraTextField(
                                      name: 'name',
                                      label: 'Name',
                                      iconPath: Assets.usericon,
                                      inputType: TextInputType.text,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context,
                                            errorText: "name is Required")
                                      ]),
                                    ),
                                    FoodadoraTextField(
                                      name: "email",
                                      label: 'Email',
                                      iconPath: Assets.emailIcon,
                                      inputType: TextInputType.emailAddress,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context,
                                            errorText: "Email is Required"),
                                        FormBuilderValidators.email(context)
                                      ]),
                                    ),
                                    FoodadoraTextField(
                                      name: 'password',
                                      label: 'Password',
                                      iconPath: Assets.passwordIcon,
                                      inputType: TextInputType.text,
                                      isObsecure: true,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context,
                                            errorText: "password is Required"),
                                        FormBuilderValidators.minLength(
                                            context, 8,
                                            errorText: "password is too short")
                                      ]),
                                    ),
                                    FoodadoraTextField(
                                      name: 'phoneNumber',
                                      label: 'Phone Number',
                                      iconPath: Assets.phoneIcon,
                                      inputType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context,
                                            errorText: "phone is Required"),
                                        FormBuilderValidators.match(context,
                                            FoodadoraRegExp.phone.pattern)
                                      ]),
                                    ),
                                  ],
                                )),
                            verticalSpaceLarge,
                            FoodadoraButton(
                              label: 'Sign Up',
                              color: activeColor,
                              onPressed: () {
                                _formKey.currentState!.save();

                                if (_formKey.currentState!.validate()) {
                                  final name =
                                      _formKey.currentState!.value['name'];

                                  final email =
                                      _formKey.currentState!.value['email'];
                                  final password =
                                      _formKey.currentState!.value['password'];
                                  final phoneNumber = _formKey
                                      .currentState!.value['phoneNumber'];

                                  model.signUpNewUser(
                                      email: email,
                                      name: name,
                                      password: password,
                                      phoneNumber: phoneNumber);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
