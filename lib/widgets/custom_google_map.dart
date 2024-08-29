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
        zoom: 5, target: LatLng(31.110648030353488, 30.93923980939196));
    initPolygons();
    super.initState();
  }

  late GoogleMapController googleMapController;
  Set<Polygon> polygons = {};

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            zoomControlsEnabled: false,
            polygons: polygons,
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

  void initPolygons() {
    var polygon = Polygon(
        holes: const [
          [
            LatLng(30.58752361453692, 32.482966672896424),
            LatLng(29.31844612012362, 31.060064752382395),
            LatLng(31.17113510216704, 30.45572799749488),
          ]
        ],
        strokeWidth: 3,
        fillColor: Colors.black.withOpacity(.5),
        polygonId: const PolygonId("1"),
        points: const [
          LatLng(31.321677885753406, 34.22561417039702),
          LatLng(28.045145471507574, 34.30369971932929),
          LatLng(30.930203551901297, 32.437115811284826),
          LatLng(29.676350990493866, 32.24695183428005),
          LatLng(23.135719717496976, 35.52223459097894),
          LatLng(21.996033624127318, 33.260437164203374),
          LatLng(22.072192353060217, 25.035139520401177),
          LatLng(29.26033051444404, 24.93657069809218),
          LatLng(30.160563268072973, 24.612188388815692),
          LatLng(30.86488606205762, 24.967045800951283),
          LatLng(31.42954780569916, 24.793323977061565),
          LatLng(31.634439490004333, 25.095245564836922),
          LatLng(31.582184324434863, 31.10555531368021)
        ]);

    polygons.add(polygon);
  }
}
