import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// lat long
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';

import 'DisplayCenters.dart';

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
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            // Increased padding to 50.0
            child: Image(image: AssetImage('lib/images/drug.png')),
          ),


        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text("View Appointment"),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 10), // Add some space between the two buttons
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisplayCenters()),
              );
            },
            label: Text("View Rehab Centers"),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
