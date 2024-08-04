import 'package:flutter/material.dart';

class ZoomControls extends StatelessWidget {
  const ZoomControls({super.key, this.onZoomIn, this.onZoomOut});

  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: 'zoomIn',
          onPressed: onZoomIn,
          backgroundColor: Colors.white,
          mini: true,
          child: const Icon(Icons.add, color: Colors.black),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'zoomOut',
          onPressed: onZoomOut,
          backgroundColor: Colors.white,
          mini: true,
          child: const Icon(Icons.remove, color: Colors.black),
        ),
      ],
    );
  }
}
