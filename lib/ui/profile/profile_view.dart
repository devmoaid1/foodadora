// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:foodadora/ui/profile/profile_viewModel.dart';

import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/screen_sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<ProfileViewModel>.reactive(
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
          if (!model.isLoggedOn) {
            return Center(
              child: Text(
                "you are not logged on",
                style: GoogleFonts.poppins(
                  fontSize: blockSizeHorizontal(context) * 3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          if (model.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context) * 5,
                  vertical: blockSizeVertical(context) * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style:
                        TextStyle(fontSize: blockSizeHorizontal(context) * 8),
                  ),
                  SizedBox(height: blockSizeVertical(context) * 5),
                  Form(
                    child: Column(
                      children: [
                        FoodadoraTextField(
                          readOnly: true,
                          intialValue: model.customerProfile.name,
                          name: "",
                          icon: LineIcons.signature,
                          label: 'Name',
                          inputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSaved: null,
                          validator: null,
                        ),
                        FoodadoraTextField(
                          intialValue: model.customerProfile.phoneNumber,
                          readOnly: true,
                          name: "",
                          icon: LineIcons.mobilePhone,
                          label: 'Phone Number',
                          inputType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onSaved: null,
                          validator: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: blockSizeVertical(context) * 5),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth(context) * 0.8,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(
                              children: [
                                Text(
                                  'You are registered with',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: blockSizeHorizontal(context) * 8,
                                    fontFamily: 'Poppins',
                                    color: const Color(0xffC4C4C4),
                                  ),
                                ),
                                SizedBox(
                                  width: blockSizeHorizontal(context) * 5,
                                ),
                                Icon(
                                  LineIcons.envelope,
                                  size: blockSizeHorizontal(context) * 15,
                                  color: const Color(0xffA5A5A5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: blockSizeHorizontal(context) * 8),
                          child: Divider(
                            color: const Color(
                              0xffDEDEDE,
                            ),
                            thickness: blockSizeVertical(context) / 4,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: blockSizeVertical(context) * 15),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockSizeHorizontal(context) * 7),
                    child: FoodadoraButton(
                      label: 'Logout',
                      color: Colors.red,
                      onPressed: () {
                        model.signOut();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
