import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latlng;

  PlaceModel({required this.id, required this.name, required this.latlng});
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: "قاعة الملكة للأفراح والمناسبات",
      latlng: const LatLng(31.111654143693205, 30.98018499545421)),
  PlaceModel(
      id: 2,
      name: "مستشفى كفرالشيخ الجامعي",
      latlng: const LatLng(31.10107070544538, 30.95572315845787)),
  PlaceModel(
      id: 3,
      name: "قراجة",
      latlng: const LatLng(31.12378036028801, 30.984994775892066))
];
