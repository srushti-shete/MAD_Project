import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class DoctorAppointmentForm extends StatefulWidget {
  @override
  _DoctorAppointmentFormState createState() => _DoctorAppointmentFormState();
}

class _DoctorAppointmentFormState extends State<DoctorAppointmentForm> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void bookAppointment() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Add appointment with user's UID as document ID
        await FirebaseFirestore.instance.collection('Appointments').doc(user.uid).set({
          'patientName': _patientNameController.text,
          'doctor': _doctorController.text,
          'phoneNumber': _phoneNumberController.text,
          'address': _addressController.text,
          'date': _dateController.text,
          'time': _timeController.text,
          'userId': user.uid,
        });
        // Send SMS
        _sendSMS("Dear ${_patientNameController.text}, your appointment with ${_doctorController.text} has been successfully booked for ${_timeController.text} on ${_dateController.text}.", _phoneNumberController.text);
        // Clear text fields
        _patientNameController.clear();
        _doctorController.clear();
        _phoneNumberController.clear();
        _addressController.clear();
        _dateController.clear();
        _timeController.clear();
        _timeController.clear();
        // Closing loading dialog
        Navigator.pop(context);
        // Showing success message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              title: Center(
                child: Text(
                  'Appointment booked successfully',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  void _sendSMS(String message, String recipient) async {
    // Initialize Twilio
    TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'YOUR_TWILIO_ACCOUNT_SID',
      authToken: 'YOUR_TWILIO_AUTH_TOKEN',
      twilioNumber: 'YOUR_TWILIO_PHONE_NUMBER',
    );

    // Send SMS
    try {
      await twilioFlutter.sendSMS(
        toNumber: recipient,
        messageBody: message,
      );
      print('SMS sent successfully');
    } catch (e) {
      print('Failed to send SMS: $e');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Appointment Form',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0, // Remove app bar shadow
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display the image above the form
              Image.asset(
                'lib/images/doc.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20), // Add spacing between the image and form
              // Form fields
              TextFormField(
                controller: _patientNameController,
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _doctorController,
                decoration: InputDecoration(
                  labelText: 'Doctor',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDate != null)
                    _dateController.text =
                    '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null)
                    _timeController.text = pickedTime.format(context);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: bookAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}