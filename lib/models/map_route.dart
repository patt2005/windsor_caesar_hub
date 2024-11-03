import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoute {
  final List<MapRoutePoint> mapRoutePoints;
  List<LatLng> polylines;

  MapRoute({
    required this.mapRoutePoints,
    required this.polylines,
  });
}

class MapRoutePoint {
  final String name;
  final LatLng location;

  MapRoutePoint({
    required this.name,
    required this.location,
  });
}
