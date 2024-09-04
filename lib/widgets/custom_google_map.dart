import 'package:flutter/material.dart';
import 'package:google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 1, target: LatLng(31.110648030353488, 30.93923980939196));
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  bool isFirstCall = true;
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

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.location.changeSettings(distanceFilter: 2);
      locationService.getRealTimeLocation((locationData) {
        setMyLocationMarker(locationData);

        updateMyCameraPosition(locationData);
      });
    }
  }

  void updateMyCameraPosition(LocationData locationData) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 17);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!)));
    }
  }

  void setMyLocationMarker(LocationData locationData) {
    var myMarker = Marker(
        markerId: const MarkerId('my'),
        position: LatLng(locationData.latitude!, locationData.longitude!));

    markers.add(myMarker);
    setState(() {});
  }
}
