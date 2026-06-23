import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'zoombuttons_plugin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapController _mapController = MapController();

  static const double _initialZoom = 15;
  static const LatLng _mapCenter = LatLng(28.17627, 112.98318);

  static const LatLng _home = LatLng(28.17539, 112.98785);
  static const LatLng _helongGym = LatLng(28.18153, 112.97715);
  static const LatLng _school = LatLng(28.17188, 112.98453);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'Tutorial 7 Map Explorer',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: _buildMap(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          _mapController.move(_mapCenter, _initialZoom);
        },
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: _mapCenter,
        initialZoom: _initialZoom,
        minZoom: 4,
        maxZoom: 19,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.doubleTapZoom,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.flutter_application_7',
        ),
        MarkerLayer(
          markers: [
            _placeMarker(_home, 'Home', Colors.red),
            _placeMarker(_helongGym, 'Helong gym', Colors.green),
            _placeMarker(_school, 'School', Colors.blue),
          ],
        ),
        FlutterMapZoomButtons(
          mapController: _mapController,
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomLeft,
        ),
      ],
    );
  }

  Marker _placeMarker(LatLng point, String name, Color color) {
    return Marker(
      point: point,
      width: 60,
      height: 60,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$name (${point.latitude.toStringAsFixed(5)}, '
                '${point.longitude.toStringAsFixed(5)})',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Icon(Icons.location_pin, size: 50, color: color),
      ),
    );
  }
}
