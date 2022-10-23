import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/utilites/screen_sizes.dart';
import '../../../../core/widgets/foodadora_button.dart';
import '../../../../core/widgets/foodadora_textfield.dart';
import '../../../../core/widgets/regex.dart';
import '../viewmodels/signup_viewModel.dart';

class PhoneSignUpViewBody extends ViewModelWidget<SignUpViewModel> {
  const PhoneSignUpViewBody({
    Key? key,
    required GlobalKey<FormBuilderState> phoneFormKey,
    required this.user,
  })  : _phoneFormKey = phoneFormKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _phoneFormKey;
  final UserCredential? user;

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: blockSizeVertical(context) * 8,
              horizontal: blockSizeHorizontal(context) * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last Step',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: blockSizeHorizontal(context) * 8),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: blockSizeVertical(context)),
              Text(
                'Write your phone number',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: blockSizeHorizontal(context) * 6),
              ),
              SizedBox(height: blockSizeVertical(context) * 5),
              FormBuilder(
                key: _phoneFormKey,
                child: FoodadoraTextField(
                    name: 'phone',
                    label: 'Phone',
                    iconPath: Assets.phoneIcon,
                    inputType: TextInputType.phone,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: "Phone is required"),
                      FormBuilderValidators.match(
                          context, FoodadoraRegExp.phone.pattern)
                    ])),
              ),
              SizedBox(height: blockSizeVertical(context) * 2),
              FoodadoraButton(
                  label: 'Create account',
                  onPressed: () async {
                    _phoneFormKey.currentState!.save();
                    if (_phoneFormKey.currentState!.validate()) {
                      final phone = _phoneFormKey.currentState!.value['phone'];

                      viewModel.phoneForm(
                          email: user!.user!.email,
                          id: user!.user!.uid,
                          name: user!.user!.displayName,
                          phone: phone,
                          url: user!.user!.photoURL);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
