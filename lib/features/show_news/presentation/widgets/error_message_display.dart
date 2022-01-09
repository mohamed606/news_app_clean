import 'package:flutter/material.dart';

class ErrorMessageDisplay extends StatelessWidget {
  final String message;

  ErrorMessageDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 25.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}