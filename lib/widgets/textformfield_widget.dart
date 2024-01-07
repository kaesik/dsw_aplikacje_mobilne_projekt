import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    // required this.labelText,
    // required this.hintText,
    // required this.icon,
  });

  // final String labelText;
  // final String hintText;
  // final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email or User Name",
        hintText: "Enter your email",
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFF9747FF), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFF471AA0), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        prefixIcon: Icon(
          Icons.person_outlined,
          color: Color(0xFF471AA0),
        ),
      ),
    );
  }
}
