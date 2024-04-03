import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'DisplayCenters.dart';
import 'DoctorAppointmentForm.dart'; // Import the doc.dart file


class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context); // Pop back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nasha Mukti",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'lib/images/drug.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorAppointmentForm()),
                );
              },
              label: Text(
                "View Appointment",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              icon: Icon(Icons.calendar_today),
            ),
          ),
          SizedBox(height: 10), // Add some space between the two buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayCenters()),
                );
              },
              label: Text(
                "View Rehab Centers",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              icon: Icon(Icons.local_hospital),
            ),
          ),
        ],
      ),
    );
  }
}
