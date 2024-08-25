import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(31.110648030353488, 30.93923980939196));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                southwest: const LatLng(31.056050531009273, 30.665672582225334),
                northeast:
                    const LatLng(31.193722432145453, 31.207086622541325))),
            initialCameraPosition: initialCameraPosition));
  }
}
