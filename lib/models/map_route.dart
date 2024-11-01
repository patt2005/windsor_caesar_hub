import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoute {
  final List<MapRoutePoint> mapRoutePoints;

  MapRoute({required this.mapRoutePoints});
}

class MapRoutePoint {
  final String name;
  final LatLng location;

  MapRoutePoint({
    required this.name,
    required this.location,
  });
}
