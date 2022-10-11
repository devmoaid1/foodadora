// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'package:foodadora/app/constants/assets.dart';

import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:foodadora/ui/widgets/foodadora_textfield.dart';

import '../../../../app/utilites/app_colors.dart';
import '../../../../app/utilites/screen_sizes.dart';
import '../viewmodels/profile_viewModel.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String image;
  final Color? color;

  const ProfileScreen({
    this.color,
    required this.name,
    required this.phone,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: foodadoraAppBar(context, withBack: true),
      body: ViewModelBuilder<ProfileViewModel>.nonReactive(
        viewModelBuilder: () => Get.find<ProfileViewModel>(),
        builder: (context, model, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context) * 5,
                vertical: blockSizeVertical(context) * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                      fontSize: blockSizeHorizontal(context) * 6,
                      color: textColor),
                ),
                verticalSpaceRegular,
                Form(
                  child: Column(
                    children: [
                      FoodadoraTextField(
                        readOnly: true,
                        intialValue: name,
                        name: "",
                        iconPath: Assets.usericon,
                        label: 'Name',
                        inputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSaved: null,
                      ),
                      FoodadoraTextField(
                        intialValue: phone,
                        readOnly: true,
                        name: "",
                        iconPath: Assets.phoneIcon,
                        label: 'Phone Number',
                        inputType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        onSaved: null,
                      ),
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth(context) * 0.8,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'You are registered with',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: blockSizeHorizontal(context) * 5,
                                  color: textColor,
                                ),
                              ),
                              horizontalSpaceSmall,
                              SvgPicture.asset(
                                image,
                                color: color,
                                width: blockSizeHorizontal(context) * 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: blockSizeHorizontal(context) * 6),
                        child: Divider(
                          color: dividerColor,
                          thickness: blockSizeVertical(context) / 4,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                FoodadoraButton(
                  label: 'Logout',
                  color: redColor,
                  onPressed: () => model.signOut(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
