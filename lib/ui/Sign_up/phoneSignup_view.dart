import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/ui/Sign_up/signup_viewModel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';
import 'package:foodadora/ui/widgets/regex.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stacked/stacked.dart';

class PhoneSignUpScreen extends StatelessWidget {
  final UserCredential? user;
  PhoneSignUpScreen({Key? key, this.user}) : super(key: key);
  final _phoneFormKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => signUpViewModel,
      builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.isLoading,
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
            body: WillPopScope(
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
                            icon: LineIcons.mobilePhone,
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
                              final phone =
                                  _phoneFormKey.currentState!.value['phone'];

                              model.phoneForm(
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
            ),
          ),
        );
      },
    );
  }
}
