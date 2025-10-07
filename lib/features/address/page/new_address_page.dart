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
  Point selectedPoint = const Point(latitude: 41.311151, longitude: 69.279737);
  final MapObjectId placemarkId = const MapObjectId('selected_placemark');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Address"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
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
        child: Stack(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 48,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
