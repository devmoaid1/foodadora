import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:foodadora/ui/utilites/screen_sizes.dart';

class FoodadoraTextField extends StatelessWidget {
  final String? label;
  final String? name;
  final IconData? icon;
  final TextInputType? inputType;
  final bool isObsecure;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  const FoodadoraTextField({
    Key? key,
    required this.name,
    @required this.label,
    @required this.icon,
    @required this.inputType,
    this.onSaved,
    @required this.validator,
    this.isObsecure = false,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: (screenWidth(context) / 100) * 2),
      child: FormBuilderTextField(
        name: name.toString(),
        onSaved: onSaved,
        validator: validator,
        obscureText: isObsecure,
        style: TextStyle(
            color: const Color(0xffA5A5A5),
            fontFamily: 'Poppins',
            fontSize: (screenWidth(context) / 100) * 5),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
              color: const Color(0xffA5A5A5),
              fontFamily: 'Poppins',
              fontSize: (screenWidth(context) / 100) * 5),
          prefixIcon: Icon(
            icon,
            color: const Color(0xffA5A5A5),
            size: (screenWidth(context) / 100) * 8,
          ),
        ),
        keyboardType: inputType,
        textInputAction: textInputAction,
      ),
    );
  }
}
