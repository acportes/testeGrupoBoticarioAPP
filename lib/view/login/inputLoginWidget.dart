import 'package:flutter/material.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';

class InputLoginWidget extends StatelessWidget {
  InputLoginWidget(this._inputLabel, this._inputIcon, this._margin,
      this._fieldSize, this._obscureText);

  final _inputLabel;
  final _inputIcon;
  final _fieldSize;
  final _margin;
  final _obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _margin != null
              ? _margin
              : const EdgeInsets.only(left: 40, top: 32),
          child: Text(
            _inputLabel,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.getPrimaryDarkColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 16.0),
              child: Icon(
                _inputIcon,
                color: AppColors.getPrimaryDarkColor(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
              child: Container(
                height: 60,
                width: 280,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: _fieldSize,
                  obscureText: _obscureText ? true : false,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: _textFieldDecoration(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _textFieldDecoration() {
    return InputDecoration(
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.getPrimaryColor(),
      ),
      border: _borderStyle(),
      focusedBorder: _borderStyle(),
      enabledBorder: _borderStyle(),
      focusedErrorBorder: _borderStyle(),
    );
  }

  _borderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.getPrimaryDarkColor(),
      ),
    );
  }
}
