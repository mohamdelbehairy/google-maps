import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late Location location;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(31.110648030353488, 30.93923980939196));
    location = Location();
    updateMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            markers: markers,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: initialCameraPosition));
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/json/night_map_style.json');

    googleMapController!.setMapStyle(nightMapStyle);
  }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        log('location service is not enabled');
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void getLocationData() {
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen((locationData) {
      log('lat: ${locationData.latitude}, lng: ${locationData.longitude}');
      var cameraPosition = CameraPosition(
          zoom: 15,
          target: LatLng(locationData.latitude!, locationData.longitude!));

      var myMarker = Marker(
          markerId: const MarkerId('my'),
          position: LatLng(locationData.latitude!, locationData.longitude!));

      markers.add(myMarker);
      setState(() {});
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      getLocationData();
      log('location data updated');
    }
  }
}

// inquire about location service
// request permission from user
// get location
// display location