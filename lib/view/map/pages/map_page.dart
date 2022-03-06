import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pesostagram/view/map/components/map_modal.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../deta_models/owner.dart';
import '../../../view_models/map_view_model.dart';

class MapPage extends StatefulWidget {

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    getOwner();

    super.initState();
  }

  Future<void> getOwner() async {
    final mapViewModel = context.read<MapViewModel>();
    await mapViewModel.getOwnerInfo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextButton(
          child: Text("場所を検索"),
          onPressed: null,
        ),
      ),

      body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 10
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _createMarker(context),
          )
    );
  }


  Set<Marker> _createMarker(BuildContext context) {
    final mapViewModel = context.read<MapViewModel>();
    var map = <Marker>{};
    mapViewModel.owners.forEach((Owner owner) {

      map.add(
          Marker(
              markerId: MarkerId(Uuid().v1().toString()),
              position: LatLng(double.parse(owner.latitude), double.parse(owner.longitude)),
              infoWindow: InfoWindow(title: owner.shopName),
              //タップしたらModal表示
              onTap: () => openModalPage(context, owner)
          )
      );
    });

    return map;
  }

  void openModalPage(BuildContext context, Owner owner) async {

    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => MapModal(markerOwner: owner)
    ));
  }



}
