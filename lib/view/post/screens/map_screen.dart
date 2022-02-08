import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pesostagram/deta_models/location.dart';

class MapScreen extends StatefulWidget {
  final Location location;

  const MapScreen({required this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng _latLng;
  late CameraPosition _cameraPosition;
  GoogleMapController? _mapController;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  void initState() {
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);
    _cameraPosition = CameraPosition(target: _latLng, zoom: 10.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("場所を選択"),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.done)
          )
        ],
      ),

      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onTap: (LatLng latLng) {
          _latLng = latLng;
          _createMarker(_latLng);
        },
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }

  void _createMarker(LatLng latLng) {
    final markerId = MarkerId("selected");
    final marker = Marker(markerId: markerId, position: latLng);
    setState(() {
      _markers[markerId] = marker;
    });
  }
}
