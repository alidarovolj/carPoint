import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      mini: true,
      child: const Icon(Icons.my_location, color: Colors.black),
    );
  }
}
