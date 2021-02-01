import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextFieldDecoration{

  static FieldDecoration() {
    return InputDecoration(
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.getPrimaryColor(),
      ),
      border: BorderStyle(),
      focusedBorder: BorderStyle(),
      enabledBorder: BorderStyle(),
      focusedErrorBorder: BorderStyle(),
    );
  }

  static BorderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.getPrimaryDarkColor(),
      ),
    );
  }
}