import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// lat long
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nasha mukti"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            // Increased padding to 50.0
            child: Image(image: AssetImage('lib/images/i1.png')),
          ),
          Expanded(

            child: content(),
            // Show the map here
          ),

        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text("Book an appointment"),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 10), // Add some space between the two buttons
          FloatingActionButton.extended(
            onPressed: () {
              // Handle button press
            },
            label: Text("Register as patient"),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

Widget content() {
  height : 300;
  width: 300;
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(19.0760, 72.8777),

      initialZoom: 10.2,
      interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
    ),
    children: [
      openStreetMapTileLayer,
    ],
  );
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);