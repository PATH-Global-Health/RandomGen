import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  final String username;
  const PlaceScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RandomGen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Place list',
            ),
          ],
        ),
      ),
    );
  }
}
