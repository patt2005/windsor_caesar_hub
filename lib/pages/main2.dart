import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/map_point.dart';
import 'package:windsor_caesar_hub/models/news.dart';
import 'package:windsor_caesar_hub/pages/news_info_page.dart';
import 'package:windsor_caesar_hub/pages/routes_page.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class Main2 extends StatefulWidget {
  const Main2({super.key});

  @override
  _Main2State createState() => _Main2State();
}

class _Main2State extends State<Main2> with TickerProviderStateMixin {
  late TabController _tabController;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool _isControllerCompleted = false;

  final Set<Marker> _markers = {};

  MapPointType _currentMapType = MapPointType.building;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getUserLocation();
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

  void _addMarker(LatLng position) {
    final String markerId = _markers.length.toString();
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: _textController.text),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    final provider = Provider.of<AppManager>(context, listen: false);
    provider.addMapPoint(
      MapPoint(
        name: _textController.text,
        addedDate: DateTime.now(),
        mapPointType: _currentMapType,
      ),
    );
    _textController.clear();
    setState(() {});
  }

  Widget _buildNewsCard(News newsInfo) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => NewsInfoPage(newsInfo: newsInfo),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              newsInfo.title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "images/arrow.png",
                  width: screenSize.height * 0.02,
                  height: screenSize.height * 0.02,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Main",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]),
                  child: TabBar(
                    onTap: (value) {
                      setState(() {});
                    },
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.0,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xFFD4BA15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text("News"),
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text("Map"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _tabController.index == 0
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 2.5,
                          ),
                          itemCount: windsorNews.length,
                          itemBuilder: (context, index) {
                            return _buildNewsCard(windsorNews[index]);
                          },
                        ),
                      )
                    : userLocation == null
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenSize.width,
                                height: screenSize.height * 0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: GoogleMap(
                                    myLocationButtonEnabled: false,
                                    onMapCreated:
                                        (GoogleMapController controller) async {
                                      if (!_isControllerCompleted) {
                                        _controller.complete(controller);
                                        _isControllerCompleted = true;
                                      }
                                    },
                                    myLocationEnabled: true,
                                    markers: _markers,
                                    onTap: (argument) {
                                      if (_textController.text.isNotEmpty) {
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
                              SizedBox(height: screenSize.height * 0.01),
                              SizedBox(
                                height: screenSize.height * 0.05,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            const WidgetStatePropertyAll(0),
                                        backgroundColor: WidgetStatePropertyAll(
                                          primaryColor,
                                        ),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        _currentMapType = MapPointType.works;
                                        await showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: const Text(
                                                  "Enter place name"),
                                              content: Column(
                                                children: [
                                                  const SizedBox(height: 8.0),
                                                  CupertinoTextField(
                                                    controller: _textController,
                                                    placeholder:
                                                        "Type name here...",
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
                                                    Navigator.of(context).pop();
                                                    _showAlertDialog(
                                                        "Select Map Location",
                                                        "Now, please select a point on the map to add your place.");
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text("Add road works"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            const WidgetStatePropertyAll(0),
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                          Color(0xFF759CFF),
                                        ),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        _currentMapType = MapPointType.building;
                                        await showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: const Text(
                                                  "Enter place name"),
                                              content: Column(
                                                children: [
                                                  const SizedBox(height: 8.0),
                                                  CupertinoTextField(
                                                    controller: _textController,
                                                    placeholder:
                                                        "Type name here...",
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
                                                    Navigator.of(context).pop();
                                                    _showAlertDialog(
                                                        "Select Map Location",
                                                        "Now, please select a point on the map to add your place.");
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text("Add building"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            const WidgetStatePropertyAll(0),
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                          Color(0xFFD3FFCC),
                                        ),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const RoutesPage(),
                                          ),
                                        );
                                      },
                                      child: const Text("Add route"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.02),
                              const Text(
                                "List",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Consumer<AppManager>(
                                builder: (context, value, child) {
                                  if (value.mapPoints.isEmpty) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: screenSize.height * 0.05,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "There are no map points on the map yet."),
                                        ],
                                      ),
                                    );
                                  }
                                  return SizedBox(
                                    height: screenSize.height * 0.2,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: value.mapPoints.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              trailing: Text(
                                                DateFormat('HH:mm, dd/MM/yy')
                                                    .format(value
                                                        .mapPoints[index]
                                                        .addedDate),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                value.mapPoints[index].name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              subtitle: Text(
                                                value.mapPoints[index]
                                                            .mapPointType ==
                                                        MapPointType.building
                                                    ? "Building"
                                                    : "Road works",
                                              ),
                                              leading: Container(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color: value.mapPoints[index]
                                                              .mapPointType ==
                                                          MapPointType.works
                                                      ? Colors.yellow
                                                      : Colors.blueAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  value.mapPoints[index]
                                                              .mapPointType ==
                                                          MapPointType.building
                                                      ? CupertinoIcons
                                                          .building_2_fill
                                                      : CupertinoIcons.wrench,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
