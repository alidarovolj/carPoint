import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:startup_app/stores/test_data_fetch/test_data_fetch.dart';
import 'package:startup_app/stores/test_data_fetch/models/test_data.dart';
import 'package:startup_app/widgets/zoom_controls.dart';
import 'package:startup_app/widgets/map_widget.dart';
import 'package:startup_app/widgets/location_button.dart';
import 'package:startup_app/widgets/bottom_navigation.dart';
import 'package:startup_app/widgets/draggable_sheet.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  YandexMapController? _controller;
  Point? _currentLocation;
  double _currentZoom = 16.0;
  StreamSubscription<Position>? _positionStreamSubscription;
  final List<MapObject> _mapObjects = [];
  List<TestData> _testDataList = [];

  int currentIndex = 0;
  double _currentExtent = 0.3;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchTestData();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _fetchTestData() async {
    TestDataFetch testDataFetch = TestDataFetch();
    List<TestData> data = await testDataFetch.testDataFetch();
    setState(() {
      _testDataList = data;
      _updatePlacemark();
    });
  }

  Future<void> _getCurrentLocation() async {
    if (!await _isLocationServiceEnabled()) {
      _setDefaultLocation();
      return;
    }

    LocationPermission permission = await _checkAndRequestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _setDefaultLocation();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      _updateLocation(position);
      _listenToLocationChanges();
    } catch (e) {
      _setDefaultLocation();
    }
  }

  Future<bool> _isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  void _setDefaultLocation() {
    setState(() {
      _currentLocation = const Point(
          latitude: 43.24602609095011, longitude: 76.90537098169047);
      _updatePlacemark();
      _moveToCurrentLocation();
    });
  }

  void _updateLocation(Position position) {
    setState(() {
      _currentLocation =
          Point(latitude: position.latitude, longitude: position.longitude);
      _updatePlacemark();
      _moveToCurrentLocation();
    });
  }

  void _listenToLocationChanges() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _updateLocation(position);
    });
  }

  void _updatePlacemark() {
    _mapObjects
        .removeWhere((mapObject) => mapObject.mapId.value == 'placemark_1');

    if (_currentLocation != null) {
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: const MapObjectId('placemark_1'),
          point: _currentLocation!,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('lib/assets/user.png'),
              scale: 1.5,
            ),
          ),
        ),
      );
      debugPrint('User location added: $_currentLocation');
    }

    for (var item in _testDataList) {
      if (!_mapObjects.any(
          (mapObject) => mapObject.mapId.value == 'placemark_${item.title}')) {
        _mapObjects.add(
          PlacemarkMapObject(
            mapId: MapObjectId('placemark_${item.title}'),
            point: Point(latitude: item.latitude, longitude: item.longitude),
            text: PlacemarkText(
              text: item.title,
              style: const PlacemarkTextStyle(
                color: Colors.black,
              ),
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    'lib/assets/images/map_pin.jpg'),
                scale: 1,
              ),
            ),
          ),
        );
        debugPrint(
            'Placemark added: ${item.title} at (${item.latitude}, ${item.longitude})');
      }
    }
  }

  Future<void> _moveToCurrentLocation() async {
    if (_controller != null && _currentLocation != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      _controller!.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: _currentZoom = 16.0),
        ),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.5),
      );
    }
  }

  Future<void> _loadMapStyle() async {
    try {
      String styleJson =
          await rootBundle.loadString('lib/assets/map_style.json');
      await _controller?.setMapStyle(styleJson);
    } catch (e) {
      debugPrint('Error loading map style: $e');
    }
  }

  void _zoomIn() {
    if (_controller != null) {
      setState(() {
        _currentZoom += 1;
        _controller!.moveCamera(
          CameraUpdate.zoomTo(_currentZoom),
          animation:
              const MapAnimation(type: MapAnimationType.smooth, duration: 0.5),
        );
      });
    }
  }

  void _zoomOut() {
    if (_controller != null) {
      setState(() {
        _currentZoom -= 1;
        _controller!.moveCamera(
          CameraUpdate.zoomTo(_currentZoom),
          animation:
              const MapAnimation(type: MapAnimationType.smooth, duration: 0.5),
        );
      });
    }
  }

  void _centerToCurrentLocation() {
    if (_controller != null && _currentLocation != null) {
      _controller!.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: _currentZoom = 16.0),
        ),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.5),
      );
    }
  }

  bool get isSheetFullyOpen => _currentExtent == 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            controller: _controller,
            currentLocation: _currentLocation,
            currentZoom: _currentZoom,
            mapObjects: _mapObjects,
            onMapCreated: (YandexMapController controller) async {
              _controller = controller;
              await _loadMapStyle();
              _moveToCurrentLocation();
            },
            onCameraPositionChanged: (CameraPosition cameraPosition,
                CameraUpdateReason reason, bool finished) {
              setState(() {
                _currentZoom = cameraPosition.zoom;
              });
            },
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.35,
            child: ZoomControls(
              onZoomIn: _zoomIn,
              onZoomOut: _zoomOut,
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.5,
            child: LocationButton(
              onPressed: _centerToCurrentLocation,
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x2E8D91B7),
                      offset: Offset(0, 2),
                      blurRadius: 9,
                      spreadRadius: 0
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('Добавить автомобиль', style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  Image.asset('lib/assets/images/car.png', width: 56),
                ],
              ),
            ),
          ),
          DraggableSheet(
            currentExtent: _currentExtent,
            scrollController: ScrollController(),
            testDataList: _testDataList,
            onNotification: (DraggableScrollableNotification notification) {
              setState(() {
                _currentExtent = notification.extent; // Track the extent
                if (isSheetFullyOpen) {
                  debugPrint('DraggableScrollableSheet is fully open');
                }
              });
              return true;
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
