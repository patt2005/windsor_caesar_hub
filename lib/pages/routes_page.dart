import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/api/route_api.dart';
import 'package:windsor_caesar_hub/models/map_route.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool _isControllerCompleted = false;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final List<TextEditingController> _textControllers = [];

  int _selectedMapRoute = 0;

  bool _hasFinishedAdding = false;

  @override
  void initState() {
    super.initState();
    _loadSavedRoutesAndPoints();
    _getUserLocation();
  }

  Future<void> _showInputDialog(BuildContext context) async {
    final textController = TextEditingController();

    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Enter the point name"),
          content: Column(
            children: [
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: textController,
                placeholder: "Type here...",
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text("Submit"),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  _textControllers.add(textController);
                  _hasFinishedAdding = true;
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertDialog(String title, String text) async {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position currentPosition = await Geolocator.getCurrentPosition();
      userLocation = CameraPosition(
        zoom: 14,
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
      );
    }
    setState(() {});
  }

  Future<void> _drawRoute() async {
    final provider = Provider.of<AppManager>(context, listen: false);

    setState(() {
      _polylines.clear();
    });

    if (provider.mapRoutes.isEmpty ||
        provider.mapRoutes[_selectedMapRoute].mapRoutePoints.length < 2) {
      return;
    }

    try {
      final geometryString = await RouteApi().getGeometryString(
          provider.mapRoutes[_selectedMapRoute].mapRoutePoints);
      final polylinePoints = decodePolyline(geometryString);

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route_path'),
            points: polylinePoints,
            color: Colors.black,
            width: 5,
          ),
        );
      });

      provider.mapRoutes[_selectedMapRoute].polylines = polylinePoints;
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
  }

  Future<void> _loadSavedRoutesAndPoints() async {
    final provider = Provider.of<AppManager>(context, listen: false);
    if (provider.mapRoutes.isNotEmpty) {
      _updateMarkersAndPolylines();
    }
  }

  void _updateMarkersAndPolylines() {
    final provider = Provider.of<AppManager>(context, listen: false);
    final selectedRoute = provider.mapRoutes[_selectedMapRoute];

    setState(() {
      _markers.clear();
      _polylines.clear();

      for (var point in selectedRoute.mapRoutePoints) {
        _markers.add(
          Marker(
            markerId: MarkerId(point.name),
            position: point.location,
            infoWindow: InfoWindow(title: point.name),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }

      if (selectedRoute.polylines.isNotEmpty) {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route_path'),
            points: selectedRoute.polylines,
            color: Colors.black,
            width: 5,
          ),
        );
      }
    });
  }

  void _addMarker(LatLng position) async {
    final String markerId = _markers.length.toString();
    final provider = Provider.of<AppManager>(context, listen: false);

    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: _textControllers.last.text),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    final newMapRoutePoint =
        MapRoutePoint(name: _textControllers.last.text, location: position);

    if (provider.mapRoutes.isEmpty) {
      provider.addMapRoute(
        MapRoute(
          mapRoutePoints: [newMapRoutePoint],
          polylines: [],
        ),
      );
    } else {
      provider.addToMapRoute(
        _selectedMapRoute,
        newMapRoutePoint,
      );
    }

    _textControllers.last.clear();
    _hasFinishedAdding = false;

    await _drawRoute();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              _hasFinishedAdding = false;
              _showInputDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 7),
        ],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Routes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: userLocation == null
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.03),
                  SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        polylines: _polylines,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) async {
                          if (!_isControllerCompleted) {
                            _controller.complete(controller);
                            _isControllerCompleted = true;
                          }
                        },
                        myLocationEnabled: true,
                        markers: _markers,
                        onTap: (argument) {
                          if (_textControllers.isNotEmpty &&
                              _hasFinishedAdding) {
                            _addMarker(argument);
                          } else {
                            _showAlertDialog(
                              "Add Map Point",
                              "You can add a new map point by selecting one of the options below.",
                            );
                          }
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: userLocation!,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "List",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Consumer<AppManager>(
                    builder: (context, value, child) => Expanded(
                      flex: 2,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: value.mapRoutes.length,
                        itemBuilder: (context, index) {
                          final route = value.mapRoutes[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(CupertinoIcons.map,
                                color: Colors.orange),
                            title: Text("Route ${index + 1}"),
                            subtitle: Text(
                                "${route.mapRoutePoints.first.name} - ${route.mapRoutePoints.last.name}"),
                            onTap: () {
                              setState(() {
                                _selectedMapRoute = index;
                              });
                              _updateMarkersAndPolylines();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
