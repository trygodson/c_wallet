import 'package:dapp/utils/global_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String labelText;
  TextEditingController etEmail;
  bool obscureText;

  CustomTextField(
      {required this.labelText,
      required this.etEmail,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      widget.obscureText = !widget.obscureText;
      if (widget.obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      validator: (value) {
        if (value!.isEmpty) return "Enter Email";
        if (!value.contains('@')) return "Email is invalid";
        return null;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.blueAccent,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      controller: widget.etEmail,
      style: GlobalStyle.normalStyle,
      decoration: InputDecoration(
        filled: true,
        focusColor: Colors.white,
        // fillColor: grey,
        // hoverColor: grey,
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.blue,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                onPressed: () {
                  _toggleObscureText();
                },
              )
            : null,
      ),
    );
  }
}
