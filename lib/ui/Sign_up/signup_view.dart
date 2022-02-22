import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/ui/Sign_up/signup_viewModel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => signUpViewModel,
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: blockSizeVertical(context) * 10,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  LineIcons.angleLeft,
                  color: Theme.of(context).primaryColor,
                  size: blockSizeHorizontal(context) * 8,
                ),
                onPressed: () => Navigator.pop(context)),
            title: Padding(
              padding: EdgeInsets.all(blockSizeHorizontal(context)),
              child: Image.asset(
                'assets/images/sublogo.png',
                height: blockSizeVertical(context) * 8.5,
              ),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: blockSizeVertical(context) * 3,
                    horizontal: blockSizeHorizontal(context) * 5),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontFamily: 'Raleway',
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
                                icon: LineIcons.signature,
                                inputType: TextInputType.text,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: "name is Required")
                                ]),
                              ),
                              FoodadoraTextField(
                                name: "email",
                                label: 'Email',
                                icon: LineIcons.envelope,
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
                                icon: LineIcons.key,
                                inputType: TextInputType.text,
                                isObsecure: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: "password is Required"),
                                ]),
                              ),
                              FoodadoraTextField(
                                name: 'phoneNumber',
                                label: 'Phone Number',
                                icon: LineIcons.mobilePhone,
                                inputType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: "phone is Required"),
                                ]),
                              ),
                            ],
                          )),
                      SizedBox(height: blockSizeVertical(context) * 2),
                      FoodadoraButton(
                        label: 'Signup',
                        onPressed: () {
                          _formKey.currentState!.save();

                          if (_formKey.currentState!.validate()) {
                            final name = _formKey.currentState!.value['name'];

                            final email = _formKey.currentState!.value['email'];
                            final password =
                                _formKey.currentState!.value['password'];
                            final phoneNumber =
                                _formKey.currentState!.value['phoneNumber'];

                            model.signUpNewUser(
                                email: email,
                                name: name,
                                password: password,
                                phoneNumber: phoneNumber);
                          }
                        },
                      ),
                      SizedBox(height: blockSizeVertical(context) * 2),
                      _buildOrRow(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Color(0xff3b5998),
                            child: Image.asset(
                              'assets/icons/facebook.png',
                              color: Colors.white,
                              width: blockSizeHorizontal(context) * 9,
                            ),
                            padding: EdgeInsets.all(
                                blockSizeHorizontal(context) * 3),
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () async {
                              // var result = await viewmodel.googleSignin();
                              // print('USER FROM SIGNUP $result');
                              // if (result == null) return;
                              // if (result.additionalUserInfo.isNewUser) {
                              //   Navigator.pushNamed(context, phoneRoute,
                              //       arguments: result);
                              // } else {
                              //   Navigator.pushReplacementNamed(
                              //       context, homeRoute);
                              // }
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Image.asset(
                              'assets/icons/google.png',
                              width: blockSizeHorizontal(context) * 9,
                            ),
                            padding: EdgeInsets.all(
                                blockSizeHorizontal(context) * 3),
                            shape: CircleBorder(),
                          ),
                        ],
                      )
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

Padding _buildOrRow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context) * 10,
        vertical: blockSizeVertical(context) * 2),
    child: Row(children: <Widget>[
      Expanded(child: Divider(color: Colors.black)),
      Text(
        "  OR  ",
        style: TextStyle(
          color: Colors.black,
          fontSize: blockSizeHorizontal(context) * 4,
        ),
      ),
      Expanded(
          child: Divider(
        color: Colors.black,
      )),
    ]),
  );
}
