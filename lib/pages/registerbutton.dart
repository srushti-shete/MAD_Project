import 'package:flutter/material.dart';
import 'CenterRegistration.dart';
import 'register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.grey[300], // Set scaffold background color to grey
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registration Options'),
        ),
        body: Center(
          child: RegisterButton(),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RehabCenterRegistrationScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Set background color of the button to blue
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Set padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Set border radius
            ),
          ),
          child: Text(
            'Register Rehab Center',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage(onTap: () {  },)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Set background color of the button to green
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Set padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Set border radius
            ),
          ),
          child: Text(
            'Register User',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
