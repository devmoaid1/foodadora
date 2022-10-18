// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/utilites/app_colors.dart';

import '../../app/utilites/screen_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodadoraTextField extends StatelessWidget {
  final String label;
  final String name;
  final String? intialValue;
  final String iconPath;
  final bool? readOnly;
  final TextInputType? inputType;
  final bool isObsecure;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  const FoodadoraTextField({
    Key? key,
    this.readOnly = false,
    this.intialValue,
    required this.name,
    required this.label,
    required this.iconPath,
    required this.inputType,
    this.onSaved,
    this.validator,
    this.isObsecure = false,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: blockSizeVertical(context)),
      child: FormBuilderTextField(
        initialValue: intialValue,
        readOnly: readOnly as bool,
        name: name.toString(),
        onSaved: onSaved,
        validator: validator,
        obscureText: isObsecure,
        style: TextStyle(
            color: textColor,
            fontFamily: 'Poppins',
            fontSize: (screenWidth(context) / 100) * 5),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(
            bottom: blockSizeHorizontal(context) * 5,
            top: blockSizeHorizontal(context) * 5,
          ),
          labelStyle: GoogleFonts.poppins(
              color: textColor, fontSize: (screenWidth(context) / 100) * 5),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: blockSizeHorizontal(context) * 6,
              right: blockSizeHorizontal(context) * 4,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: blockSizeHorizontal(context) * 5,
              color: textColor,
            ),
          ),
        ),
        keyboardType: inputType,
        textInputAction: textInputAction,
      ),
    );
  }
}
