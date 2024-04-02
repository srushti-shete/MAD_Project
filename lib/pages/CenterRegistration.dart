import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class RehabCenterRegistrationScreen extends StatefulWidget {
  @override
  _RehabCenterRegistrationScreenState createState() => _RehabCenterRegistrationScreenState();
}

class _RehabCenterRegistrationScreenState extends State<RehabCenterRegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _numDoctorsController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  void _registerCenter() async {
    try {
      // Convert address to latitude and longitude
      List<Location> locations = await locationFromAddress(_addressController.text);
      if (locations.isNotEmpty) {
        // Save center details to Firestore
        await _firestore.collection('rehab_centers').add({
          'name': _nameController.text,
          'address': _addressController.text,
          'latitude': locations[0].latitude,
          'longitude': locations[0].longitude,
          'capacity': int.tryParse(_capacityController.text) ?? 0,
          'num_doctors': int.tryParse(_numDoctorsController.text) ?? 0,
          'rating': double.tryParse(_ratingController.text) ?? 0.0,
        });

        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Rehab center registered successfully'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Registration failed
      print('Failed to register rehab center: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register rehab center: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Rehab Center'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _capacityController,
              decoration: InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _numDoctorsController,
              decoration: InputDecoration(labelText: 'Number of Doctors'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerCenter,
              child: Text('Register Center'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RehabCenterRegistrationScreen(),
  ));
}
