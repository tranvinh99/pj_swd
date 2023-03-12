import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  final size = MediaQuery.of(context).size;

  Flushbar(
    maxWidth: size.width * .8,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.white,
    flushbarPosition: FlushbarPosition.TOP,
    messageColor: const Color(0xFF1D1E2C),
    messageSize: 16,
    message: content,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    icon: const Icon(
      Icons.check,
      size: 20.0,
      color: Colors.blue,
    ),
    duration: const Duration(seconds: 3),
  ).show(context);
}
