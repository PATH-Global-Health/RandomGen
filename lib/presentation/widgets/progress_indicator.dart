import 'package:flutter/material.dart';

class IndicateProgress extends StatelessWidget {
  final String message;

  const IndicateProgress({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10.0),
        Text(message),
      ],
    );
  }
}
