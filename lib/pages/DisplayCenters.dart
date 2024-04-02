import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' show cos, sqrt, asin, pow, pi;

class DisplayCenters extends StatefulWidget {
  @override
  _DisplayCentersState createState() => _DisplayCentersState();
}

class _DisplayCentersState extends State<DisplayCenters> {
  LocationData? _currentLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      _currentLocation = await location.getLocation();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rehab Centers'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rehab_centers')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          // Filter centers within 100 km radius
          List<DocumentSnapshot> centers = snapshot.data!.docs;
          List<DocumentSnapshot> nearbyCenters = [];
          centers.forEach((center) {

            dynamic latitudeData = center['latitude'];
            dynamic longitudeData = center['longitude'];

            double latitude = latitudeData is String ? double.parse(latitudeData) : latitudeData;
            double longitude = longitudeData is String ? double.parse(longitudeData) : longitudeData;

            double distance = _calculateDistance(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
                latitude,
                longitude);
            if (distance <= 100) {
              nearbyCenters.add(center);
            }
          });

          return ListView.builder(
            itemCount: nearbyCenters.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = nearbyCenters[index];
              Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CenterDetails(
                        data: data,
                        currentLocation: _currentLocation,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  double _calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    const double radius = 6371.0; // Earth's radius in kilometers

    double x = _toRadians(endLng - startLng) * cos(_toRadians((startLat + endLat) / 2));
    double y = _toRadians(endLat - startLat);

    // Use Pythagoras' theorem to calculate the straight-line distance
    double distance = sqrt(x * x + y * y) * radius;

    return distance;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }
}

class CenterDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  final LocationData? currentLocation;

  CenterDetails({required this.data, required this.currentLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: CenterDetailsBody(
        data: data,
        currentLocation: currentLocation,
      ),
    );
  }
}

class CenterDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  final LocationData? currentLocation;

  CenterDetailsBody({required this.data, required this.currentLocation});

  Future<Widget> getOpenStreetMapTileLayer() async {
    final tileLayer = TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
    return tileLayer;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getOpenStreetMapTileLayer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final tileLayer = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(data['latitude'], data['longitude']),
                  zoom: 15.0,
                  interactionOptions:
                  const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
                ),
                children: [
                  tileLayer,
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(data['latitude'], data['longitude']),
                        child: Icon(Icons.location_on, color: Colors.red),
                      ),
                      if (currentLocation != null)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                          child: Icon(Icons.person_pin, color: Colors.blue),
                        ),
                    ],
                  ),
                  if (currentLocation != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [
                            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//                             LatLng(data['latitude'], data['longitude']),
                          ],
                          color: Colors.green,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${data['name']}'),
                    Text('Address: ${data['address']}'),
                    Text('Capacity: ${data['capacity']}'),
                    Text('Number of Doctors: ${data['num_doctors']}'),
                    Text('Ratings: ${data['rating']}'),
                    ElevatedButton(
                      onPressed: () {  },
                      child: Text('Book an Appointment'),
                    ),
                  ],

                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

