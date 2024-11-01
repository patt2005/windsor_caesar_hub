import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/map_point.dart';
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

  final MapPointType _currentMapType = MapPointType.building;

  final List<TextEditingController> _textControllers = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _showInputDialog(BuildContext context, int index) async {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Enter a name"),
          content: Column(
            children: [
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: _textControllers[index],
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
                // Handle the text input
                final inputText = _textControllers[index].text;
                // Do something with the input
                print("User input: $inputText");
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

  void _addMarker(LatLng position, int index) {
    final String markerId = _markers.length.toString();
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: _textControllers[index].text),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    final provider = Provider.of<AppManager>(context, listen: false);
    provider.addMapPoint(
      MapPoint(
        name: _textControllers[index].text,
        addedDate: DateTime.now(),
        mapPointType: _currentMapType,
      ),
    );
    _textControllers[index].clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text("Enter a name"),
                    content: Column(
                      children: [
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: _textController,
                          placeholder: "Type here...",
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 12),
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
                          // Handle the text input
                          final inputText = _textController.text;
                          // Do something with the input
                          print("User input: $inputText");
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
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
                          if (_textControllers.isNotEmpty) {
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
                ],
              ),
            ),
    );
  }
}
