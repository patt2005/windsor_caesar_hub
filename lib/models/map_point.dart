class MapPoint {
  final String name;
  final DateTime addedDate;
  final MapPointType mapPointType;

  MapPoint({
    required this.name,
    required this.addedDate,
    required this.mapPointType,
  });
}

enum MapPointType {
  works,
  building,
}
