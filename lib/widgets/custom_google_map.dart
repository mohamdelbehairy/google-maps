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
        zoom: 10, target: LatLng(31.110648030353488, 30.93923980939196));
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
        fillColor: Colors.black.withOpacity(.5),
        strokeWidth: 3,
        polygonId: const PolygonId("1"),
        points: const [
          LatLng(31.178443621752827, 30.784911395646326),
          LatLng(31.169097772274174, 31.043265987024547),
          LatLng(30.971524047815137, 30.958844977186),
        ]);

    polygons.add(polygon);
  }
}
