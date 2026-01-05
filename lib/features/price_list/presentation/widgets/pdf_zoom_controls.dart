import 'package:flutter/material.dart';

class PdfZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const PdfZoomControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.zoom_in),
          onPressed: onZoomIn,
        ),
        IconButton(
          icon: const Icon(Icons.zoom_out),
          onPressed: onZoomOut,
        ),
      ],
    );
  }
}

