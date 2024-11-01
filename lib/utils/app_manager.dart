import 'package:flutter/cupertino.dart';
import 'package:windsor_caesar_hub/models/map_point.dart';

class AppManager extends ChangeNotifier {
  final List<MapPoint> _mapPoints = [];
  List<MapPoint> get mapPoints => _mapPoints;

  void addMapPoint(MapPoint mapPoint) {
    _mapPoints.add(mapPoint);
    notifyListeners();
  }
}
