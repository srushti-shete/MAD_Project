import 'package:flutter/material.dart';


class DoctorAppointmentForm extends StatefulWidget {
  @override
  _DoctorAppointmentFormState createState() => _DoctorAppointmentFormState();
}

class _DoctorAppointmentFormState extends State<DoctorAppointmentForm> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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
      body: Padding(
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
              onPressed: () {
                String patientName = _patientNameController.text;
                String doctor = _doctorController.text;
                String date = _dateController.text;
                String time = _timeController.text;

                print('Patient Name: $patientName');
                print('Doctor: $doctor');
                print('Date: $date');
                print('Time: $time');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
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
    );
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
