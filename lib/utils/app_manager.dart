import 'package:flutter/cupertino.dart';
import 'package:windsor_caesar_hub/models/initiatives.text.dart';
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

  final List<Initiativestext> _initiatives = [
    Initiativestext(
      name: "Downtown Revitalization",
      variants: [
        "Improve public spaces with more green areas",
        "Attract more local businesses",
        "Create safer pedestrian zones",
        "Enhance cultural and recreational facilities"
      ],
      imageFilePath: "images/downtown_revitalization.jpg",
      isOwn: false,
    ),
    Initiativestext(
      name: "Sustainable Transportation",
      variants: [
        "Expand bike lanes across the city",
        "Introduce electric buses",
        "Encourage carpooling initiatives",
        "Improve public transit frequency"
      ],
      imageFilePath: "images/sustainable_transportation.webp",
      isOwn: false,
    ),
    Initiativestext(
      name: "Waterfront Development",
      variants: [
        "Add more parks along the waterfront",
        "Promote waterfront events and festivals",
        "Establish waterfront dining and retail",
        "Develop eco-friendly recreational activities"
      ],
      imageFilePath: "images/waterfront_development.webp",
      isOwn: false,
    ),
    Initiativestext(
      name: "Community Safety",
      variants: [
        "Increase neighborhood watch programs",
        "Enhance lighting in public spaces",
        "Improve emergency response times",
        "Engage community in crime prevention"
      ],
      imageFilePath: "images/community_safety.webp",
      isOwn: false,
    ),
  ];

  List<Initiativestext> get initiatives => _initiatives;

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

  void addInitiavtive(Initiativestext initativeText) {
    _initiatives.insert(0, initativeText);
    notifyListeners();
  }

  void markInitiativeAsAnswered(Initiativestext initiate) {
    _initiatives.firstWhere((e) => e == initiate).isAnswered = true;
    notifyListeners();
  }
}
