import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../widgets/address_bottom_sheet.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  late YandexMapController mapController;
  Point selectedPoint = Point(latitude: 41.311151, longitude: 69.279737);
  final MapObjectId placemarkId = MapObjectId('selected_placemark');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Address",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) async {
              mapController = controller;
              await mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: selectedPoint, zoom: 15),
                ),
              );
            },
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              if (finished) {
                setState(() {
                  selectedPoint = cameraPosition.target;
                });
              }
            },
            mapObjects: [
              PlacemarkMapObject(
                mapId: placemarkId,
                point: selectedPoint,
                opacity: 1.0,
                consumeTapEvents: true,
              ),
            ],
          ),
          Center(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 48,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddressBottomSheet(
                    latitude: selectedPoint.latitude,
                    longitude: selectedPoint.longitude,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Add Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
