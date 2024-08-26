import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
    initMarkers();
    super.initState();
  }

  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: initialCameraPosition));
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/json/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());
    var imageFrame = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    var customMarkerItem = BitmapDescriptor.bytes(
        await getImageFromRawData('assets/images/icons8-marker-50.png', 30));
    var myMarker = places
        .map((e) => Marker(
            icon: customMarkerItem,
            infoWindow: InfoWindow(title: e.name),
            markerId: MarkerId(e.id.toString()),
            position: e.latlng))
        .toSet();

    markers.addAll(myMarker);
    setState(() {});
  }
}
