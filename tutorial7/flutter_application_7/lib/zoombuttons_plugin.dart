import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class FlutterMapZoomButtons extends StatelessWidget {
  const FlutterMapZoomButtons({
    super.key,
    required this.mapController,
    this.minZoom = 4,
    this.maxZoom = 19,
    this.mini = true,
    this.padding = 10,
    this.alignment = Alignment.bottomRight,
  });

  final MapController mapController;
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final buttonSize = mini ? 42.0 : 56.0;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ZoomButton(
              size: buttonSize,
              icon: Icons.add,
              onPressed: () => _zoomBy(1),
            ),
            const SizedBox(height: 8),
            _ZoomButton(
              size: buttonSize,
              icon: Icons.remove,
              onPressed: () => _zoomBy(-1),
            ),
          ],
        ),
      ),
    );
  }

  void _zoomBy(double delta) {
    final camera = mapController.camera;
    final nextZoom = (camera.zoom + delta).clamp(minZoom, maxZoom).toDouble();
    mapController.move(camera.center, nextZoom);
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.size,
    required this.icon,
    required this.onPressed,
  });

  final double size;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: FloatingActionButton(
        heroTag: null,
        mini: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
