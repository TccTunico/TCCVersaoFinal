import 'package:flutter/material.dart';

class TextFormFieldExt extends StatelessWidget {
  String _labelText;
  Icon _prefixIcon;
  TextEditingController _controller;
  TextInputType _keyboardType;
  bool _obscureText;
  int _maxLenght;
  int _maxLines;
  Function _onChanged;
  Function(String) _validator;

  TextFormFieldExt(
      {String labelText,
      Icon prefixIcon,
      TextEditingController controller,
      TextInputType keyboardType,
      bool obscureText,
      int maxLenght,
      int maxLines,
      Function onChanged,
      Function(String) validator}) {
    this._labelText = labelText;
    this._prefixIcon = prefixIcon;
    this._controller = controller;
    this._keyboardType = keyboardType;
    this._obscureText = obscureText;
    this._maxLenght = maxLenght;
    this._maxLines = maxLines;
    this._onChanged = onChanged;
    this._validator = validator;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        controller: _controller,
        keyboardType: _keyboardType ?? TextInputType.text,
        obscureText: _obscureText ?? false,
        maxLength: _maxLenght,
        maxLines: _maxLines,
        validator: _validator,
        minLines: 1,
        onChanged: _onChanged,
        decoration: InputDecoration(
          labelText: _labelText ?? '',
          prefixIcon: _prefixIcon,
        ),
      ),
    );
  }
}