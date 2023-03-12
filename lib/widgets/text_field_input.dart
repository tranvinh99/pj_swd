import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPass;
  final TextInputType type;
  final Widget? prefixIcon;

  const TextFieldInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPass = false,
    this.type = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        labelText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }

        return null;
      },
    );
  }
}
