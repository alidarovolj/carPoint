import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapWidget extends StatelessWidget {
  final YandexMapController? controller;
  final Point? currentLocation;
  final double currentZoom;
  final List<MapObject> mapObjects;
  final Function(YandexMapController) onMapCreated;
  final Function(CameraPosition, CameraUpdateReason, bool) onCameraPositionChanged;

  const MapWidget({
    Key? key,
    required this.controller,
    required this.currentLocation,
    required this.currentZoom,
    required this.mapObjects,
    required this.onMapCreated,
    required this.onCameraPositionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          height: constraints.maxHeight * 0.9, // 70% of the height
          child: currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : YandexMap(
            onMapCreated: onMapCreated,
            onCameraPositionChanged: onCameraPositionChanged,
            mapObjects: mapObjects,
          ),
        );
      },
    );
  }
}
