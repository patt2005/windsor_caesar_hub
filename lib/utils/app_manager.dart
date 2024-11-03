import 'package:flutter/cupertino.dart';
import 'package:windsor_caesar_hub/models/map_point.dart';
import 'package:windsor_caesar_hub/models/map_route.dart';
import 'package:windsor_caesar_hub/models/user.dart';
import 'package:windsor_caesar_hub/models/voluntarism.text.dart';

class AppManager extends ChangeNotifier {
  final List<MapPoint> _mapPoints = [];
  List<MapPoint> get mapPoints => _mapPoints;

  final List<MapRoute> _mapRoutes = [];
  List<MapRoute> get mapRoutes => _mapRoutes;

  final List<Voluntarism> _voluntarimsList = [];
  List<Voluntarism> get voluntarismList => _voluntarimsList;

  User? _userInfo;
  User? get userInfo => _userInfo;

  void addMapPoint(MapPoint mapPoint) {
    _mapPoints.add(mapPoint);
    notifyListeners();
  }

  void addMapRoute(MapRoute mapRoute) {
    _mapRoutes.add(mapRoute);
    notifyListeners();
  }

  void changeVoluntarismStatus(Voluntarism voluntarism) {
    _voluntarimsList.firstWhere((e) => e == voluntarism).isEnrolled = true;
    notifyListeners();
  }

  void addToMapRoute(int index, MapRoutePoint mapRoutePoint) {
    _mapRoutes[index].mapRoutePoints.add(mapRoutePoint);
    notifyListeners();
  }

  void addVoluntarism(Voluntarism voluntarism) {
    _voluntarimsList.add(voluntarism);
    notifyListeners();
  }

  void setUserInfo(User user) {
    _userInfo = user;
    notifyListeners();
  }
}
