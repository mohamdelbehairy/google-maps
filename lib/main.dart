import 'package:flutter/material.dart';

import 'widgets/custom_google_map.dart';

void main() {
  runApp(const GoogleMapsWithFlutter());
}

class GoogleMapsWithFlutter extends StatelessWidget {
  const GoogleMapsWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMap(),
    );
  }
}